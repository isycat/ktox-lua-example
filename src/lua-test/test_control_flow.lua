-- test_control_flow.lua
-- Tests for control-flow constructs: for/while loops, if-expression, ranges,
-- and string templates.

require("ktox-lib")
ktox_require("features/ControlFlowDemo")

-- demoControlFlow: for loop, while loop, if-expression
ktox_test("demoControlFlow() returns 20", function()
    -- sum(1..5)=15, while x>5: x goes 10→5, result = if(15==15) 15+5 else 0 = 20
    ktox_assert_eq(demoControlFlow(), 20)
end)

-- demoRanges: until, downTo, step, variable bounds
ktox_test("demoRanges() returns 37", function()
    -- until 5: 0+1+2+3+4=10
    -- downTo 1 from 5: 5+4+3+2+1=15
    -- step 2, 0..4: 0+2+4=6
    -- lo=1..hi=3: 1+2+3=6
    -- total = 10+15+6+6 = 37
    ktox_assert_eq(demoRanges(), 37)
end)

-- demoStringTemplate: string with embedded variable and expression
ktox_test("demoStringTemplate() returns 'Running on Lua 5'", function()
    ktox_assert_eq(demoStringTemplate(), "Running on Lua 5")
end)
