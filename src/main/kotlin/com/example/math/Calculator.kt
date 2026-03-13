package com.example.math

/**
 * Simple calculator class demonstrating multi-file transpilation.
 * This file is transpiled to `math/Calculator.lua` (the `com.example`
 * root namespace is stripped) and required from `Main.lua` via
 * `require("math/Calculator")`.
 */
class Calculator {
    fun add(a: Int, b: Int): Int = a + b
    fun multiply(a: Int, b: Int): Int = a * b
}
