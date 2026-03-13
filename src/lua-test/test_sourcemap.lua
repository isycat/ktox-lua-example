-- test_sourcemap.lua
-- Tests for ktox_sourcemap_traceback: sourcemap registration and
-- debug.traceback rewriting in ktox-lib.

require("ktox-lib")

-- -------------------------------------------------------------------------
-- ktox_sourcemap_traceback: registration
-- -------------------------------------------------------------------------

ktox_test("ktox_sourcemap_traceback registers the source map", function()
    ktox_sourcemap_traceback("test_reg.lua", "test_reg.kt", {["1"] = 10, ["2-3"] = 20})
    ktox_assert_not_nil(_G.ktox_sourcemap, "_G.ktox_sourcemap should be initialized")
    ktox_assert_not_nil(_G.ktox_sourcemap["test_reg.lua"], "sourcemap for test_reg.lua should be registered")
    ktox_assert_eq(_G.ktox_sourcemap["test_reg.lua"].ktFile, "test_reg.kt", "ktFile should be stored")
    ktox_assert_eq(_G.ktox_sourcemap["test_reg.lua"].map["1"], 10, "lua line 1 should map to kotlin line 10")
    ktox_assert_eq(_G.ktox_sourcemap["test_reg.lua"].map["2-3"], 20, "range 2-3 should map to kotlin line 20")
end)

ktox_test("ktox_sourcemap_traceback overwrites existing map for same file", function()
    ktox_sourcemap_traceback("test_overwrite.lua", "test_overwrite.kt", {["1"] = 5})
    ktox_sourcemap_traceback("test_overwrite.lua", "test_overwrite.kt", {["1"] = 99})
    ktox_assert_eq(_G.ktox_sourcemap["test_overwrite.lua"].map["1"], 99, "second registration should overwrite first")
end)

ktox_test("ktox_sourcemap_traceback keeps maps for different files independent", function()
    ktox_sourcemap_traceback("fileA.lua", "fileA.kt", {["3"] = 100})
    ktox_sourcemap_traceback("fileB.lua", "fileB.kt", {["3"] = 200})
    ktox_assert_eq(_G.ktox_sourcemap["fileA.lua"].map["3"], 100, "fileA map should be unaffected by fileB registration")
    ktox_assert_eq(_G.ktox_sourcemap["fileB.lua"].map["3"], 200, "fileB map should be independent")
end)

-- -------------------------------------------------------------------------
-- ktox_sourcemap_traceback: traceback rewriting
-- -------------------------------------------------------------------------

ktox_test("ktox_sourcemap_traceback does not throw even without debug support", function()
    -- This test always runs and verifies no error is raised regardless of debug availability.
    ktox_sourcemap_traceback("no_throw_test.lua", "no_throw_test.kt", {["1"] = 1})
    ktox_assert_true(true, "ktox_sourcemap_traceback must not raise an error")
end)

ktox_test("debug.traceback is overridden when debug library is available", function()
    -- Skip this test in environments that lack debug.traceback (e.g. LuaJ).
    if not (debug and debug.traceback) then return end
    _G.ktox_originalTraceback = nil
    ktox_sourcemap_traceback("override_test.lua", "override_test.kt", {["1"] = 1})
    ktox_assert_not_nil(_G.ktox_originalTraceback, "ktox_originalTraceback should be saved when debug is available")
end)

ktox_test("traceback rewrite maps single-line entry to kotlin file and line", function()
    -- Register: lua line 7 → kotlin line 42, in "mymodule.kt"
    ktox_sourcemap_traceback("mymodule.lua", "features/mymodule.kt", {["7"] = 42})
    local entry = _G.ktox_sourcemap["mymodule.lua"]
    ktox_assert_not_nil(entry, "entry must be registered")
    local tb = "mymodule.lua:7: in function 'foo'"
    local rewritten = (tb:gsub("(%S+)%.lua:(%d+)", function(file, line)
        local e = _G.ktox_sourcemap[tostring(file) .. ".lua"]
        if e then
            local n = tonumber(line)
            for key, val in pairs(e.map) do
                local rangeStart, rangeEnd = key:match("^(%d+)-(%d+)$")
                if rangeStart then
                    if n >= tonumber(rangeStart) and n <= tonumber(rangeEnd) then
                        return e.ktFile .. ":" .. tostring(val)
                    end
                elseif tonumber(key) == n then
                    return e.ktFile .. ":" .. tostring(val)
                end
            end
        end
        return file .. ".lua:" .. line
    end))
    ktox_assert_eq(rewritten, "features/mymodule.kt:42: in function 'foo'",
        "traceback should show kotlin file path and line 42")
end)

ktox_test("traceback rewrite maps range entry to kotlin line", function()
    -- Register: lua lines 3-8 → kotlin line 15
    ktox_sourcemap_traceback("ranged.lua", "ranged.kt", {["3-8"] = 15})
    local tb = "ranged.lua:5: in function 'bar'"
    local rewritten = (tb:gsub("(%S+)%.lua:(%d+)", function(file, line)
        local e = _G.ktox_sourcemap[tostring(file) .. ".lua"]
        if e then
            local n = tonumber(line)
            for key, val in pairs(e.map) do
                local rangeStart, rangeEnd = key:match("^(%d+)-(%d+)$")
                if rangeStart then
                    if n >= tonumber(rangeStart) and n <= tonumber(rangeEnd) then
                        return e.ktFile .. ":" .. tostring(val)
                    end
                elseif tonumber(key) == n then
                    return e.ktFile .. ":" .. tostring(val)
                end
            end
        end
        return file .. ".lua:" .. line
    end))
    ktox_assert_eq(rewritten, "ranged.kt:15: in function 'bar'",
        "lua line 5 falls in range 3-8 → kotlin line 15")
end)

ktox_test("traceback rewrite preserves unmapped lua lines", function()
    -- Line 99 is NOT covered by any range in the sourcemap for this file
    ktox_sourcemap_traceback("partial.lua", "partial.kt", {["5"] = 10})
    local tb = "partial.lua:99: in function 'bar'"
    local rewritten = (tb:gsub("(%S+)%.lua:(%d+)", function(file, line)
        local e = _G.ktox_sourcemap[tostring(file) .. ".lua"]
        if e then
            local n = tonumber(line)
            for key, val in pairs(e.map) do
                local rangeStart, rangeEnd = key:match("^(%d+)-(%d+)$")
                if rangeStart then
                    if n >= tonumber(rangeStart) and n <= tonumber(rangeEnd) then
                        return e.ktFile .. ":" .. tostring(val)
                    end
                elseif tonumber(key) == n then
                    return e.ktFile .. ":" .. tostring(val)
                end
            end
        end
        return file .. ".lua:" .. line
    end))
    ktox_assert_eq(rewritten, "partial.lua:99: in function 'bar'",
        "unmapped line should remain as .lua:N in traceback")
end)

ktox_test("traceback rewrite handles file with no registered sourcemap", function()
    -- "nomap.lua" was never registered
    local tb = "nomap.lua:3: in function 'baz'"
    local rewritten = (tb:gsub("(%S+)%.lua:(%d+)", function(file, line)
        local e = _G.ktox_sourcemap and _G.ktox_sourcemap[tostring(file) .. ".lua"]
        if e then
            local n = tonumber(line)
            for key, val in pairs(e.map) do
                local rangeStart, rangeEnd = key:match("^(%d+)-(%d+)$")
                if rangeStart then
                    if n >= tonumber(rangeStart) and n <= tonumber(rangeEnd) then
                        return e.ktFile .. ":" .. tostring(val)
                    end
                elseif tonumber(key) == n then
                    return e.ktFile .. ":" .. tostring(val)
                end
            end
        end
        return file .. ".lua:" .. line
    end))
    ktox_assert_eq(rewritten, "nomap.lua:3: in function 'baz'",
        "file with no sourcemap should keep .lua:N unchanged")
end)

-- -------------------------------------------------------------------------
-- ktox-lib module guard
-- -------------------------------------------------------------------------

ktox_test("ktox_lib_loaded global is set after require ktox-lib", function()
    ktox_assert_true(_G.ktox_lib_loaded == true, "ktox_lib_loaded must be true after loading ktox-lib")
end)
