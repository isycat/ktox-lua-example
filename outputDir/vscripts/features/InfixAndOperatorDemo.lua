-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/InfixAndOperatorDemo.kt", {["1-90"]=1,["91-94"]=53,["95-108"]=54,["109-112"]=62,["113-116"]=63,["117-120"]=64,["121-124"]=65,["125-153"]=66,["154"]=110,["155"]=111,["156"]=112,["157"]=113,["158"]=114,["159"]=115,["160"]=118,["161"]=119,["162-165"]=121,["166"]=130,["167-170"]=131,["171"]=138,["172-175"]=139,["176"]=146,["177"]=147,["178"]=148,["179-182"]=149,["183"]=157,["184-189"]=158,["190"]=167,["191-194"]=168,["195"]=178,["196"]=180,["197"]=182,["198"]=184,["199-202"]=185,["203"]=194,["204"]=195,["205"]=196,["206"]=197,["207"]=198,["208-211"]=199,["212"]=209,["213"]=210,["214"]=211,["215"]=213,["216"]=214,["217"]=215,["218-221"]=217,["222"]=222,["223-226"]=223,["227"]=231,["228-231"]=232,["232"]=240,["233"]=241,["234"]=242,["235"]=243,["236-239"]=244,["240"]=252,["241"]=253,["242"]=254,["243"]=255,["244"]=256,["245"]=257,["246-248"]=258})

Vec2 = {}
Vec2.__index = Vec2
Vec2.__add = function(a, b) return a:plus(b) end
Vec2.__sub = function(a, b) return a:minus(b) end
Vec2.__mul = function(a, b) return a:times(b) end
Vec2.__unm = function(a) return a:unaryMinus() end
Vec2.__eq = function(a, b) return a:equals(b) end
Vec2.__lt = function(a, b) return a:compareTo(b) < 0 end
Vec2.__le = function(a, b) return a:compareTo(b) <= 0 end
Vec2.__tostring = function(a) return a:toString() end

function Vec2:new(x, y)
    local self = setmetatable({}, Vec2)
    self.x = x
    self.y = y
    return self
end

function Vec2:plus(other)
    return Vec2:new(self.x + other.x, self.y + other.y)
end

function Vec2:minus(other)
    return Vec2:new(self.x - other.x, self.y - other.y)
end

function Vec2:times(scalar)
    return Vec2:new(self.x * scalar, self.y * scalar)
end

function Vec2:unaryMinus()
    return Vec2:new(-self.x, -self.y)
end

function Vec2:equals(other)
    return ktox_isinstance(other, Vec2) and self.x == other.x and self.y == other.y
end

function Vec2:hashCode()
    return 31 * self.x + self.y
end

function Vec2:mag2()
    return self.x * self.x + self.y * self.y
end

function Vec2:compareTo(other)
    return self:mag2() - other:mag2()
end

function Vec2:toString()
    return "(" .. tostring(self.x) .. ", " .. tostring(self.y) .. ")"
end


Multiplier = {}
Multiplier.__index = Multiplier
Multiplier.__call = function(a, ...) return a:invoke(...) end

function Multiplier:new(factor)
    local self = setmetatable({}, Multiplier)
    self.factor = factor
    return self
end

function Multiplier:invoke(x)
    return self.factor * x
end


CoolCat = {}
CoolCat.__index = CoolCat

function CoolCat:new(name)
    local self = setmetatable({}, CoolCat)
    self.name = name
    self.coolPoints = 0
    return self
end

function CoolCat:sayHello()
    return println("Hello, I\'m " .. tostring(name) .. "!")
end

function CoolCat:plusAssign(amount)
    self.coolPoints = ktox_plusAssign(self.coolPoints, amount)
end

function CoolCat:minusAssign(amount)
    self.coolPoints = ktox_minusAssign(self.coolPoints, amount)
end


Accumulator = {}
Accumulator.__index = Accumulator

function Accumulator:new(value)
    local self = setmetatable({}, Accumulator)
    self.value = value
    return self
end

function Accumulator:plusAssign(n)
    self.value = ktox_plusAssign(self.value, n)
end

function Accumulator:minusAssign(n)
    self.value = ktox_minusAssign(self.value, n)
end

function Accumulator:timesAssign(n)
    self.value = self.value * n
end

function Accumulator:divAssign(n)
    self.value = self.value / n
end

function Accumulator:remAssign(n)
    self.value = self.value % n
end


function CoolCat:printName()
    return println(self.name)
end

function CoolCat:greeting()
    return "Hello, I\'m " .. tostring(self.name) .. "!"
end

function string_shout(self)
    return self .. " !"
end

function string_wordCount(self)
    return #ktox_split(self, " ")
end

function string_lastChar(self)
    return ktox_substring(self, #self - 1)
end

function int_isBetween(self, range)
    return self > range[1] and self < range[2]
end

function demoVec2Operators()
    local a = Vec2:new(3, 4)
    local b = Vec2:new(1, 2)
    local c = a + b
    local d = a - b
    local e = b * 3
    local neg = b:unaryMinus()
    local aGreater = a:compareTo(b) > 0
    local bSmaller = b:compareTo(a) < 0
    return c.x + d.x + e.x + neg.x + ((aGreater and 1 or 0)) + ((bSmaller and 1 or 0))
end

function demoInvokeOperator()
    local triple = Multiplier:new(3)
    return triple:invoke(7)
end

function demoExtensionFunction()
    local word = "hello"
    return string_shout(word)
end

function demoCustomInfix()
    local x = 5
    local inRange = int_isBetween(x, {0, 10})
    local notIn = int_isBetween(x, {5, 10})
    return ((inRange and 1 or 0)) + ((notIn and 1 or 0))
end

function demoWith()
    local v = Vec2:new(10, 20)
    return (function(self)
        return self.x + self.y
    end)(v)
end

function demoToMethod()
    local pair = {"key", 42}
    return {pair}
end

function demoCollectionOperators()
    local combined = ktox_plus({1, 2, 3}, {4, 5})
    local removed = ktox_minus({1, 2, 3, 4, 5}, 3)
    local m = ktox_mapPlus({["x"] = 1}, ({"y", 2}))
    local hasBoth = ktox_containsKey(m, "x") and ktox_containsKey(m, "y")
    return #combined + #removed + ((hasBoth and 1 or 0))
end

function demoMatches()
    local s = "hello123"
    local pattern = "\[a-z\]+\[0-9\]+"
    local dotForm = ktox_matches(s, pattern)
    local infixForm = ktox_matches(s, "\[a-z\]+\[0-9\]+")
    local noMatch = ktox_matches(s, "\[0-9\]+")
    return ((dotForm and 1 or 0)) + ((infixForm and 1 or 0)) + ((noMatch and 0 or 1))
end

function demoExtensionProperty()
    local phrase = "hello world foo"
    local wc = string_wordCount(phrase)
    local lc = string_lastChar(phrase)
    local single = "one"
    local wc2 = string_wordCount(single)
    local lc2 = string_lastChar(single)
    return wc + ((lc == "o" and 1 or 0)) + wc2 + ((lc2 == "e" and 1 or 0))
end

function demoExtensionFunctionOnUserDefined()
    local awesomeCat = CoolCat:new("teacup")
    awesomeCat:printName()
end

function demoClassExtensionProperty()
    local cat = CoolCat:new("Whiskers")
    return cat:greeting()
end

function demoCoolCatPlusAssign()
    local cat = CoolCat:new("Mittens")
    cat:plusAssign(10)
    cat:plusAssign(5)
    cat:minusAssign(3)
    return cat.coolPoints
end

function demoAllCompoundAssignOverloads()
    local acc = Accumulator:new(10)
    acc:plusAssign(5)
    acc:minusAssign(3)
    acc:timesAssign(2)
    acc:divAssign(4)
    acc:remAssign(5)
    return acc.value
end

