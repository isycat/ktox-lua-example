package com.example.features

import com.example.math.Calculator

/**
 * Demonstrates null-safe chain desugaring (`?.` and `?:`) and Kotlin scope
 * functions (`also`, `let`, `takeIf`).
 *
 * Each `?.` step becomes a `do...end` block with `local __tN` temporaries:
 *   - receiver evaluated once into `__t0`
 *   - each step: `local __tN = (__t{N-1} ~= nil) and <access> or nil`
 *   - Elvis (`?:`) adds an `if __tFinal ~= nil then … else … end`
 *
 * `demoNullSafety()` and `demoScopeFunctions()` are global functions accessible
 * from Main.lua after `require("features/NullSafetyDemo")`.
 */
class NullSafetyDemo

fun demoNullSafety(): Int {
    var calc: Calculator? = null
    if (1 > 0.0) calc = Calculator()
    // calc is not nil → __t0:add(3, 7) == 10, Elvis default never taken
    val testMe = { calc?.add(3, 7) ?: -1 }
    val resultA = testMe()
    calc = null
    val resultB = testMe()
    return resultA * resultB
}

/** Demonstrates `also`, `let`, and `takeIf` scope functions. */
fun demoScopeFunctions(): Int {
    // also: executes block with the receiver, returns the receiver
    val base: Int? = 5
    val logged = base?.also { println(it) }  // logged == 5

    // let: transforms the value
    val doubled = logged?.let { it * 2 }     // doubled == 10

    // let with explicit parameter name
    val tripled = doubled?.let { n -> n + doubled }  // tripled == 20

    // takeIf: returns receiver when predicate is true, else null
    val positive = tripled?.takeIf { it > 0 }  // positive == 20
    val negative = tripled?.takeIf { it < 0 }  // negative == null

    // null-safe chain with scope function
    val maybeNull: Int? = null
    val safe = maybeNull?.also { println(it) }  // safe == null

    return (positive ?: 0) + (negative ?: -1) + (if (safe == null) 0 else 1)
}
