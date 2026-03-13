-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/OperatorsDemo.kt", {["1-15"]=1,["16"]=13,["17"]=14,["18"]=15,["19"]=16,["20-23"]=17,["24"]=22,["25"]=23,["26"]=24,["27"]=25,["28-31"]=26,["32"]=31,["33"]=32,["34"]=33,["35"]=34,["36-39"]=35,["40"]=40,["41"]=41,["42"]=42,["43"]=43,["44-47"]=44,["48"]=49,["49"]=50,["50"]=51,["51"]=52,["52-55"]=53,["56"]=58,["57"]=59,["58"]=60,["59"]=61,["60-63"]=62,["64"]=68,["65"]=69,["66"]=70,["67"]=71,["68-71"]=72,["72"]=77,["73"]=78,["74-77"]=79,["78"]=84,["79"]=85,["80-81"]=86,["82-85"]=88,["86"]=93,["87"]=94,["88"]=95,["89"]=96,["90-92"]=97,["93-96"]=100,["97"]=105,["98"]=106,["99"]=107,["100-101"]=108,["102-105"]=110,["106"]=115,["107"]=116,["108"]=117,["109"]=118,["110-113"]=119,["114"]=124,["115"]=125,["116"]=126,["117-120"]=127,["121"]=132,["122"]=133,["123"]=134,["124-125"]=135,["126-128"]=137})

OperatorsDemo = {}
OperatorsDemo.__index = OperatorsDemo

function OperatorsDemo:new()
    local self = setmetatable({}, OperatorsDemo)
    return self
end


function demoCompoundAssignment()
    local x = 10
    x = ktox_plusAssign(x, 5)
    x = ktox_minusAssign(x, 3)
    x = x * 2
    return x
end

function demoDivMod()
    local a = 20
    a = a / 4
    local b = 17
    b = b % 5
    return a + b
end

function demoPostIncDec()
    local a = 5
    a = a + 1
    a = a + 1
    a = a - 1
    return a
end

function demoPreIncDec()
    local b = 0
    b = b + 1
    b = b + 1
    b = b - 1
    return b
end

function demoUnary()
    local pos = 7
    local neg = -pos
    local t = true
    local f = not t
    return (not f and neg + 10 or 0)
end

function demoBooleans()
    local tt = true and true
    local tf = true and false
    local ft = false or true
    local ff = false or false
    return ((tt and 1 or 0)) + ((tf and 0 or 1)) + ((ft and 1 or 0)) + ((ff and 0 or 1))
end

function demoInequality()
    local x = 5
    local y = 3
    local ne = x ~= y
    local eq = x ~= x
    return ((ne and 1 or 0)) + ((eq and 0 or 1))
end

function demoModulo()
    local a = 17 % 5
    local b = 10 % 3
    return a + b
end

function demoDoWhile()
    local n = 0
    repeat
        n = n + 1
    until not (n < 5)
    return n
end

function demoBreak()
    local found = 0
    for i = 1, 10 do
        if i == 4 then
            found = i
            break
        end
    end
    return found
end

function demoForList()
    local items = {10, 20, 30, 40}
    local total = 0
    for _, item in ipairs(items) do
        total = ktox_plusAssign(total, item)
    end
    return total
end

function demoElvisStandalone()
    local a = nil
    local b = 42
    local ra = ktox_elvis(a, -1)
    local rb = ktox_elvis(b, -1)
    return ra + rb
end

function demoInRangeExpression()
    local x = 5
    local inRange = (x >= 1 and x <= 10)
    local notIn = not (x >= 1 and x <= 4)
    return ((inRange and 1 or 0)) + ((notIn and 1 or 0))
end

function demoDestructuringFor()
    local scores = {["a"] = 10, ["b"] = 20, ["c"] = 30}
    local total = 0
    for k, v in pairs(scores) do
        total = ktox_plusAssign(total, v)
    end
    return total
end

