-- test_null_safety.lua
-- Tests for null-safe operators (?. and ?:) and scope functions
-- (also, let, takeIf).

require("ktox-lib")
ktox_require("features/NullSafetyDemo")

-- demoNullSafety: ?. chain and ?: Elvis operator
ktox_test("demoNullSafety() returns -10", function()
    -- resultA: calc not nil → add(3,7) = 10
    -- resultB: calc = nil  → ?: -1     = -1
    -- return 10 * -1 = -10
    ktox_assert_eq(demoNullSafety(), -10)
end)

-- demoScopeFunctions: also, let (with implicit + named param), takeIf
ktox_test("demoScopeFunctions() returns 19", function()
    -- base=5, logged=5, doubled=10, tripled=20
    -- positive=20 (20>0), negative=nil (20<0 is false), safe=nil
    -- return (20 or 0) + (nil ?: -1) + (nil==nil → 0) = 20-1+0 = 19
    ktox_assert_eq(demoScopeFunctions(), 19)
end)
