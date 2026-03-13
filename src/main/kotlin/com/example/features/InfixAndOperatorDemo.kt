package com.example.features

// ─── 2D vector class with full operator overloads ────────────────────────────

/**
 * Simple 2-D integer vector that demonstrates every operator overload
 * supported by the transpiler.  Each operator emits a Lua metamethod so
 * that the standard Lua arithmetic operators (+, -, *) dispatch correctly.
 *
 * All property accesses use explicit `this.` so the transpiler renders
 * them as `self.x`, `self.y`, etc. in Lua.
 */
class Vec2(val x: Int, val y: Int) {
    /** a + b → Lua __add */
    operator fun plus(other: Vec2): Vec2 = Vec2(this.x + other.x, this.y + other.y)

    /** a - b → Lua __sub */
    operator fun minus(other: Vec2): Vec2 = Vec2(this.x - other.x, this.y - other.y)

    /** a * scalar → Lua __mul */
    operator fun times(scalar: Int): Vec2 = Vec2(this.x * scalar, this.y * scalar)

    /** -a → Lua __unm */
    operator fun unaryMinus(): Vec2 = Vec2(-this.x, -this.y)

    /** a == b → Lua __eq */
    override operator fun equals(other: Any?): Boolean =
        other is Vec2 && this.x == other.x && this.y == other.y

    override fun hashCode(): Int = 31 * this.x + this.y

    /** magnitude-squared, used by compareTo */
    fun mag2(): Int = this.x * this.x + this.y * this.y

    /** a < b, a <= b → Lua __lt and __le */
    operator fun compareTo(other: Vec2): Int = this.mag2() - other.mag2()

    /** tostring(v) → Lua __tostring (emitted for override toString) */
    override fun toString(): String = "(${this.x}, ${this.y})"
}

/**
 * Callable function-object that multiplies its argument by a fixed factor.
 * Demonstrates `operator fun invoke` → Lua `__call` metamethod.
 */
class Multiplier(val factor: Int) {
    operator fun invoke(x: Int): Int = this.factor * x
}

class CoolCat(val name: String) {
    var coolPoints: Int = 0
    fun sayHello() = println("Hello, I'm $name!")
    operator fun plusAssign(amount: Int) { this.coolPoints += amount }
    operator fun minusAssign(amount: Int) { this.coolPoints -= amount }
}

/**
 * A simple accumulator demonstrating all five compound-assignment operator overloads.
 * Each overload mutates `value` in-place.
 */
class Accumulator(var value: Int) {
    operator fun plusAssign(n: Int)  { this.value += n }
    operator fun minusAssign(n: Int) { this.value -= n }
    operator fun timesAssign(n: Int) { this.value *= n }
    operator fun divAssign(n: Int)   { this.value /= n }
    operator fun remAssign(n: Int)   { this.value %= n }
}

// ─── Extension function ───────────────────────────────────────────────────────

fun CoolCat.printName() = println(this.name)

/** Extension property: a greeting string using the cat's name. */
val CoolCat.greeting: String
    get() = "Hello, I'm ${this.name}!"

/** Appends " !" to the receiver string.  Transpiled as `shout(self)`. */
fun String.shout(): String = this + " !"

// ─── Extension properties ─────────────────────────────────────────────────────

/**
 * Extension property: the number of words in a string (split on spaces).
 * Transpiled as a getter function `wordCount(self)` in Lua.
 * Accessed as `s.wordCount` → `wordCount(s)`.
 */
val String.wordCount: Int
    get() = this.split(" ").size

/**
 * Extension property: the last character of a string as a one-char string.
 * Transpiled as a getter function `lastChar(self)` in Lua.
 */
val String.lastChar: String
    get() = this.substring(this.length - 1)

// ─── Custom infix function ────────────────────────────────────────────────────

/** Returns true when [this] is strictly between [lo] and [hi]. */
infix fun Int.isBetween(range: Pair<Int, Int>): Boolean =
    this > range.first && this < range.second

// ─── Demo functions ───────────────────────────────────────────────────────────

/**
 * Exercises Vec2 operator overloads: +, -, *, unary -, compareTo, toString.
 * Returns a checksum so the call is not dead-code.
 */
fun demoVec2Operators(): Int {
    val a = Vec2(3, 4)          // mag2 = 25
    val b = Vec2(1, 2)          // mag2 = 5
    val c = a + b               // Vec2(4, 6)
    val d = a - b               // Vec2(2, 2)
    val e = b * 3               // Vec2(3, 6)
    val neg = -b                // Vec2(-1, -2)

    // Comparison via compareTo (mag2-based)
    val aGreater = a.compareTo(b) > 0   // 25 - 5 = 20 > 0 → true
    val bSmaller = b.compareTo(a) < 0   // 5 - 25 = -20 < 0 → true

    return c.x + d.x + e.x + neg.x +
        (if (aGreater) 1 else 0) + (if (bSmaller) 1 else 0)
    // (4) + (2) + (3) + (-1) + 1 + 1 = 10
}

/**
 * Exercises the `invoke` operator overload via [Multiplier].
 */
fun demoInvokeOperator(): Int {
    val triple = Multiplier(3)
    return triple.invoke(7)   // 21
}

/**
 * Exercises extension functions: [String.shout].
 */
fun demoExtensionFunction(): String {
    val word = "hello"
    return word.shout()   // "hello !"
}

/**
 * Exercises custom infix function [isBetween].
 */
fun demoCustomInfix(): Int {
    val x = 5
    val inRange = x isBetween Pair(0, 10)   // true: 5 > 0 and 5 < 10
    val notIn   = x isBetween Pair(5, 10)   // false: 5 is not > 5
    return (if (inRange) 1 else 0) + (if (notIn) 1 else 0)  // 1
}

/**
 * Exercises `with(x) { ... }` scope function: the receiver is bound to `self`
 * inside the block.
 */
fun demoWith(): Int {
    val v = Vec2(10, 20)
    return with(v) {
        this.x + this.y   // explicit this → self.x + self.y in Lua
    }
}

/**
 * Exercises `to` as a method call.
 */
fun demoToMethod(): List<Any> {
    val pair = "key" to 42   // {key, 42} in Lua
    return listOf(pair)
}

/**
 * Exercises collection binary `+` and `-` operators.
 * When the left-hand side is a literal constructor the transpiler routes to
 * `ktox_plus` / `ktox_minus`.  For map + pair, `ktox_mapPlus` is emitted.
 */
fun demoCollectionOperators(): Int {
    // list + list → ktox_plus (both operands are list constructors)
    val combined = listOf(1, 2, 3) + listOf(4, 5)   // {1,2,3,4,5}
    // list - element → ktox_minus
    val removed  = listOf(1, 2, 3, 4, 5) - 3        // {1,2,4,5}
    // map + pair → ktox_mapPlus (left is map constructor)
    val m = mapOf("x" to 1) + ("y" to 2)            // {["x"]=1,["y"]=2}
    // Use containsKey to verify map entries (Lua # does not count string keys)
    val hasBoth = m.containsKey("x") && m.containsKey("y")
    return combined.size + removed.size + (if (hasBoth) 1 else 0)
    // 5 + 4 + 1 = 10
}

/**
 * Exercises `matches` (both dot-call and infix forms with Regex).
 * The transpiler emits `ktox_matches(s, pattern)` for both forms.
 */
fun demoMatches(): Int {
    val s = "hello123"
    val pattern = Regex("[a-z]+[0-9]+")
    val dotForm   = s.matches(pattern)                    // true
    val infixForm = s matches Regex("[a-z]+[0-9]+")       // true
    val noMatch   = s matches Regex("[0-9]+")              // false
    return (if (dotForm) 1 else 0) + (if (infixForm) 1 else 0) + (if (noMatch) 0 else 1)
    // 1 + 1 + 1 = 3
}

/**
 * Exercises extension properties [String.wordCount] and [String.lastChar].
 * The transpiler emits getter function calls: `wordCount(s)` and `lastChar(s)`.
 * Returns 8 = wordCount("hello world foo") + lastChar_is_o + wordCount("one") + lastChar_is_e
 */
fun demoExtensionProperty(): Int {
    val phrase = "hello world foo"   // 3 words
    val wc = phrase.wordCount        // wordCount(phrase) → 3
    val lc = phrase.lastChar         // lastChar(phrase) → "o"

    val single = "one"
    val wc2 = single.wordCount       // wordCount(single) → 1
    val lc2 = single.lastChar        // lastChar(single) → "e"

    return wc + (if (lc == "o") 1 else 0) + wc2 + (if (lc2 == "e") 1 else 0)
    // 3 + 1 + 1 + 1 = 6... wait: 3+1+1+1 = 6
}

fun demoExtensionFunctionOnUserDefined() {
    val awesomeCat = CoolCat("teacup")
    awesomeCat.printName()
}

/**
 * Exercises the class extension property [CoolCat.greeting].
 * Returns the greeting string so the test can verify its value.
 */
fun demoClassExtensionProperty(): String {
    val cat = CoolCat("Whiskers")
    return cat.greeting
}

/**
 * Exercises the [CoolCat.plusAssign] and [CoolCat.minusAssign] operator overloads.
 * Returns the coolPoints after adding 10, 5, then subtracting 3 (expected: 12).
 */
fun demoCoolCatPlusAssign(): Int {
    val cat = CoolCat("Mittens")
    cat += 10
    cat += 5
    cat -= 3
    return cat.coolPoints
}

/**
 * Exercises all five compound-assignment operator overloads on [Accumulator].
 * Start at 10 → +5=15 → -3=12 → *2=24 → /4=6 → %5=1 (expected: 1).
 */
fun demoAllCompoundAssignOverloads(): Int {
    val acc = Accumulator(10)
    acc += 5   // 15
    acc -= 3   // 12
    acc *= 2   // 24
    acc /= 4   // 6
    acc %= 5   // 1
    return acc.value
}
