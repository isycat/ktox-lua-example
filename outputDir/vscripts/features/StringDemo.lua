-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/StringDemo.kt", {["1-6"]=1,["7"]=17,["8-11"]=24,["12"]=28,["13-16"]=32,["17"]=36,["18"]=37,["19"]=38,["20-23"]=39,["24"]=43,["25-28"]=44,["29"]=48,["30"]=49,["31"]=50,["32"]=51,["33"]=52,["34-37"]=53,["38"]=57,["39-42"]=58,["43"]=62,["44"]=63,["45-48"]=64,["49"]=68,["50-53"]=69,["54"]=73,["55-58"]=74,["59"]=78,["60-63"]=79,["64-67"]=83,["68"]=87,["69"]=88,["70"]=89,["71-74"]=90,["75"]=94,["76"]=95,["77"]=96,["78-81"]=97,["82"]=101,["83"]=102,["84"]=103,["85"]=104,["86-89"]=105,["90"]=109,["91"]=110,["92-95"]=111,["96-99"]=115,["100-103"]=119,["104"]=123,["105"]=124,["106"]=125,["107-109"]=126})

function demoMultiLineString()
    local poem = ktox_trimIndent("\n        Roses are red,\n        Violets are blue,\n        Kotlin is cool,\n        And Lua is too!\n    ")
    return ktox_first(ktox_lines(poem))
end

function demoTrimMargin()
    local text = ktox_trimMargin("\n        |Hello,\n        |World!\n    ")
    return text
end

function demoStringCase()
    local original = "Hello World"
    local upper = ktox_uppercase(original)
    local lower = ktox_lowercase(original)
    return tostring(upper) .. "/" .. tostring(lower)
end

function demoStringTrim()
    local s = "  hello  "
    return ktox_trim(s)
end

function demoStringSearch()
    local s = "Hello, Kotlin!"
    local idx = ktox_indexOf(s, "Kotlin")
    local starts = ktox_startsWith(s, "Hello")
    local ends = ktox_endsWith(s, "!")
    local contains = ktox_contains(s, "Kotlin")
    return tostring(idx) .. "/" .. tostring(starts) .. "/" .. tostring(ends) .. "/" .. tostring(contains)
end

function demoStringSubstring()
    local s = "Hello, World!"
    return ktox_substring(s, 7, 12)
end

function demoStringSplit()
    local csv = "apple,banana,cherry"
    local parts = ktox_split(csv, ",")
    return #parts
end

function demoStringLines()
    local text = "line1" .. "\n" .. "line2" .. "\n" .. "line3"
    return #ktox_lines(text)
end

function demoStringReplace()
    local s = "Hello, World!"
    return ktox_replace(s, "World", "Kotlin")
end

function demoStringReplaceRegex()
    local s = "foo123bar456"
    return ktox_replaceRegex(s, "\[0-9\]+", "#")
end

function demoStringRepeat()
    return ktox_repeat("ab", 3)
end

function demoStringPad()
    local n = "42"
    local padded = ktox_padStart(n, 5, '0')
    local paddedEnd = ktox_padEnd(n, 5, '-')
    return tostring(padded) .. "/" .. tostring(paddedEnd)
end

function demoStringRemove()
    local s = "prefixHello"
    local withoutPrefix = ktox_removePrefix(s, "prefix")
    local withoutSuffix = ktox_removeSuffix("HelloSuffix", "Suffix")
    return tostring(withoutPrefix) .. "/" .. tostring(withoutSuffix)
end

function demoStringConvert()
    local n = "42"
    local i = ktox_toInt(n)
    local maybeNull = ktox_toIntOrNull("abc")
    local notNull = ktox_toIntOrNull("10")
    return tostring(i) .. "/" .. tostring(maybeNull == nil) .. "/" .. tostring(notNull ~= nil)
end

function demoStringBlank()
    local blank = "   "
    local notBlank = "hello"
    return tostring(ktox_isBlank(blank)) .. "/" .. tostring(ktox_isNotBlank(notBlank))
end

function demoStringFormat()
    return ktox_format("Hello, %s! You are %d years old.", "World", 30)
end

function demoStringReversed()
    return ktox_reversed("Hello")
end

function demoStringContainsAndCount()
    local s = "Hello, World!"
    local hasWorld = ktox_contains(s, "World")
    local length = #s
    return tostring(hasWorld) .. "/" .. tostring(length)
end

