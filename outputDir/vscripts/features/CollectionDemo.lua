-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/CollectionDemo.kt", {["1-15"]=1,["16"]=15,["17-19"]=18,["20-22"]=19,["23-25"]=22,["26-28"]=23,["29-31"]=26,["32-34"]=29,["35-37"]=32,["38-40"]=33,["41-43"]=36,["44-46"]=39,["47-49"]=40,["50-52"]=41,["53-55"]=44,["56-58"]=47,["59-61"]=48,["62-64"]=49,["65"]=52,["66"]=53,["67"]=56,["68"]=57,["69"]=60,["70-72"]=61,["73-75"]=62,["76"]=65,["77"]=66,["78"]=69,["79-81"]=72,["82-84"]=73,["85-87"]=76,["88-90"]=79,["91"]=82,["92"]=83,["93"]=86,["94"]=87,["95"]=90,["96"]=93,["97"]=96,["98-100"]=97,["101-104"]=100,["105"]=112,["106"]=115,["107"]=116,["108"]=119,["109"]=120,["110"]=123,["111"]=124,["112-114"]=126})

CollectionDemo = {}
CollectionDemo.__index = CollectionDemo

function CollectionDemo:new()
    local self = setmetatable({}, CollectionDemo)
    return self
end


function demoCollections()
    local numbers = {1, 2, 3, 4, 5}
    ktox_forEach(numbers, function(it)
        return println(it)
    end)
    ktox_forEachIndexed(numbers, function(i, v)
        return println(i)
    end)
    local doubled = ktox_map(numbers, function(it)
        return it * 2
    end)
    local indexed = ktox_mapIndexed(numbers, function(i, v)
        return i + v
    end)
    local evens = ktox_filter(numbers, function(it)
        return it % 2 == 0
    end)
    local flat = ktox_flatMap(numbers, function(it)
        return {it, it}
    end)
    local sum = ktox_fold(numbers, 0, function(acc, v)
        return acc + v
    end)
    local product = ktox_reduce(numbers, function(acc, v)
        return acc * v
    end)
    local sumDoubled = ktox_sumOf(numbers, function(it)
        return it * 2
    end)
    local hasEven = ktox_any(numbers, function(it)
        return it % 2 == 0
    end)
    local allPositive = ktox_all(numbers, function(it)
        return it > 0
    end)
    local noneNegative = ktox_none(numbers, function(it)
        return it < 0
    end)
    local evenCount = ktox_count(numbers, function(it)
        return it % 2 == 0
    end)
    local firstEven = ktox_find(numbers, function(it)
        return it % 2 == 0
    end)
    local firstOrNull = ktox_firstOrNull(numbers, function(it)
        return it > 10
    end)
    local lastEven = ktox_lastOrNull(numbers, function(it)
        return it % 2 == 0
    end)
    local firstEl = ktox_first(numbers)
    local lastEl = ktox_last(numbers)
    local minVal = ktox_minOrNull(numbers)
    local maxVal = ktox_maxOrNull(numbers)
    local words = {"banana", "apple", "cherry"}
    local shortest = ktox_minByOrNull(words, function(it)
        return #it
    end)
    local longest = ktox_maxByOrNull(words, function(it)
        return #it
    end)
    local dupes = {1, 2, 2, 3, 3, 3}
    local unique = ktox_distinct(dupes)
    local rev = ktox_reversed(numbers)
    local sortedAsc = ktox_sortedBy(words, function(it)
        return #it
    end)
    local sortedDesc = ktox_sortedByDescending(words, function(it)
        return #it
    end)
    local grouped = ktox_groupBy(numbers, function(it)
        return (it % 2 == 0 and "even" or "odd")
    end)
    local byVal = ktox_associateBy(numbers, function(it)
        return it * 10
    end)
    local firstTwo = ktox_take(numbers, 2)
    local afterTwo = ktox_drop(numbers, 2)
    local has3 = ktox_contains(numbers, 3)
    local has9 = ktox_contains(numbers, 9)
    local copy = ktox_toList(numbers)
    local combined = ktox_plus(firstTwo, afterTwo)
    local joined = ktox_joinToString(numbers, ", ")
    local joinedFn = ktox_joinToString(numbers, "-", function(it)
        return tostring(it * 2)
    end)
    return sum + evenCount + ((hasEven and 1 or 0)) + ((allPositive and 1 or 0)) + ((noneNegative and 1 or 0)) + ((has3 and 1 or 0)) + ((not has9 and 1 or 0))
end

function demoCollectionPlusAssign()
    local list = {1, 2, 3, 4, 5}
    list = ktox_plus(list, {6, 7})
    local sizeAfterAdd = #list
    list = ktox_minusAssign(list, 2)
    local sizeAfterRemove = #list
    local hasFirst = ktox_contains(list, 1)
    local hasRemoved = ktox_contains(list, 2)
    return sizeAfterAdd + sizeAfterRemove + ((hasFirst and 1 or 0)) + ((not hasRemoved and 1 or 0))
end

