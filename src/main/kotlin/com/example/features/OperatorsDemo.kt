package com.example.features

/**
 * Demonstrates operators and control-flow patterns not covered by other demo files:
 * compound assignment, increment/decrement, unary operators, boolean operators,
 * inequality, modulo, do-while, break, for-over-list, standalone Elvis,
 * in-range expressions, and destructuring for loop.
 */
class OperatorsDemo

/** Compound assignment: +=, -=, *= */
fun demoCompoundAssignment(): Int {
    var x = 10
    x += 5   // 15
    x -= 3   // 12
    x *= 2   // 24
    return x
}

/** Compound assignment: /= and %= */
fun demoDivMod(): Int {
    var a = 20
    a /= 4   // 5 (Kotlin integer division; Lua 5.0)
    var b = 17
    b %= 5   // 2 in both Kotlin and Lua
    return a + b  // 7
}

/** Post-increment and post-decrement in statement position */
fun demoPostIncDec(): Int {
    var a = 5
    a++   // 6
    a++   // 7
    a--   // 6
    return a
}

/** Pre-increment and pre-decrement in statement position */
fun demoPreIncDec(): Int {
    var b = 0
    ++b   // 1
    ++b   // 2
    --b   // 1
    return b
}

/** Unary minus and logical NOT */
fun demoUnary(): Int {
    val pos = 7
    val neg = -pos      // -7
    val t = true
    val f = !t          // false
    return if (!f) neg + 10 else 0   // !false → true → -7 + 10 = 3
}

/** Boolean AND and OR short-circuit */
fun demoBooleans(): Int {
    val tt = true && true    // true
    val tf = true && false   // false
    val ft = false || true   // true
    val ff = false || false  // false
    return (if (tt) 1 else 0) + (if (tf) 0 else 1) + (if (ft) 1 else 0) + (if (ff) 0 else 1)
    // 1 + 1 + 1 + 1 = 4
}

/** Inequality (!=) operator */
fun demoInequality(): Int {
    val x = 5
    val y = 3
    val ne = x != y       // true
    val eq = x != x       // false
    return (if (ne) 1 else 0) + (if (eq) 0 else 1)  // 1 + 1 = 2
}

/** Modulo (%) operator */
fun demoModulo(): Int {
    val a = 17 % 5   // 2
    val b = 10 % 3   // 1
    return a + b     // 3
}

/** do-while loop (transpiles to Lua repeat…until) */
fun demoDoWhile(): Int {
    var n = 0
    do {
        n++
    } while (n < 5)
    return n  // 5
}

/** break inside a for loop */
fun demoBreak(): Int {
    var found = 0
    for (i in 1..10) {
        if (i == 4) {
            found = i
            break
        }
    }
    return found  // 4
}

/** for loop iterating over a list (transpiles to Lua for _, item in ipairs(t)) */
fun demoForList(): Int {
    val items = listOf(10, 20, 30, 40)
    var total = 0
    for (item in items) {
        total += item
    }
    return total  // 100
}

/** Elvis ?: used as a standalone expression (no null-safe chain) */
fun demoElvisStandalone(): Int {
    val a: Int? = null
    val b: Int? = 42
    val ra = a ?: -1   // null  → -1
    val rb = b ?: -1   // 42   → 42
    return ra + rb     // 41
}

/** in / !in on a range, used as a boolean expression */
fun demoInRangeExpression(): Int {
    val x = 5
    val inRange = x in 1..10      // true (5 ≥ 1 and 5 ≤ 10)
    val notIn = x !in 1..4        // true (5 > 4)
    return (if (inRange) 1 else 0) + (if (notIn) 1 else 0)  // 2
}

/** Destructuring for loop over a map: for ((k, v) in map) */
fun demoDestructuringFor(): Int {
    val scores = mapOf("a" to 10, "b" to 20, "c" to 30)
    var total = 0
    for ((k, v) in scores) {
        total += v
    }
    return total  // 60
}
