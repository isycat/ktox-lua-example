package com.example.features

/**
 * Demonstrates full String function support including:
 * - Multi-line raw strings with trimIndent / trimMargin
 * - Case conversion (uppercase, lowercase)
 * - Whitespace handling (trim, trimStart, trimEnd, isBlank)
 * - Searching (indexOf, lastIndexOf, startsWith, endsWith, contains)
 * - Extraction (substring, split, lines)
 * - Transformation (replace, replaceFirst, reversed, repeat, padStart, padEnd)
 * - Prefix / suffix removal (removePrefix, removeSuffix)
 * - Numeric conversion (toInt, toDouble, toIntOrNull)
 * - Formatting (format)
 */

fun demoMultiLineString(): String {
    val poem = """
        Roses are red,
        Violets are blue,
        Kotlin is cool,
        And Lua is too!
    """.trimIndent()
    // Return the first line
    return poem.lines().first()
}

fun demoTrimMargin(): String {
    val text = """
        |Hello,
        |World!
    """.trimMargin()
    return text
}

fun demoStringCase(): String {
    val original = "Hello World"
    val upper = original.uppercase()
    val lower = original.lowercase()
    return "$upper/$lower"
}

fun demoStringTrim(): String {
    val s = "  hello  "
    return s.trim()
}

fun demoStringSearch(): String {
    val s = "Hello, Kotlin!"
    val idx = s.indexOf("Kotlin")
    val starts = s.startsWith("Hello")
    val ends = s.endsWith("!")
    val contains = s.contains("Kotlin")
    return "$idx/$starts/$ends/$contains"
}

fun demoStringSubstring(): String {
    val s = "Hello, World!"
    return s.substring(7, 12)
}

fun demoStringSplit(): Int {
    val csv = "apple,banana,cherry"
    val parts = csv.split(",")
    return parts.size
}

fun demoStringLines(): Int {
    val text = "line1\nline2\nline3"
    return text.lines().size
}

fun demoStringReplace(): String {
    val s = "Hello, World!"
    return s.replace("World", "Kotlin")
}

fun demoStringReplaceRegex(): String {
    val s = "foo123bar456"
    return s.replace(Regex("[0-9]+"), "#")
}

fun demoStringRepeat(): String {
    return "ab".repeat(3)
}

fun demoStringPad(): String {
    val n = "42"
    val padded = n.padStart(5, '0')
    val paddedEnd = n.padEnd(5, '-')
    return "$padded/$paddedEnd"
}

fun demoStringRemove(): String {
    val s = "prefixHello"
    val withoutPrefix = s.removePrefix("prefix")
    val withoutSuffix = "HelloSuffix".removeSuffix("Suffix")
    return "$withoutPrefix/$withoutSuffix"
}

fun demoStringConvert(): String {
    val n = "42"
    val i = n.toInt()
    val maybeNull = "abc".toIntOrNull()
    val notNull = "10".toIntOrNull()
    return "$i/${maybeNull == null}/${notNull != null}"
}

fun demoStringBlank(): String {
    val blank = "   "
    val notBlank = "hello"
    return "${blank.isBlank()}/${notBlank.isNotBlank()}"
}

fun demoStringFormat(): String {
    return "Hello, %s! You are %d years old.".format("World", 30)
}

fun demoStringReversed(): String {
    return "Hello".reversed()
}

fun demoStringContainsAndCount(): String {
    val s = "Hello, World!"
    val hasWorld = s.contains("World")
    val length = s.length
    return "$hasWorld/$length"
}
