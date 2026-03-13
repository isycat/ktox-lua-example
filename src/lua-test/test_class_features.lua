-- test_class_features.lua
-- Tests for class features not covered by test_calculator.lua / test_inheritance.lua:
--   - Class body properties (non-constructor backing fields with initializers)
--   - Explicit property getters (get() = expression → ClassName:getXxx())
--   - Explicit property setters (set(v) { this.field = v } → ClassName:setXxx(v))
--   - Interface stub emission (Describable table with no-op functions)
--   - `when` with `is String / is Int / is Boolean` type-pattern conditions

require("ktox-lib")
ktox_require("features/ClassFeaturesDemo")

-- ─── Counter: class body property + method mutation ──────────────────────────

ktox_test("demoCounter() returns 3 (3 increments)", function()
    ktox_assert_eq(demoCounter(), 3)
end)

ktox_test("Counter body field starts at 0", function()
    local c = Counter:new()
    ktox_assert_eq(c:readCount(), 0)
end)

ktox_test("Counter:increment() increments by 1 each call", function()
    local c = Counter:new()
    c:increment()
    ktox_assert_eq(c:readCount(), 1)
    c:increment()
    ktox_assert_eq(c:readCount(), 2)
end)

ktox_test("Counter:reset() sets count back to 0", function()
    local c = Counter:new()
    c:increment()
    c:increment()
    ktox_assert_eq(c:readCount(), 2)
    c:reset()
    ktox_assert_eq(c:readCount(), 0)
end)

ktox_test("Counter: multiple instances are independent", function()
    local c1 = Counter:new()
    local c2 = Counter:new()
    c1:increment()
    c1:increment()
    ktox_assert_eq(c1:readCount(), 2)
    ktox_assert_eq(c2:readCount(), 0)
end)

-- ─── Rectangle: explicit property getter ──────────────────────────────────────

ktox_test("Rectangle:getArea() computes w * h", function()
    local r = Rectangle:new(4, 5)
    ktox_assert_eq(r:getArea(), 20)
end)

ktox_test("Rectangle:getPerimeter() computes (w + h) * 2", function()
    local r = Rectangle:new(3, 7)
    ktox_assert_eq(r:getPerimeter(), 20)
end)

ktox_test("Rectangle:getArea() is correct for a square", function()
    local r = Rectangle:new(6, 6)
    ktox_assert_eq(r:getArea(), 36)
end)

ktox_test("Rectangle constructor sets w and h as fields", function()
    local r = Rectangle:new(8, 3)
    ktox_assert_eq(r.w, 8)
    ktox_assert_eq(r.h, 3)
end)

-- ─── Label: explicit property setter ─────────────────────────────────────────

ktox_test("Label:readText() returns the initial value", function()
    local l = Label:new("hello")
    ktox_assert_eq(l:readText(), "hello")
end)

ktox_test("Label:setText() updates the backing field", function()
    local l = Label:new("hello")
    l:setText("world")
    ktox_assert_eq(l:readText(), "world")
end)

ktox_test("Label:setText() can be called repeatedly", function()
    local l = Label:new("a")
    l:setText("b")
    l:setText("c")
    ktox_assert_eq(l:readText(), "c")
end)

-- ─── Product: string template in method body ──────────────────────────────────

ktox_test("Product:describe() formats 'name: price'", function()
    local p = Product:new("Widget", 99)
    ktox_assert_eq(p:describe(), "Widget: 99")
end)

ktox_test("Product:shortName() returns just the name field", function()
    local p = Product:new("Gadget", 42)
    ktox_assert_eq(p:shortName(), "Gadget")
end)

ktox_test("Product:describe() with numeric price converts to string", function()
    local p = Product:new("Thing", 0)
    ktox_assert_eq(p:describe(), "Thing: 0")
end)

-- ─── when with is-type patterns ───────────────────────────────────────────────

ktox_test("demoTypeWhen: string literal → 'string'", function()
    ktox_assert_eq(demoTypeWhen("hello"), "string")
end)

ktox_test("demoTypeWhen: number → 'number'", function()
    ktox_assert_eq(demoTypeWhen(42), "number")
end)

ktox_test("demoTypeWhen: boolean true → 'boolean'", function()
    ktox_assert_eq(demoTypeWhen(true), "boolean")
end)

ktox_test("demoTypeWhen: boolean false → 'boolean'", function()
    ktox_assert_eq(demoTypeWhen(false), "boolean")
end)

ktox_test("demoTypeWhen: table → 'other' (else branch)", function()
    -- A Lua table has type "table", which doesn't match string/number/boolean
    ktox_assert_eq(demoTypeWhen({}), "other")
end)

ktox_test("demoTypeWhen: float is also 'number'", function()
    ktox_assert_eq(demoTypeWhen(3.14), "number")
end)
