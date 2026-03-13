-- test_collections.lua
-- Tests for Kotlin collection functions transpiled to ktox-lib helpers.
-- Covers: forEach, map, filter, flatMap, fold, reduce, sumOf, any/all/none,
--         count, find/firstOrNull/lastOrNull, first/last, min/max,
--         minByOrNull/maxByOrNull, distinct, reversed, sortedBy,
--         groupBy, associateBy, take, drop, contains, toList, plus,
--         joinToString, plusAssign (+=), minusAssign (-=).

require("ktox-lib")
ktox_require("features/CollectionDemo")

-- Full integration test: expected return value from the Kotlin source
ktox_test("demoCollections() returns 22", function()
    -- sum=15, evenCount=2, hasEven=1, allPositive=1, noneNegative=1, has3=1, !has9=1
    -- 15+2+1+1+1+1+1 = 22
    ktox_assert_eq(demoCollections(), 22)
end)

-- plusAssign / minusAssign on collections
ktox_test("demoCollectionPlusAssign() returns 15", function()
    -- sizeAfterAdd=7, sizeAfterRemove=6, hasFirst=1, !hasRemoved=1 → 15
    ktox_assert_eq(demoCollectionPlusAssign(), 15)
end)

-- Individual helpers ---------------------------------------------------------

ktox_test("ktox_map doubles each element", function()
    local result = ktox_map({1, 2, 3}, function(it) return it * 2 end)
    ktox_assert_eq(result[1], 2)
    ktox_assert_eq(result[2], 4)
    ktox_assert_eq(result[3], 6)
end)

ktox_test("ktox_filter keeps only even numbers", function()
    local result = ktox_filter({1, 2, 3, 4, 5}, function(it) return it % 2 == 0 end)
    ktox_assert_eq(#result, 2)
    ktox_assert_eq(result[1], 2)
    ktox_assert_eq(result[2], 4)
end)

ktox_test("ktox_fold sums a list with initial value 0", function()
    ktox_assert_eq(ktox_fold({1, 2, 3, 4, 5}, 0, function(acc, v) return acc + v end), 15)
end)

ktox_test("ktox_reduce multiplies a list", function()
    ktox_assert_eq(ktox_reduce({1, 2, 3, 4, 5}, function(acc, v) return acc * v end), 120)
end)

ktox_test("ktox_any returns true when predicate matches", function()
    ktox_assert_true(ktox_any({1, 2, 3}, function(it) return it == 2 end))
end)

ktox_test("ktox_any returns false when no element matches", function()
    ktox_assert_false(ktox_any({1, 3, 5}, function(it) return it % 2 == 0 end))
end)

ktox_test("ktox_all returns true when all match", function()
    ktox_assert_true(ktox_all({2, 4, 6}, function(it) return it % 2 == 0 end))
end)

ktox_test("ktox_none returns true when nothing matches", function()
    ktox_assert_true(ktox_none({1, 3, 5}, function(it) return it < 0 end))
end)

ktox_test("ktox_count with predicate counts matching elements", function()
    ktox_assert_eq(ktox_count({1, 2, 3, 4}, function(it) return it % 2 == 0 end), 2)
end)

ktox_test("ktox_find returns first matching element", function()
    ktox_assert_eq(ktox_find({1, 2, 3, 4}, function(it) return it % 2 == 0 end), 2)
end)

ktox_test("ktox_firstOrNull returns nil when no match", function()
    ktox_assert_nil(ktox_firstOrNull({1, 3, 5}, function(it) return it > 10 end))
end)

ktox_test("ktox_lastOrNull returns last matching element", function()
    ktox_assert_eq(ktox_lastOrNull({1, 2, 3, 4}, function(it) return it % 2 == 0 end), 4)
end)

ktox_test("ktox_first returns the first element", function()
    ktox_assert_eq(ktox_first({10, 20, 30}), 10)
end)

ktox_test("ktox_last returns the last element", function()
    ktox_assert_eq(ktox_last({10, 20, 30}), 30)
end)

ktox_test("ktox_minOrNull returns smallest element", function()
    ktox_assert_eq(ktox_minOrNull({3, 1, 4, 1, 5}), 1)
end)

ktox_test("ktox_maxOrNull returns largest element", function()
    ktox_assert_eq(ktox_maxOrNull({3, 1, 4, 1, 5}), 5)
end)

ktox_test("ktox_minByOrNull returns element with shortest string", function()
    ktox_assert_eq(ktox_minByOrNull({"banana", "apple", "cherry"}, function(it) return #it end), "apple")
end)

ktox_test("ktox_maxByOrNull returns element with longest string", function()
    local r = ktox_maxByOrNull({"banana", "apple", "cherry"}, function(it) return #it end)
    -- both "banana" and "cherry" have length 6; first wins per max semantics
    ktox_assert_eq(#r, 6)
end)

ktox_test("ktox_distinct removes duplicates", function()
    local result = ktox_distinct({1, 2, 2, 3, 3, 3})
    ktox_assert_eq(#result, 3)
end)

ktox_test("ktox_reversed reverses a list", function()
    local result = ktox_reversed({1, 2, 3})
    ktox_assert_eq(result[1], 3)
    ktox_assert_eq(result[3], 1)
end)

ktox_test("ktox_take returns first n elements", function()
    local result = ktox_take({1, 2, 3, 4, 5}, 2)
    ktox_assert_eq(#result, 2)
    ktox_assert_eq(result[1], 1)
    ktox_assert_eq(result[2], 2)
end)

ktox_test("ktox_drop skips first n elements", function()
    local result = ktox_drop({1, 2, 3, 4, 5}, 2)
    ktox_assert_eq(#result, 3)
    ktox_assert_eq(result[1], 3)
end)

ktox_test("ktox_contains finds an element in a list", function()
    ktox_assert_true(ktox_contains({1, 2, 3}, 2))
    ktox_assert_false(ktox_contains({1, 2, 3}, 9))
end)

ktox_test("ktox_plus concatenates two lists", function()
    local result = ktox_plus({1, 2}, {3, 4, 5})
    ktox_assert_eq(#result, 5)
    ktox_assert_eq(result[3], 3)
end)

ktox_test("ktox_joinToString joins with separator", function()
    ktox_assert_eq(ktox_joinToString({1, 2, 3}, ", "), "1, 2, 3")
end)

ktox_test("ktox_joinToString with transform function", function()
    ktox_assert_eq(
        ktox_joinToString({1, 2, 3}, "-", function(it) return tostring(it * 2) end),
        "2-4-6"
    )
end)

ktox_test("ktox_flatMap flattens one level", function()
    local result = ktox_flatMap({1, 2, 3}, function(it) return {it, it} end)
    ktox_assert_eq(#result, 6)
    ktox_assert_eq(result[1], 1)
    ktox_assert_eq(result[2], 1)
    ktox_assert_eq(result[3], 2)
end)

ktox_test("ktox_sumOf doubles and sums", function()
    ktox_assert_eq(ktox_sumOf({1, 2, 3, 4, 5}, function(it) return it * 2 end), 30)
end)

ktox_test("ktox_sortedBy sorts ascending by key", function()
    local result = ktox_sortedBy({"banana", "apple", "cherry"}, function(it) return #it end)
    ktox_assert_eq(result[1], "apple")
end)

ktox_test("ktox_sortedByDescending sorts descending by key", function()
    local result = ktox_sortedByDescending({"banana", "apple", "cherry"}, function(it) return #it end)
    ktox_assert_eq(result[1], "banana")
end)

ktox_test("ktox_groupBy groups elements by key", function()
    local grouped = ktox_groupBy({1, 2, 3, 4}, function(it)
        return (it % 2 == 0 and "even" or "odd")
    end)
    ktox_assert_eq(#grouped["even"], 2)
    ktox_assert_eq(#grouped["odd"], 2)
end)

ktox_test("ktox_associateBy maps key to element", function()
    local result = ktox_associateBy({1, 2, 3}, function(it) return it * 10 end)
    ktox_assert_eq(result[10], 1)
    ktox_assert_eq(result[20], 2)
end)

ktox_test("ktox_mapIndexed provides index and value", function()
    local result = ktox_mapIndexed({10, 20, 30}, function(i, v) return i + v end)
    ktox_assert_eq(result[1], 11)  -- 1 + 10
    ktox_assert_eq(result[2], 22)  -- 2 + 20
end)

ktox_test("ktox_toList returns a shallow copy", function()
    local orig = {1, 2, 3}
    local copy = ktox_toList(orig)
    ktox_assert_eq(#copy, 3)
    ktox_assert_eq(copy[1], orig[1])
end)

-- ktox_plusAssign / ktox_minusAssign on lists ----------------------------------

ktox_test("ktox_plusAssign appends a scalar to a list", function()
    local list = {1, 2, 3}
    list = ktox_plusAssign(list, 4)
    ktox_assert_eq(#list, 4)
    ktox_assert_eq(list[4], 4)
end)

ktox_test("ktox_plusAssign concatenates two lists", function()
    local list = {1, 2}
    list = ktox_plusAssign(list, {3, 4, 5})
    ktox_assert_eq(#list, 5)
    ktox_assert_eq(list[3], 3)
    ktox_assert_eq(list[5], 5)
end)

ktox_test("ktox_minusAssign removes all occurrences of element from list", function()
    local list = {1, 2, 3, 2, 4}
    list = ktox_minusAssign(list, 2)
    ktox_assert_eq(#list, 3)
    ktox_assert_eq(list[1], 1)
    ktox_assert_eq(list[2], 3)
    ktox_assert_eq(list[3], 4)
end)

ktox_test("ktox_minusAssign on a number subtracts correctly", function()
    local x = 100
    x = ktox_minusAssign(x, 37)
    ktox_assert_eq(x, 63)
end)

ktox_test("ktox_plusAssign on a number adds correctly", function()
    local n = 0
    n = ktox_plusAssign(n, 42)
    ktox_assert_eq(n, 42)
end)
