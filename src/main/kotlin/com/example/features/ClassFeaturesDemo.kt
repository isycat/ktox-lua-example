package com.example.features

/**
 * Demonstrates class features not covered by Calculator / Animal / Shapes:
 *   - Class body properties (non-constructor backing fields)
 *   - Explicit property getter (get() = expression)
 *   - Explicit property setter (set(v) { this.field = v })
 *   - Interface stub emission
 *   - `when` with `is` type-pattern conditions
 */

/** Class with a non-constructor backing field mutated via instance methods. */
class Counter {
    var count: Int = 0

    fun increment(): Int {
        this.count++
        return this.count
    }

    fun reset() {
        this.count = 0
    }

    fun readCount(): Int = this.count
}

/** Class with explicit property getters (expression bodies). */
class Rectangle(val w: Int, val h: Int) {
    val area: Int
        get() = this.w * this.h

    val perimeter: Int
        get() = (this.w + this.h) * 2
}

/** Class with a var property and an explicit setter that writes through `this`. */
class Label(initial: String) {
    var text: String = initial
        set(v) { this.text = v }

    fun readText(): String = this.text
}

/**
 * Interface – emitted as a Lua table with stub functions.
 * Classes that implement it provide their own bodies.
 */
interface Describable {
    fun describe(): String
    fun shortName(): String
}

/**
 * Class that satisfies the Describable contract.
 * `describe()` uses a two-field string template to exercise
 * `tostring(self.field) .. "…" .. tostring(self.field)` codegen.
 */
class Product(val name: String, val price: Int) : Describable {
    override fun describe(): String = "${this.name}: ${this.price}"
    override fun shortName(): String = this.name
}

class ClassFeaturesDemo

/** `when` with `is` type-pattern conditions (String / Int / Boolean / else). */
fun demoTypeWhen(x: Any): String = when (x) {
    is String -> "string"
    is Int -> "number"
    is Boolean -> "boolean"
    else -> "other"
}

/** Returns the count after 3 increments. */
fun demoCounter(): Int {
    val c = Counter()
    c.increment()
    c.increment()
    c.increment()
    return c.readCount()   // 3
}
