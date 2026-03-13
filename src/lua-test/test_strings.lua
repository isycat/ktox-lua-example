-- test_strings.lua
-- Tests for string functions in the transpiled Kotlin code.
require("ktox-lib")
ktox_require("features/StringDemo")

-- -------------------------------------------------------------------------
-- Multi-line string tests
-- -------------------------------------------------------------------------

ktox_test("demoMultiLineString returns first line", function()
    local result = demoMultiLineString()
    ktox_assert_eq(result, "Roses are red,")
end)

ktox_test("demoTrimMargin returns trimmed content", function()
    local result = demoTrimMargin()
    ktox_assert_eq(result, "Hello,\nWorld!")
end)

-- -------------------------------------------------------------------------
-- Case conversion
-- -------------------------------------------------------------------------

ktox_test("demoStringCase returns upper and lower", function()
    local result = demoStringCase()
    ktox_assert_eq(result, "HELLO WORLD/hello world")
end)

ktox_test("ktox_uppercase works", function()
    ktox_assert_eq(ktox_uppercase("hello"), "HELLO")
end)

ktox_test("ktox_lowercase works", function()
    ktox_assert_eq(ktox_lowercase("WORLD"), "world")
end)

-- -------------------------------------------------------------------------
-- Whitespace handling
-- -------------------------------------------------------------------------

ktox_test("demoStringTrim trims whitespace", function()
    local result = demoStringTrim()
    ktox_assert_eq(result, "hello")
end)

ktox_test("ktox_trim removes leading and trailing spaces", function()
    ktox_assert_eq(ktox_trim("  hello  "), "hello")
end)

ktox_test("ktox_trimStart removes leading spaces", function()
    ktox_assert_eq(ktox_trimStart("  hello  "), "hello  ")
end)

ktox_test("ktox_trimEnd removes trailing spaces", function()
    ktox_assert_eq(ktox_trimEnd("  hello  "), "  hello")
end)

ktox_test("ktox_isBlank returns true for blank string", function()
    ktox_assert_true(ktox_isBlank("   "))
    ktox_assert_true(ktox_isBlank(""))
    ktox_assert_false(ktox_isBlank("  a  "))
end)

ktox_test("ktox_isNotBlank returns true for non-blank string", function()
    ktox_assert_true(ktox_isNotBlank("hello"))
    ktox_assert_false(ktox_isNotBlank("   "))
end)

ktox_test("ktox_isNullOrBlank handles nil and blank", function()
    ktox_assert_true(ktox_isNullOrBlank(nil))
    ktox_assert_true(ktox_isNullOrBlank("   "))
    ktox_assert_false(ktox_isNullOrBlank("hello"))
end)

-- -------------------------------------------------------------------------
-- Search functions
-- -------------------------------------------------------------------------

ktox_test("demoStringSearch returns correct results", function()
    local result = demoStringSearch()
    ktox_assert_eq(result, "7/true/true/true")
end)

ktox_test("ktox_indexOf finds substring", function()
    ktox_assert_eq(ktox_indexOf("Hello", "ell"), 1)
    ktox_assert_eq(ktox_indexOf("Hello", "xyz"), -1)
end)

ktox_test("ktox_lastIndexOf finds last occurrence", function()
    ktox_assert_eq(ktox_lastIndexOf("abcabc", "bc"), 4)
    ktox_assert_eq(ktox_lastIndexOf("hello", "xyz"), -1)
end)

ktox_test("ktox_startsWith works", function()
    ktox_assert_true(ktox_startsWith("Hello, World", "Hello"))
    ktox_assert_false(ktox_startsWith("Hello, World", "World"))
end)

ktox_test("ktox_endsWith works", function()
    ktox_assert_true(ktox_endsWith("Hello, World", "World"))
    ktox_assert_false(ktox_endsWith("Hello, World", "Hello"))
end)

ktox_test("ktox_contains works on strings", function()
    ktox_assert_true(ktox_contains("Hello, World", "World"))
    ktox_assert_false(ktox_contains("Hello, World", "Kotlin"))
end)

-- -------------------------------------------------------------------------
-- Extraction functions
-- -------------------------------------------------------------------------

ktox_test("demoStringSubstring extracts correctly", function()
    local result = demoStringSubstring()
    ktox_assert_eq(result, "World")
end)

ktox_test("ktox_substring uses 0-based indexing", function()
    ktox_assert_eq(ktox_substring("Hello", 1, 3), "el")
    ktox_assert_eq(ktox_substring("Hello", 0, 5), "Hello")
end)

ktox_test("demoStringSplit splits by delimiter", function()
    local result = demoStringSplit()
    ktox_assert_eq(result, 3)
end)

ktox_test("ktox_split splits correctly", function()
    local parts = ktox_split("a,b,c", ",")
    ktox_assert_eq(#parts, 3)
    ktox_assert_eq(parts[1], "a")
    ktox_assert_eq(parts[2], "b")
    ktox_assert_eq(parts[3], "c")
end)

ktox_test("demoStringLines counts lines", function()
    local result = demoStringLines()
    ktox_assert_eq(result, 3)
end)

ktox_test("ktox_lines splits on newlines", function()
    local lines = ktox_lines("a\nb\nc")
    ktox_assert_eq(#lines, 3)
    ktox_assert_eq(lines[1], "a")
    ktox_assert_eq(lines[3], "c")
end)

-- -------------------------------------------------------------------------
-- Transformation functions
-- -------------------------------------------------------------------------

ktox_test("demoStringReplace replaces plain text", function()
    local result = demoStringReplace()
    ktox_assert_eq(result, "Hello, Kotlin!")
end)

ktox_test("ktox_replace does plain-text replacement", function()
    ktox_assert_eq(ktox_replace("Hello.World", ".", "-"), "Hello-World")
end)

ktox_test("demoStringReplaceRegex replaces with regex", function()
    local result = demoStringReplaceRegex()
    ktox_assert_eq(result, "foo#bar#")
end)

ktox_test("ktox_replaceRegex does pattern replacement", function()
    ktox_assert_eq(ktox_replaceRegex("abc123def", "%d+", "#"), "abc#def")
end)

ktox_test("demoStringRepeat repeats string", function()
    local result = demoStringRepeat()
    ktox_assert_eq(result, "ababab")
end)

ktox_test("ktox_repeat repeats string n times", function()
    ktox_assert_eq(ktox_repeat("ab", 3), "ababab")
    ktox_assert_eq(ktox_repeat("x", 0), "")
end)

ktox_test("ktox_reversed reverses a string", function()
    ktox_assert_eq(ktox_reversed("Hello"), "olleH")
end)

ktox_test("demoStringReversed reverses correctly", function()
    ktox_assert_eq(demoStringReversed(), "olleH")
end)

-- -------------------------------------------------------------------------
-- Padding
-- -------------------------------------------------------------------------

ktox_test("demoStringPad pads correctly", function()
    local result = demoStringPad()
    ktox_assert_eq(result, "00042/42---")
end)

ktox_test("ktox_padStart pads on left", function()
    ktox_assert_eq(ktox_padStart("42", 5, "0"), "00042")
    ktox_assert_eq(ktox_padStart("hello", 3), "hello")
end)

ktox_test("ktox_padEnd pads on right", function()
    ktox_assert_eq(ktox_padEnd("42", 5, "-"), "42---")
    ktox_assert_eq(ktox_padEnd("hello", 3), "hello")
end)

-- -------------------------------------------------------------------------
-- Prefix / suffix removal
-- -------------------------------------------------------------------------

ktox_test("demoStringRemove removes prefix and suffix", function()
    local result = demoStringRemove()
    ktox_assert_eq(result, "Hello/Hello")
end)

ktox_test("ktox_removePrefix removes prefix if present", function()
    ktox_assert_eq(ktox_removePrefix("prefixHello", "prefix"), "Hello")
    ktox_assert_eq(ktox_removePrefix("Hello", "prefix"), "Hello")
end)

ktox_test("ktox_removeSuffix removes suffix if present", function()
    ktox_assert_eq(ktox_removeSuffix("HelloSuffix", "Suffix"), "Hello")
    ktox_assert_eq(ktox_removeSuffix("Hello", "Suffix"), "Hello")
end)

-- -------------------------------------------------------------------------
-- Numeric conversion
-- -------------------------------------------------------------------------

ktox_test("demoStringConvert converts string to numbers", function()
    local result = demoStringConvert()
    ktox_assert_eq(result, "42/true/true")
end)

ktox_test("ktox_toInt converts integer strings", function()
    ktox_assert_eq(ktox_toInt("42"), 42)
    ktox_assert_eq(ktox_toInt("-10"), -10)
end)

ktox_test("ktox_toIntOrNull returns nil for invalid input", function()
    ktox_assert_nil(ktox_toIntOrNull("abc"))
    ktox_assert_eq(ktox_toIntOrNull("42"), 42)
end)

ktox_test("ktox_toDouble converts decimal strings", function()
    local d = ktox_toDouble("3.14")
    ktox_assert_true(d > 3.13 and d < 3.15)
end)

ktox_test("ktox_toDoubleOrNull returns nil for invalid input", function()
    ktox_assert_nil(ktox_toDoubleOrNull("abc"))
    ktox_assert_not_nil(ktox_toDoubleOrNull("3.14"))
end)

-- -------------------------------------------------------------------------
-- isEmpty / isNotEmpty (string-aware)
-- -------------------------------------------------------------------------

ktox_test("ktox_isEmpty works on strings", function()
    ktox_assert_true(ktox_isEmpty(""))
    ktox_assert_false(ktox_isEmpty("hello"))
end)

ktox_test("ktox_isNotEmpty works on strings", function()
    ktox_assert_true(ktox_isNotEmpty("hello"))
    ktox_assert_false(ktox_isNotEmpty(""))
end)

-- -------------------------------------------------------------------------
-- Format
-- -------------------------------------------------------------------------

ktox_test("demoStringFormat formats correctly", function()
    local result = demoStringFormat()
    ktox_assert_eq(result, "Hello, World! You are 30 years old.")
end)

ktox_test("ktox_format uses string.format", function()
    ktox_assert_eq(ktox_format("Hello, %s!", "World"), "Hello, World!")
    ktox_assert_eq(ktox_format("%d + %d = %d", 1, 2, 3), "1 + 2 = 3")
end)

ktox_test("ktox_trimIndent removes common indent", function()
    local s = "\n    Hello\n    World\n"
    local result = ktox_trimIndent(s)
    ktox_assert_eq(result, "Hello\nWorld")
end)

ktox_test("ktox_trimMargin removes margin prefix", function()
    local s = "\n    |Hello\n    |World\n"
    local result = ktox_trimMargin(s, "|")
    ktox_assert_eq(result, "Hello\nWorld")
end)

-- -------------------------------------------------------------------------
-- count on strings (returns length)
-- -------------------------------------------------------------------------

ktox_test("ktox_count on string returns length", function()
    ktox_assert_eq(ktox_count("hello"), 5)
    ktox_assert_eq(ktox_count(""), 0)
end)
