-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/NullSafetyDemo.kt", {["1-16"]=1,["17"]=20,["18-20"]=21,["21-31"]=23,["32"]=24,["33"]=25,["34"]=26,["35-38"]=27,["39"]=33,["40-47"]=34,["48-55"]=37,["56-63"]=40,["64-71"]=43,["72-79"]=44,["80"]=47,["81-88"]=48,["89-91"]=50})
ktox_require("math/Calculator")

NullSafetyDemo = {}
NullSafetyDemo.__index = NullSafetyDemo

function NullSafetyDemo:new()
    local self = setmetatable({}, NullSafetyDemo)
    return self
end


function demoNullSafety()
    local calc = nil
    if 1 > 0.0 then
        calc = Calculator:new()
    end
    local testMe = function()
        do
            local __t0 = calc
            local __t1 = (__t0 ~= nil) and __t0:add(3, 7) or nil
            if __t1 ~= nil then
                return __t1
            else
                return -1
            end
        end
    end
    local resultA = testMe()
    calc = nil
    local resultB = testMe()
    return resultA * resultB
end

function demoScopeFunctions()
    local base = 5
    local logged
    do
        local __t0 = base
        local __t1 = (__t0 ~= nil) and ktox_also(__t0, function(it)
            return println(it)
        end) or nil
        logged = __t1
    end
    local doubled
    do
        local __t0 = logged
        local __t1 = (__t0 ~= nil) and ktox_let(__t0, function(it)
            return it * 2
        end) or nil
        doubled = __t1
    end
    local tripled
    do
        local __t0 = doubled
        local __t1 = (__t0 ~= nil) and ktox_let(__t0, function(n)
            return n + doubled
        end) or nil
        tripled = __t1
    end
    local positive
    do
        local __t0 = tripled
        local __t1 = (__t0 ~= nil) and ktox_takeIf(__t0, function(it)
            return it > 0
        end) or nil
        positive = __t1
    end
    local negative
    do
        local __t0 = tripled
        local __t1 = (__t0 ~= nil) and ktox_takeIf(__t0, function(it)
            return it < 0
        end) or nil
        negative = __t1
    end
    local maybeNull = nil
    local safe
    do
        local __t0 = maybeNull
        local __t1 = (__t0 ~= nil) and ktox_also(__t0, function(it)
            return println(it)
        end) or nil
        safe = __t1
    end
    return (ktox_elvis(positive, 0)) + (ktox_elvis(negative, -1)) + ((safe == nil and 0 or 1))
end

