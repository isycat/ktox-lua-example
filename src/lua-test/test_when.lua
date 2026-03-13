-- test_when.lua
-- Tests for all when-expression variants: subject match, no-subject, ranges,
-- expression form, and multi-condition branches.

require("ktox-lib")
ktox_require("features/Shapes")

-- demoWhen: when with subject (equality + multi-condition branch)
ktox_test("demoWhen(1) returns 'one'", function()
    ktox_assert_eq(demoWhen(1), "one")
end)

ktox_test("demoWhen(2) returns 'two'", function()
    ktox_assert_eq(demoWhen(2), "two")
end)

ktox_test("demoWhen(3) returns 'three'", function()
    ktox_assert_eq(demoWhen(3), "three")
end)

ktox_test("demoWhen(4) returns 'four-to-six' (multi-condition branch)", function()
    ktox_assert_eq(demoWhen(4), "four-to-six")
end)

ktox_test("demoWhen(6) returns 'four-to-six'", function()
    ktox_assert_eq(demoWhen(6), "four-to-six")
end)

ktox_test("demoWhen(7) returns 'other'", function()
    ktox_assert_eq(demoWhen(7), "other")
end)

-- demoWhenV2: when without subject (each branch is a boolean condition)
ktox_test("demoWhenV2(1) returns 'one'", function()
    ktox_assert_eq(demoWhenV2(1), "one")
end)

ktox_test("demoWhenV2(5) returns 'four-to-six' (n in 4..6)", function()
    ktox_assert_eq(demoWhenV2(5), "four-to-six")
end)

ktox_test("demoWhenV2(10) returns 'other'", function()
    ktox_assert_eq(demoWhenV2(10), "other")
end)

-- demoWhenExpression: when as an expression returning a value
ktox_test("demoWhenExpression(1) returns 'one'", function()
    ktox_assert_eq(demoWhenExpression(1), "one")
end)

ktox_test("demoWhenExpression(2) returns 'two'", function()
    ktox_assert_eq(demoWhenExpression(2), "two")
end)

ktox_test("demoWhenExpression(99) returns 'other'", function()
    ktox_assert_eq(demoWhenExpression(99), "other")
end)

-- demoWhenNoSubject: when without a subject (label checks)
ktox_test("demoWhenNoSubject(200) returns 'huge'", function()
    ktox_assert_eq(demoWhenNoSubject(200), "huge")
end)

ktox_test("demoWhenNoSubject(50) returns 'big'", function()
    ktox_assert_eq(demoWhenNoSubject(50), "big")
end)

ktox_test("demoWhenNoSubject(5) returns 'positive'", function()
    ktox_assert_eq(demoWhenNoSubject(5), "positive")
end)

ktox_test("demoWhenNoSubject(0) returns 'non-positive'", function()
    ktox_assert_eq(demoWhenNoSubject(0), "non-positive")
end)

-- demoWhenRange: when with in-range and !in conditions
ktox_test("demoWhenRange(2) returns 'low' (in 1..3)", function()
    ktox_assert_eq(demoWhenRange(2), "low")
end)

ktox_test("demoWhenRange(5) returns 'mid' (in 4 until 8)", function()
    ktox_assert_eq(demoWhenRange(5), "mid")
end)

ktox_test("demoWhenRange(20) returns 'out' (!in 1..10)", function()
    ktox_assert_eq(demoWhenRange(20), "out")
end)

ktox_test("demoWhenRange(9) returns 'high' (in 8..10, else branch)", function()
    ktox_assert_eq(demoWhenRange(9), "high")
end)
