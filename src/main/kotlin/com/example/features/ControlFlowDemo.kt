package com.example.features

/**
 * Demonstrates control-flow constructs:
 *   - `for` over a numeric range (`..`) with literal and variable bounds
 *   - `for` with `until`, `downTo`, and `step`
 *   - `while` loop
 *   - `if` expression used as a value (inline ternary)
 *   - String template concatenation
 *
 * `demoControlFlow()`, `demoRanges()` and `demoStringTemplate()` are global
 * functions accessible from Main.lua after `require("features/ControlFlowDemo")`.
 */
class ControlFlowDemo

fun demoControlFlow(): Int {
    var sum = 0
    for (i in 1..5) {
        sum += i
    }
    var x = 10
    while (x > 5) {
        x = x - 1
    }
    // if expression: (sum == 15 and sum + x or 0) → 15 + 5 = 20
    val result = if (sum == 15) { sum + x } else 0
    return result
}

/** Demonstrates `until`, `downTo`, `step`, and variable-bound ranges. */
fun demoRanges(): Int {
    var total = 0
    // until: 0, 1, 2, 3, 4  → sum = 10
    for (i in 0 until 5) {
        total += i
    }
    // downTo: 5, 4, 3, 2, 1  → sum += 15  → total = 25
    for (i in 5 downTo 1) {
        total += i
    }
    // step: 0, 2, 4  → sum += 6  → total = 31
    for (i in 0..4 step 2) {
        total += i
    }
    // variable bounds
    val lo = 1
    val hi = 3
    for (i in lo..hi) {
        total += i  // 1+2+3 = 6  → total = 37
    }
    return total
}

fun demoStringTemplate(): String {
    val lang = "Lua"
    val version = 5
    return "Running on $lang ${version + 0}"
}
