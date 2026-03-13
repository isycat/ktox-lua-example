package com.example.features

/**
 * Demonstrates Kotlin map functions transpiled to ktox-lib.lua helpers.
 *
 * `demoMaps()` is a global function accessible from Main.lua after
 * `require("features/MapDemo")`.
 */
class MapDemo

fun demoMaps(): Int {
    val scores = mapOf("alice" to 10, "bob" to 20, "carol" to 15)
    val empty = emptyMap<String, Int>()
    val mutable = mutableMapOf("x" to 1)

    // containsKey / containsValue
    val hasAlice = scores.containsKey("alice")      // true
    val hasScore10 = scores.containsValue(10)       // true

    // getOrDefault / getOrElse
    val aliceScore = scores.getOrDefault("alice", 0)  // 10
    val daveScore = scores.getOrDefault("dave", 0)    // 0
    val elseScore = scores.getOrElse("eve") { -1 }    // -1

    // keys / values
    val names = scores.keys    // ["alice", "bob", "carol"]
    val vals = scores.values   // [10, 20, 15]

    // mapValues / mapKeys
    val doubled = scores.mapValues { (k, v) -> v * 2 }
    val upper = scores.mapKeys { (k, v) -> k + "_player" }

    // filterKeys / filterValues
    val filtered = scores.filterKeys { k -> k != "bob" }
    val highScores = scores.filterValues { v -> v >= 15 }

    // toMap
    val copy = scores.toMap()

    // forEach: iterate over all entries
    scores.forEach { (k, v) -> println(k) }

    // for ((k, v) in map): destructuring loop
    for ((k, v) in scores) {
        println(k)
    }

    // filter: keep entries matching predicate
    val high = scores.filter { (k, v) -> v >= 15 }   // {bob:20, carol:15}

    // any / all / none on entries
    val anyBig = scores.any { (k, v) -> v > 15 }     // true (bob=20)
    val allPos = scores.all { (k, v) -> v > 0 }      // true
    val noneNeg = scores.none { (k, v) -> v < 0 }    // true

    // count: total entries and entries matching predicate
    val total = scores.count()                         // 3
    val bigCount = scores.count { (k, v) -> v >= 15 } // 2 (bob, carol)

    // isEmpty / isNotEmpty / isNullOrEmpty
    val emptyCheck = empty.isEmpty()                   // true
    val notEmptyCheck = scores.isNotEmpty()            // true
    val nullOrEmptyCheck = empty.isNullOrEmpty()       // true

    // getOrPut: returns existing value or inserts the default
    val putResult = mutable.getOrPut("x") { 99 }      // 1 (already exists)
    val newPut = mutable.getOrPut("y") { 42 }         // 42 (inserted)

    // plus: merge maps
    val extras = mapOf("dave" to 5)
    val merged = scores.plus(extras)                   // 4 entries

    // minus: remove a key
    val withoutBob = scores.minus("bob")               // 2 entries

    // putAll: copy entries from another map (mutating)
    mutable.putAll(mapOf("z" to 100))

    // contains / in operator
    val aliceIn = "alice" in scores                    // true
    val daveIn = "dave" in scores                      // false

    // linkedMapOf constructor
    val linked = linkedMapOf("one" to 1, "two" to 2)

    return aliceScore + daveScore + elseScore +
        (if (hasAlice) 1 else 0) + (if (hasScore10) 1 else 0) +
        (if (anyBig) 1 else 0) + (if (allPos) 1 else 0) + (if (noneNeg) 1 else 0) +
        (if (emptyCheck) 1 else 0) + (if (notEmptyCheck) 1 else 0) +
        (if (nullOrEmptyCheck) 1 else 0) +
        total + bigCount + putResult + newPut +
        (if (aliceIn) 1 else 0) + (if (!daveIn) 1 else 0)
    // 10 + 0 + (-1) + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 3 + 2 + 1 + 42 + 1 + 1 = 67
}

/**
 * Demonstrates `+=` (plusAssign) and `-=` (minusAssign) on mutable maps.
 *
 * `demoMapPlusAssign()` returns 7 = sizeAfterAdd(3) + sizeAfterRemove(2) + hasNew(1) + missingOld(1)
 */
fun demoMapPlusAssign(): Int {
    var m = mutableMapOf("a" to 1, "b" to 2)

    // map += "key" to value  → ktox_mapPlus (compile-time detected pair)
    m += "c" to 3
    val sizeAfterAdd = m.count()   // 3

    // map -= key  → ktox_minusAssign → ktox_minus
    m -= "b"
    val sizeAfterRemove = m.count()  // 2

    // Verify contents
    val hasNew  = m.containsKey("c")   // true  (added)
    val hasOld  = m.containsKey("b")   // false (removed)

    return sizeAfterAdd + sizeAfterRemove + (if (hasNew) 1 else 0) + (if (!hasOld) 1 else 0)
    // 3 + 2 + 1 + 1 = 7
}
