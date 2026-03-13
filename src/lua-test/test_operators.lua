-- test_operators.lua
-- Tests for operator and control-flow features not covered by other test files.
-- Covers: compound assignment (+=,-=,*=,/=,%=), pre/post increment/decrement,
--         unary (-x, !x), boolean (&&, ||), inequality (!=), modulo (%),
--         do-while (repeat…until), break, for-over-list (ipairs),
--         Elvis ?: without null-safe chain, in/!in range expressions,
--         and destructuring for loop over a map.

require("ktox-lib")
ktox_require("features/OperatorsDemo")

-- ─── Compound assignment ──────────────────────────────────────────────────────

ktox_test("demoCompoundAssignment() returns 24 (10 +=5 -=3 *=2)", function()
    ktox_assert_eq(demoCompoundAssignment(), 24)
end)

ktox_test("demoDivMod() returns 7 (20/=4 gives 5, 17%=5 gives 2, sum=7)", function()
    -- Lua uses float division: 20/4 = 5.0; 5.0+2.0 == 7 is true in LuaJ
    ktox_assert_eq(demoDivMod(), 7)
end)

-- ─── Increment / Decrement ────────────────────────────────────────────────────

ktox_test("demoPostIncDec() returns 6 (5 ++ ++ -- = 6)", function()
    ktox_assert_eq(demoPostIncDec(), 6)
end)

ktox_test("demoPreIncDec() returns 1 (0 ++ ++ -- = 1)", function()
    ktox_assert_eq(demoPreIncDec(), 1)
end)

-- ─── Unary operators ─────────────────────────────────────────────────────────

ktox_test("demoUnary() returns 3 (neg=-7, !false is true, -7+10=3)", function()
    ktox_assert_eq(demoUnary(), 3)
end)

-- ─── Boolean operators ───────────────────────────────────────────────────────

ktox_test("demoBooleans() returns 4 (T&&T=T, T&&F=F, F||T=T, F||F=F)", function()
    ktox_assert_eq(demoBooleans(), 4)
end)

-- ─── Inequality ──────────────────────────────────────────────────────────────

ktox_test("demoInequality() returns 2 (5!=3 true, 5!=5 false)", function()
    ktox_assert_eq(demoInequality(), 2)
end)

-- ─── Modulo ──────────────────────────────────────────────────────────────────

ktox_test("demoModulo() returns 3 (17%5=2, 10%3=1, sum=3)", function()
    ktox_assert_eq(demoModulo(), 3)
end)

-- ─── do-while (repeat…until) ─────────────────────────────────────────────────

ktox_test("demoDoWhile() returns 5 (n++ until n>=5)", function()
    ktox_assert_eq(demoDoWhile(), 5)
end)

-- ─── break ───────────────────────────────────────────────────────────────────

ktox_test("demoBreak() returns 4 (exits loop when i==4)", function()
    ktox_assert_eq(demoBreak(), 4)
end)

-- ─── for over list (ipairs) ──────────────────────────────────────────────────

ktox_test("demoForList() returns 100 (sum of {10,20,30,40})", function()
    ktox_assert_eq(demoForList(), 100)
end)

-- ─── Elvis ?: without null-safe chain ────────────────────────────────────────

ktox_test("demoElvisStandalone() returns 41 (nil?:-1 + 42?:-1 = -1+42)", function()
    ktox_assert_eq(demoElvisStandalone(), 41)
end)

-- ─── in / !in range expressions ──────────────────────────────────────────────

ktox_test("demoInRangeExpression() returns 2 (5 in 1..10, 5 !in 1..4)", function()
    ktox_assert_eq(demoInRangeExpression(), 2)
end)

-- ─── Destructuring for loop ──────────────────────────────────────────────────

ktox_test("demoDestructuringFor() returns 60 (sum of map values 10+20+30)", function()
    ktox_assert_eq(demoDestructuringFor(), 60)
end)

-- ─── Inline operator sanity checks (direct Lua, no Kotlin wrapper) ────────────

ktox_test("compound += works on a local variable", function()
    local x = 5
    x = x + 3   -- += 3
    ktox_assert_eq(x, 8)
end)

ktox_test("post-increment pattern increments correctly", function()
    local n = 0
    n = n + 1
    n = n + 1
    ktox_assert_eq(n, 2)
end)

ktox_test("repeat…until exits after correct iterations", function()
    local count = 0
    repeat
        count = count + 1
    until not (count < 3)
    ktox_assert_eq(count, 3)
end)

ktox_test("break exits loop at the right iteration", function()
    local stopped_at = 0
    for i = 1, 100 do
        if i == 7 then
            stopped_at = i
            break
        end
    end
    ktox_assert_eq(stopped_at, 7)
end)

ktox_test("ipairs iterates list in order", function()
    local seen = {}
    for _, v in ipairs({10, 20, 30}) do
        seen[#seen + 1] = v
    end
    ktox_assert_eq(seen[1], 10)
    ktox_assert_eq(seen[2], 20)
    ktox_assert_eq(seen[3], 30)
end)
