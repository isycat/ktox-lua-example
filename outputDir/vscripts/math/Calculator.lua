-- package: com.example.math

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "math/Calculator.kt", {["1-22"]=1})

Calculator = {}
Calculator.__index = Calculator

function Calculator:new()
    local self = setmetatable({}, Calculator)
    return self
end

function Calculator:add(a, b)
    return a + b
end

function Calculator:multiply(a, b)
    return a * b
end


