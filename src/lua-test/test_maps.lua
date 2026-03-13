-- test_maps.lua
-- Tests for Kotlin map functions transpiled to ktox-lib map helpers.
-- Covers: containsKey, containsValue, getOrDefault, getOrElse, keys, values,
--         mapValues, mapKeys, filterKeys, filterValues, toMap, forEach,
--         filter (map), any/all/none, count, isEmpty/isNotEmpty/isNullOrEmpty,
--         getOrPut, plus (map), minus (map), putAll, contains (in operator),
--         plusAssign (+=), minusAssign (-=), ktox_mapPlus edge cases.

require("ktox-lib")
ktox_require("features/MapDemo")

-- Full integration test
ktox_test("demoMaps() returns 67", function()
    ktox_assert_eq(demoMaps(), 67)
end)

-- plusAssign / minusAssign on maps
ktox_test("demoMapPlusAssign() returns 7", function()
    ktox_assert_eq(demoMapPlusAssign(), 7)
end)

-- Individual helpers ---------------------------------------------------------

ktox_test("ktox_containsKey detects existing key", function()
    local m = {["a"] = 1, ["b"] = 2}
    ktox_assert_true(ktox_containsKey(m, "a"))
    ktox_assert_false(ktox_containsKey(m, "z"))
end)

ktox_test("ktox_containsValue detects existing value", function()
    local m = {["a"] = 10, ["b"] = 20}
    ktox_assert_true(ktox_containsValue(m, 10))
    ktox_assert_false(ktox_containsValue(m, 99))
end)

ktox_test("ktox_getOrDefault returns value when key present", function()
    local m = {["x"] = 42}
    ktox_assert_eq(ktox_getOrDefault(m, "x", 0), 42)
end)

ktox_test("ktox_getOrDefault returns default when key absent", function()
    local m = {["x"] = 42}
    ktox_assert_eq(ktox_getOrDefault(m, "y", 99), 99)
end)

ktox_test("ktox_getOrElse returns value when key present", function()
    local m = {["x"] = 5}
    ktox_assert_eq(ktox_getOrElse(m, "x", function() return -1 end), 5)
end)

ktox_test("ktox_getOrElse calls fn when key absent", function()
    local m = {}
    ktox_assert_eq(ktox_getOrElse(m, "missing", function() return -1 end), -1)
end)

ktox_test("ktox_mapValues transforms values", function()
    local m = {["a"] = 1, ["b"] = 2}
    local doubled = ktox_mapValues(m, function(k, v) return v * 2 end)
    ktox_assert_eq(doubled["a"], 2)
    ktox_assert_eq(doubled["b"], 4)
end)

ktox_test("ktox_mapKeys transforms keys", function()
    local m = {["x"] = 1}
    local result = ktox_mapKeys(m, function(k, v) return k .. "_new" end)
    ktox_assert_eq(result["x_new"], 1)
    ktox_assert_nil(result["x"])
end)

ktox_test("ktox_filterKeys removes excluded keys", function()
    local m = {["a"] = 1, ["b"] = 2, ["c"] = 3}
    local result = ktox_filterKeys(m, function(k) return k ~= "b" end)
    ktox_assert_nil(result["b"])
    ktox_assert_not_nil(result["a"])
    ktox_assert_not_nil(result["c"])
end)

ktox_test("ktox_filterValues keeps only high values", function()
    local m = {["alice"] = 10, ["bob"] = 20, ["carol"] = 15}
    local result = ktox_filterValues(m, function(v) return v >= 15 end)
    ktox_assert_nil(result["alice"])
    ktox_assert_not_nil(result["bob"])
    ktox_assert_not_nil(result["carol"])
end)

ktox_test("ktox_isEmpty returns true for empty map", function()
    ktox_assert_true(ktox_isEmpty({}))
    ktox_assert_false(ktox_isEmpty({["a"] = 1}))
end)

ktox_test("ktox_isNotEmpty returns true for non-empty map", function()
    ktox_assert_true(ktox_isNotEmpty({["a"] = 1}))
    ktox_assert_false(ktox_isNotEmpty({}))
end)

ktox_test("ktox_isNullOrEmpty returns true for nil", function()
    ktox_assert_true(ktox_isNullOrEmpty(nil))
end)

ktox_test("ktox_isNullOrEmpty returns true for empty map", function()
    ktox_assert_true(ktox_isNullOrEmpty({}))
end)

ktox_test("ktox_getOrPut returns existing value without calling fn", function()
    local m = {["x"] = 7}
    local result = ktox_getOrPut(m, "x", function() return 99 end)
    ktox_assert_eq(result, 7)
end)

ktox_test("ktox_getOrPut inserts and returns new value when absent", function()
    local m = {}
    local result = ktox_getOrPut(m, "y", function() return 42 end)
    ktox_assert_eq(result, 42)
    ktox_assert_eq(m["y"], 42)
end)

ktox_test("ktox_plus merges two maps (right-hand entries win)", function()
    local a = {["x"] = 1, ["y"] = 2}
    local b = {["y"] = 99, ["z"] = 3}
    local result = ktox_plus(a, b)
    ktox_assert_eq(result["x"], 1)
    ktox_assert_eq(result["y"], 99)
    ktox_assert_eq(result["z"], 3)
end)

ktox_test("ktox_minus removes a key from a map", function()
    local m = {["a"] = 1, ["b"] = 2}
    local result = ktox_minus(m, "b")
    ktox_assert_nil(result["b"])
    ktox_assert_eq(result["a"], 1)
end)

ktox_test("ktox_putAll copies entries from another map", function()
    local m = {["a"] = 1}
    ktox_putAll(m, {["b"] = 2, ["c"] = 3})
    ktox_assert_eq(m["b"], 2)
    ktox_assert_eq(m["c"], 3)
end)

ktox_test("ktox_mapAny detects entry matching predicate", function()
    local m = {["alice"] = 10, ["bob"] = 20}
    ktox_assert_true(ktox_mapAny(m, function(k, v) return v > 15 end))
    ktox_assert_false(ktox_mapAny(m, function(k, v) return v > 100 end))
end)

ktox_test("ktox_mapAll requires all entries to match", function()
    local m = {["a"] = 5, ["b"] = 10}
    ktox_assert_true(ktox_mapAll(m, function(k, v) return v > 0 end))
    ktox_assert_false(ktox_mapAll(m, function(k, v) return v > 5 end))
end)

ktox_test("ktox_mapNone returns true when no entry matches", function()
    local m = {["a"] = 1, ["b"] = 2}
    ktox_assert_true(ktox_mapNone(m, function(k, v) return v < 0 end))
end)

ktox_test("ktox_mapCount counts total entries and matching entries", function()
    local m = {["a"] = 1, ["b"] = 2, ["c"] = 3}
    ktox_assert_eq(ktox_mapCount(m), 3)
    ktox_assert_eq(ktox_mapCount(m, function(k, v) return v > 1 end), 2)
end)

ktox_test("ktox_toMap returns a shallow copy of the map", function()
    local m = {["a"] = 1, ["b"] = 2}
    local copy = ktox_toMap(m)
    ktox_assert_eq(copy["a"], 1)
    ktox_assert_eq(copy["b"], 2)
end)

-- ktox_plusAssign / ktox_minusAssign ------------------------------------------

ktox_test("ktox_plusAssign on a non-empty map merges a pair into the map", function()
    local m = {["a"] = 1}
    m = ktox_plusAssign(m, {"b", 2})
    ktox_assert_eq(m["a"], 1)
    ktox_assert_eq(m["b"], 2)
end)

ktox_test("ktox_plusAssign on a non-empty map merges another map", function()
    local m = {["a"] = 1}
    m = ktox_plusAssign(m, {["b"] = 2, ["c"] = 3})
    ktox_assert_eq(m["a"], 1)
    ktox_assert_eq(m["b"], 2)
    ktox_assert_eq(m["c"], 3)
end)

ktox_test("ktox_plusAssign on an empty table with a string-keyed map acts as map merge", function()
    local m = {}
    m = ktox_plusAssign(m, {["x"] = 10})
    ktox_assert_eq(m["x"], 10)
end)

ktox_test("ktox_minusAssign on a map removes the given key", function()
    local m = {["a"] = 1, ["b"] = 2}
    m = ktox_minusAssign(m, "a")
    ktox_assert_nil(m["a"])
    ktox_assert_eq(m["b"], 2)
end)

ktox_test("ktox_minusAssign on a number performs arithmetic subtraction", function()
    local x = 10
    x = ktox_minusAssign(x, 3)
    ktox_assert_eq(x, 7)
end)

ktox_test("ktox_plusAssign on a number performs arithmetic addition", function()
    local x = 5
    x = ktox_plusAssign(x, 4)
    ktox_assert_eq(x, 9)
end)

-- ktox_plus edge case: empty map + non-empty map --------------------------------

ktox_test("ktox_plus with empty left and string-keyed right merges correctly", function()
    local result = ktox_plus({}, {["key"] = 42})
    ktox_assert_eq(result["key"], 42)
end)

ktox_test("ktox_mapPlus on empty left map merges pair correctly", function()
    local result = ktox_mapPlus({}, {"newKey", 99})
    ktox_assert_eq(result["newKey"], 99)
end)

