package com.example.features

/**
 * Demonstrates Kotlin collection functions transpiled to ktox-lib.lua helpers.
 *
 * Every function here exercises a different `ktox_*` helper so that
 * `./gradlew runLua` validates the generated Lua is correct.
 *
 * `demoCollections()` is a global function accessible from Main.lua after
 * `require("features/CollectionDemo")`.
 */
class CollectionDemo

fun demoCollections(): Int {
    val numbers = listOf(1, 2, 3, 4, 5)

    // forEach / forEachIndexed
    numbers.forEach { println(it) }
    numbers.forEachIndexed { i, v -> println(i) }

    // map / mapIndexed
    val doubled = numbers.map { it * 2 }           // [2,4,6,8,10]
    val indexed = numbers.mapIndexed { i, v -> i + v }  // [1,3,5,7,9]

    // filter
    val evens = numbers.filter { it % 2 == 0 }    // [2,4]

    // flatMap
    val flat = numbers.flatMap { listOf(it, it) }  // [1,1,2,2,3,3,4,4,5,5]

    // fold / reduce
    val sum = numbers.fold(0) { acc, v -> acc + v }    // 15
    val product = numbers.reduce { acc, v -> acc * v } // 120

    // sumOf
    val sumDoubled = numbers.sumOf { it * 2 }      // 30

    // any / all / none
    val hasEven = numbers.any { it % 2 == 0 }      // true
    val allPositive = numbers.all { it > 0 }        // true
    val noneNegative = numbers.none { it < 0 }      // true

    // count
    val evenCount = numbers.count { it % 2 == 0 }  // 2

    // find / firstOrNull / lastOrNull
    val firstEven = numbers.find { it % 2 == 0 }   // 2
    val firstOrNull = numbers.firstOrNull { it > 10 }  // null
    val lastEven = numbers.lastOrNull { it % 2 == 0 }  // 4

    // first / last
    val firstEl = numbers.first()                   // 1
    val lastEl = numbers.last()                     // 5

    // minOrNull / maxOrNull
    val minVal = numbers.minOrNull()                // 1
    val maxVal = numbers.maxOrNull()                // 5

    // minByOrNull / maxByOrNull
    val words = listOf("banana", "apple", "cherry")
    val shortest = words.minByOrNull { it.length }  // apple
    val longest  = words.maxByOrNull { it.length }  // cherry (or banana)

    // distinct
    val dupes = listOf(1, 2, 2, 3, 3, 3)
    val unique = dupes.distinct()                   // [1,2,3]

    // reversed
    val rev = numbers.reversed()                    // [5,4,3,2,1]

    // sortedBy / sortedByDescending
    val sortedAsc = words.sortedBy { it.length }
    val sortedDesc = words.sortedByDescending { it.length }

    // groupBy
    val grouped = numbers.groupBy { if (it % 2 == 0) "even" else "odd" }

    // associateBy
    val byVal = numbers.associateBy { it * 10 }

    // take / drop
    val firstTwo = numbers.take(2)                  // [1,2]
    val afterTwo = numbers.drop(2)                  // [3,4,5]

    // contains
    val has3 = numbers.contains(3)                  // true
    val has9 = numbers.contains(9)                  // false

    // toList
    val copy = numbers.toList()

    // plus
    val combined = firstTwo.plus(afterTwo)          // [1,2,3,4,5]

    // joinToString
    val joined = numbers.joinToString(", ")         // "1, 2, 3, 4, 5"
    val joinedFn = numbers.joinToString("-") { "${it * 2}" }  // "2-4-6-8-10"

    // Return a checksum so the function is not pure dead-code
    return sum + evenCount + (if (hasEven) 1 else 0) + (if (allPositive) 1 else 0) +
        (if (noneNegative) 1 else 0) + (if (has3) 1 else 0) + (if (!has9) 1 else 0)
    // 15 + 2 + 1 + 1 + 1 + 1 + 1 = 22
}

/**
 * Demonstrates `+=` (plusAssign) and `-=` (minusAssign) on mutable lists.
 *
 * `demoCollectionPlusAssign()` returns 9 = size5 + size4 + sumOf9
 * where sum = 1+3+4+5-3 items + item6 = [1,3,4,5,6] sum=19 → just count checks
 */
fun demoCollectionPlusAssign(): Int {
    var list = mutableListOf(1, 2, 3, 4, 5)

    // list += listOf(6, 7) → compile-time detected list constructor → ktox_plus
    list += listOf(6, 7)
    val sizeAfterAdd = list.size   // 7

    // list -= 2 → runtime dispatch → ktox_minusAssign → ktox_minus (removes element)
    list -= 2
    val sizeAfterRemove = list.size  // 6

    // Verify first and last element
    val hasFirst = list.contains(1)   // true
    val hasRemoved = list.contains(2) // false (was removed)

    return sizeAfterAdd + sizeAfterRemove + (if (hasFirst) 1 else 0) + (if (!hasRemoved) 1 else 0)
    // 7 + 6 + 1 + 1 = 15
}
