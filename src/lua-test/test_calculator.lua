-- test_calculator.lua
-- Tests for the Calculator class (basic class instantiation and method calls).

require("ktox-lib")
ktox_require("math/Calculator")

ktox_test("Calculator:add(2, 3) returns 5", function()
    local calc = Calculator:new()
    ktox_assert_eq(calc:add(2, 3), 5)
end)

ktox_test("Calculator:add(-1, 1) returns 0", function()
    local calc = Calculator:new()
    ktox_assert_eq(calc:add(-1, 1), 0)
end)

ktox_test("Calculator:multiply(4, 5) returns 20", function()
    local calc = Calculator:new()
    ktox_assert_eq(calc:multiply(4, 5), 20)
end)

ktox_test("Calculator:multiply(0, 100) returns 0", function()
    local calc = Calculator:new()
    ktox_assert_eq(calc:multiply(0, 100), 0)
end)

ktox_test("Multiple Calculator instances are independent", function()
    local c1 = Calculator:new()
    local c2 = Calculator:new()
    ktox_assert_eq(c1:add(1, 2), c2:add(1, 2))
end)
