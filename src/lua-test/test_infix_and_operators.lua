-- test_infix_and_operators.lua
-- Tests for:
--   • Vec2 class operator overloads (+, -, *, unary-, compareTo, toString, equals)
--   • Multiplier invoke operator (__call)
--   • Primitive extension function (string_shout)
--   • Primitive extension properties (string_wordCount, string_lastChar)
--   • Class extension function (CoolCat:printName)
--   • Class extension property (CoolCat:greeting)
--   • Custom infix function on Int (int_isBetween)
--   • with() scope function (demoWith)
--   • Collection binary operators (+ and - routed to ktox_plus / ktox_minus)
--   • Map binary operator + (routed to ktox_mapPlus)
--   • matches / infix matches (ktox_matches)
--
-- NOTE: Bitwise operators (xor/and/or/shl/shr) are transpiled to Lua 5.3+
--       syntax (~, |, &, <<, >>) which is not available in the LuaJ 5.2
--       runtime used by runLuaTests.  They are validated in the Kotlin
--       transpiler unit tests (TranspilerInfixAndExtensionTest) instead.

require("ktox-lib")
ktox_require("features/InfixAndOperatorDemo")

-- ─── Full integration tests ───────────────────────────────────────────────────

ktox_test("demoVec2Operators() returns 10", function()
    ktox_assert_eq(demoVec2Operators(), 10)
end)

ktox_test("demoInvokeOperator() returns 21 (Multiplier(3)(7))", function()
    ktox_assert_eq(demoInvokeOperator(), 21)
end)

ktox_test("demoExtensionFunction() returns 'hello !'", function()
    ktox_assert_eq(demoExtensionFunction(), "hello !")
end)

ktox_test("demoCustomInfix() returns 1 (5 isBetween (0,10)=true, (5,10)=false)", function()
    ktox_assert_eq(demoCustomInfix(), 1)
end)

ktox_test("demoWith() returns 30 (Vec2(10,20): self.x + self.y)", function()
    ktox_assert_eq(demoWith(), 30)
end)

ktox_test("demoCollectionOperators() returns 10 (5+4+1)", function()
    ktox_assert_eq(demoCollectionOperators(), 10)
end)

ktox_test("demoMatches() returns 3 (two matches + one non-match)", function()
    ktox_assert_eq(demoMatches(), 3)
end)

ktox_test("demoExtensionProperty() returns 6 (3 words + 1 + 1 word + 1)", function()
    ktox_assert_eq(demoExtensionProperty(), 6)
end)

-- ─── Vec2 operator metamethods — direct Lua tests ────────────────────────────

ktox_test("Vec2.__add metamethod: a + b produces correct sum", function()
    local a = Vec2:new(3, 4)
    local b = Vec2:new(1, 2)
    local c = a + b
    ktox_assert_eq(c.x, 4)
    ktox_assert_eq(c.y, 6)
end)

ktox_test("Vec2.__sub metamethod: a - b produces correct difference", function()
    local a = Vec2:new(5, 7)
    local b = Vec2:new(2, 3)
    local d = a - b
    ktox_assert_eq(d.x, 3)
    ktox_assert_eq(d.y, 4)
end)

ktox_test("Vec2.__mul metamethod: v * scalar produces correct scaled vector", function()
    local v = Vec2:new(2, 3)
    local e = v * 4
    ktox_assert_eq(e.x, 8)
    ktox_assert_eq(e.y, 12)
end)

ktox_test("Vec2.__unm metamethod: -v negates components", function()
    local v = Vec2:new(3, -5)
    local neg = -v
    ktox_assert_eq(neg.x, -3)
    ktox_assert_eq(neg.y, 5)
end)

ktox_test("Vec2.__lt metamethod: a < b compares magnitude-squared", function()
    local small = Vec2:new(1, 1)  -- mag2 = 2
    local big   = Vec2:new(3, 4)  -- mag2 = 25
    ktox_assert_true(small < big)
    ktox_assert_false(big < small)
end)

ktox_test("Vec2.__le metamethod: a <= b compares magnitude-squared (equal case)", function()
    local v1 = Vec2:new(1, 1)  -- mag2 = 2
    local v2 = Vec2:new(1, 1)  -- mag2 = 2
    ktox_assert_true(v1 <= v2)
    ktox_assert_true(v2 <= v1)
end)

ktox_test("Vec2.__tostring metamethod: tostring(v) returns formatted string", function()
    local v = Vec2:new(3, 4)
    local s = tostring(v)
    ktox_assert_eq(s, "(3, 4)")
end)

ktox_test("Vec2 chained operations: (a + b) - c", function()
    local a = Vec2:new(10, 10)
    local b = Vec2:new(3, 4)
    local c = Vec2:new(1, 1)
    local result = (a + b) - c
    ktox_assert_eq(result.x, 12)
    ktox_assert_eq(result.y, 13)
end)

-- ─── Multiplier __call metamethod ────────────────────────────────────────────

ktox_test("Multiplier __call: triple(5) returns 15", function()
    local triple = Multiplier:new(3)
    ktox_assert_eq(triple:invoke(5), 15)
end)

ktox_test("Multiplier __call: double(7) returns 14", function()
    local double = Multiplier:new(2)
    ktox_assert_eq(double:invoke(7), 14)
end)

-- ─── Extension function: string_shout ────────────────────────────────────────

ktox_test("string_shout extension function appends ' !' to string", function()
    ktox_assert_eq(string_shout("world"), "world !")
end)

ktox_test("string_shout extension function on empty string", function()
    ktox_assert_eq(string_shout(""), " !")
end)

-- ─── Custom infix function: int_isBetween ────────────────────────────────────

ktox_test("int_isBetween returns true when value is strictly between bounds", function()
    ktox_assert_true(int_isBetween(5, {1, 10}))
end)

ktox_test("int_isBetween returns false when value equals lower bound (strict)", function()
    ktox_assert_false(int_isBetween(1, {1, 10}))
end)

ktox_test("int_isBetween returns false when value equals upper bound (strict)", function()
    ktox_assert_false(int_isBetween(10, {1, 10}))
end)

ktox_test("int_isBetween returns false when value is outside range", function()
    ktox_assert_false(int_isBetween(0, {1, 10}))
    ktox_assert_false(int_isBetween(11, {1, 10}))
end)

-- ─── with() scope function ────────────────────────────────────────────────────

ktox_test("with() block accesses receiver properties as self.x, self.y", function()
    local v = Vec2:new(3, 7)
    local result = (function(self)
        return self.x + self.y
    end)(v)
    ktox_assert_eq(result, 10)
end)

ktox_test("with() block can call receiver methods", function()
    local v = Vec2:new(3, 4)  -- mag2 = 25
    local result = (function(self)
        return self:mag2()
    end)(v)
    ktox_assert_eq(result, 25)
end)

-- ─── Collection binary operators ─────────────────────────────────────────────

ktox_test("ktox_plus({1,2,3}, {4,5}) concatenates lists", function()
    local result = ktox_plus({1, 2, 3}, {4, 5})
    ktox_assert_eq(#result, 5)
    ktox_assert_eq(result[1], 1)
    ktox_assert_eq(result[3], 3)
    ktox_assert_eq(result[4], 4)
    ktox_assert_eq(result[5], 5)
end)

ktox_test("ktox_minus({1,2,3,4,5}, 3) removes all occurrences", function()
    local result = ktox_minus({1, 2, 3, 4, 5}, 3)
    ktox_assert_eq(#result, 4)
    ktox_assert_eq(result[1], 1)
    ktox_assert_eq(result[2], 2)
    ktox_assert_eq(result[3], 4)
    ktox_assert_eq(result[4], 5)
end)

ktox_test("ktox_mapPlus adds a new key-value pair to a map", function()
    local m = ktox_mapPlus({["x"] = 1}, {"y", 2})
    ktox_assert_eq(m["x"], 1)
    ktox_assert_eq(m["y"], 2)
end)

ktox_test("ktox_mapPlus on an empty map works correctly", function()
    local m = ktox_mapPlus({}, {"key", 42})
    ktox_assert_eq(m["key"], 42)
end)

ktox_test("ktox_mapPlus merges two maps (right-hand wins)", function()
    local m = ktox_mapPlus({["a"] = 1, ["b"] = 2}, {["b"] = 99, ["c"] = 3})
    ktox_assert_eq(m["a"], 1)
    ktox_assert_eq(m["b"], 99)
    ktox_assert_eq(m["c"], 3)
end)

-- ─── ktox_matches ─────────────────────────────────────────────────────────────

ktox_test("ktox_matches: full string match returns true", function()
    ktox_assert_true(ktox_matches("hello", "hello"))
end)

ktox_test("ktox_matches: pattern match returns true", function()
    ktox_assert_true(ktox_matches("hello123", "[a-z]+[0-9]+"))
end)

ktox_test("ktox_matches: partial match returns false (anchored)", function()
    ktox_assert_false(ktox_matches("hello123abc", "[a-z]+[0-9]+"))
end)

ktox_test("ktox_matches: non-matching pattern returns false", function()
    ktox_assert_false(ktox_matches("hello", "[0-9]+"))
end)

ktox_test("ktox_matches: empty string matches empty pattern", function()
    ktox_assert_true(ktox_matches("", ""))
end)

ktox_test("demoMatches integration: dotForm, infixForm=true, noMatch=false → 3", function()
    ktox_assert_eq(demoMatches(), 3)
end)

-- ─── Extension properties ─────────────────────────────────────────────────────

ktox_test("string_wordCount extension property: 'hello world foo' has 3 words", function()
    ktox_assert_eq(string_wordCount("hello world foo"), 3)
end)

ktox_test("string_wordCount extension property: single word has count 1", function()
    ktox_assert_eq(string_wordCount("hello"), 1)
end)

ktox_test("string_lastChar extension property: last char of 'hello' is 'o'", function()
    ktox_assert_eq(string_lastChar("hello"), "o")
end)

ktox_test("string_lastChar extension property: last char of 'world' is 'd'", function()
    ktox_assert_eq(string_lastChar("world"), "d")
end)

ktox_test("string_lastChar extension property: single char string returns itself", function()
    ktox_assert_eq(string_lastChar("z"), "z")
end)

-- ─── Class extension function and property ────────────────────────────────────

ktox_test("CoolCat:printName() class extension method runs without error", function()
    local cat = CoolCat:new("teacup")
    cat:printName()  -- should not error
end)

ktox_test("CoolCat:greeting() class extension property returns correct greeting", function()
    local cat = CoolCat:new("Whiskers")
    ktox_assert_eq(cat:greeting(), "Hello, I'm Whiskers!")
end)

ktox_test("demoClassExtensionProperty() returns greeting for Whiskers", function()
    ktox_assert_eq(demoClassExtensionProperty(), "Hello, I'm Whiskers!")
end)

ktox_test("demoExtensionFunctionOnUserDefined() runs without error", function()
    demoExtensionFunctionOnUserDefined()  -- just verifies no runtime error
end)
