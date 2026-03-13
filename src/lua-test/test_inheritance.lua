-- test_inheritance.lua
-- Tests for class inheritance: Animal, Dog, demoInheritance().

require("ktox-lib")
ktox_require("features/Animal")

ktox_test("Animal:describe() returns correct string", function()
    local a = Animal:new("Buddy")
    ktox_assert_eq(a:describe(), "Animal: Buddy")
end)

ktox_test("Dog inherits Animal:describe()", function()
    local dog = Dog:new("Rex")
    ktox_assert_eq(dog:describe(), "Animal: Rex")
end)

ktox_test("Dog:bark() returns correct string", function()
    local dog = Dog:new("Rex")
    ktox_assert_eq(dog:bark(), "Rex says: Woof!")
end)

ktox_test("Dog name field set correctly", function()
    local dog = Dog:new("Max")
    ktox_assert_eq(dog.name, "Max")
end)

ktox_test("demoInheritance() returns combined string", function()
    ktox_assert_eq(demoInheritance(), "Animal: Rex, Rex says: Woof!")
end)
