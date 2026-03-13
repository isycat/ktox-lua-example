-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/MapDemo.kt", {["1-15"]=1,["16"]=12,["17"]=13,["18"]=14,["19"]=17,["20"]=18,["21"]=21,["22"]=22,["23-25"]=23,["26"]=26,["27"]=27,["28-30"]=30,["31-33"]=31,["34-36"]=34,["37-39"]=35,["40"]=38,["41-43"]=41,["44"]=44,["45-46"]=45,["47-49"]=49,["50-52"]=52,["53-55"]=53,["56-58"]=54,["59"]=57,["60-62"]=58,["63"]=61,["64"]=62,["65"]=63,["66-68"]=66,["69-71"]=67,["72"]=70,["73"]=71,["74"]=74,["75"]=77,["76"]=80,["77"]=81,["78"]=84,["79-82"]=86,["83"]=102,["84"]=105,["85"]=106,["86"]=109,["87"]=110,["88"]=113,["89"]=114,["90-92"]=116})

MapDemo = {}
MapDemo.__index = MapDemo

function MapDemo:new()
    local self = setmetatable({}, MapDemo)
    return self
end


function demoMaps()
    local scores = {["alice"] = 10, ["bob"] = 20, ["carol"] = 15}
    local empty = {}
    local mutable = {["x"] = 1}
    local hasAlice = ktox_containsKey(scores, "alice")
    local hasScore10 = ktox_containsValue(scores, 10)
    local aliceScore = ktox_getOrDefault(scores, "alice", 0)
    local daveScore = ktox_getOrDefault(scores, "dave", 0)
    local elseScore = ktox_getOrElse(scores, "eve", function()
        return -1
    end)
    local names = ktox_keys(scores)
    local vals = ktox_values(scores)
    local doubled = ktox_mapValues(scores, function(k, v)
        return v * 2
    end)
    local upper = ktox_mapKeys(scores, function(k, v)
        return k .. "_player"
    end)
    local filtered = ktox_filterKeys(scores, function(k)
        return k ~= "bob"
    end)
    local highScores = ktox_filterValues(scores, function(v)
        return v >= 15
    end)
    local copy = ktox_toMap(scores)
    ktox_mapForEach(scores, function(k, v)
        return println(k)
    end)
    for k, v in pairs(scores) do
        println(k)
    end
    local high = ktox_mapFilter(scores, function(k, v)
        return v >= 15
    end)
    local anyBig = ktox_mapAny(scores, function(k, v)
        return v > 15
    end)
    local allPos = ktox_mapAll(scores, function(k, v)
        return v > 0
    end)
    local noneNeg = ktox_mapNone(scores, function(k, v)
        return v < 0
    end)
    local total = ktox_count(scores)
    local bigCount = ktox_mapCount(scores, function(k, v)
        return v >= 15
    end)
    local emptyCheck = ktox_isEmpty(empty)
    local notEmptyCheck = ktox_isNotEmpty(scores)
    local nullOrEmptyCheck = ktox_isNullOrEmpty(empty)
    local putResult = ktox_getOrPut(mutable, "x", function()
        return 99
    end)
    local newPut = ktox_getOrPut(mutable, "y", function()
        return 42
    end)
    local extras = {["dave"] = 5}
    local merged = ktox_plus(scores, extras)
    local withoutBob = ktox_minus(scores, "bob")
    ktox_putAll(mutable, {["z"] = 100})
    local aliceIn = ktox_contains(scores, "alice")
    local daveIn = ktox_contains(scores, "dave")
    local linked = {["one"] = 1, ["two"] = 2}
    return aliceScore + daveScore + elseScore + ((hasAlice and 1 or 0)) + ((hasScore10 and 1 or 0)) + ((anyBig and 1 or 0)) + ((allPos and 1 or 0)) + ((noneNeg and 1 or 0)) + ((emptyCheck and 1 or 0)) + ((notEmptyCheck and 1 or 0)) + ((nullOrEmptyCheck and 1 or 0)) + total + bigCount + putResult + newPut + ((aliceIn and 1 or 0)) + ((not daveIn and 1 or 0))
end

function demoMapPlusAssign()
    local m = {["a"] = 1, ["b"] = 2}
    m = ktox_mapPlus(m, {"c", 3})
    local sizeAfterAdd = ktox_count(m)
    m = ktox_minusAssign(m, "b")
    local sizeAfterRemove = ktox_count(m)
    local hasNew = ktox_containsKey(m, "c")
    local hasOld = ktox_containsKey(m, "b")
    return sizeAfterAdd + sizeAfterRemove + ((hasNew and 1 or 0)) + ((not hasOld and 1 or 0))
end

