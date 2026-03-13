package com.example.features

/**
 * Demonstrates:
 *   - Enum classes: emitted as local tables with string values
 *   - Object declarations (singletons): emitted as local tables with static functions
 *   - `when` statement (subject, no subject, in range, is type, multiple conditions)
 *   - `when` as expression
 *
 * `demoEnum()`, `demoObject()`, `demoWhen()`, `demoWhenExpression()`,
 * `demoWhenNoSubject()`, and `demoWhenRange()` are global functions accessible
 * from Main.lua after `require("features/Shapes")`.
 */
enum class Color { RED, GREEN, BLUE }

object ShapeRegistry {
    fun getDefaultColor(): String = "RED"
}

class Shapes

fun demoEnum(): Color = Color.RED

fun demoObject(): String = ShapeRegistry.getDefaultColor()

/** when with subject: equality checks and multiple conditions on one branch. */
fun demoWhen(n: Int): String {
    var result = "other"
    when (n) {
        1 -> result = "one"
        2 -> result = "two"
        3 -> result = "three"
        4, 5, 6 -> result = "four-to-six"
    }
    return result
}

/** when with subject: equality checks and multiple conditions on one branch. */
fun demoWhenV2(n: Int): String = when {
    n == 1 -> "one"
    n == 2 -> "two"
    n == 3 -> "three"
    n in 4..6 -> "four-to-six"
    else -> "other"
}

/** when as an expression (returns a value directly). */
fun demoWhenExpression(n: Int): String =
    when (n) {
        1 -> "one"
        2 -> "two"
        else -> "other"
    }

/** when without a subject (each branch is a full boolean condition). */
fun demoWhenNoSubject(x: Int): String {
    var label = ""
    when {
        x > 100 -> label = "huge"
        x > 10 -> label = "big"
        x > 0 -> label = "positive"
        else -> label = "non-positive"
    }
    return label
}

/** when with in-range and is-type conditions. */
fun demoWhenRange(n: Int): String {
    var result = "unknown"
    when (n) {
        in 1..3 -> result = "low"
        in 4 until 8 -> result = "mid"
        !in 1..10 -> result = "out"
        else -> result = "high"
    }
    return result
}
