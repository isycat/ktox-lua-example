-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/ControlFlowDemo.kt", {["1-15"]=1,["16"]=17,["17"]=18,["18-19"]=19,["20"]=21,["21"]=22,["22-23"]=23,["24"]=26,["25-28"]=27,["29"]=32,["30"]=34,["31-32"]=35,["33"]=38,["34-35"]=39,["36"]=42,["37-38"]=43,["39"]=46,["40"]=47,["41"]=48,["42-43"]=49,["44-47"]=51,["48"]=55,["49"]=56,["50-52"]=57})

ControlFlowDemo = {}
ControlFlowDemo.__index = ControlFlowDemo

function ControlFlowDemo:new()
    local self = setmetatable({}, ControlFlowDemo)
    return self
end


function demoControlFlow()
    local sum = 0
    for i = 1, 5 do
        sum = ktox_plusAssign(sum, i)
    end
    local x = 10
    while x > 5 do
        x = x - 1
    end
    local result = (sum == 15 and sum + x or 0)
    return result
end

function demoRanges()
    local total = 0
    for i = 0, 5 - 1 do
        total = ktox_plusAssign(total, i)
    end
    for i = 5, 1, -1 do
        total = ktox_plusAssign(total, i)
    end
    for i = 0, 4, 2 do
        total = ktox_plusAssign(total, i)
    end
    local lo = 1
    local hi = 3
    for i = lo, hi do
        total = ktox_plusAssign(total, i)
    end
    return total
end

function demoStringTemplate()
    local lang = "Lua"
    local version = 5
    return "Running on " .. tostring(lang) .. " " .. tostring(version + 0)
end

