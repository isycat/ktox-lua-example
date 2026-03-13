-- test_enums_objects.lua
-- Tests for enum classes (Color) and object declarations (ShapeRegistry).

require("ktox-lib")
ktox_require("features/Shapes")

ktox_test("demoEnum() returns 'RED' (Color.RED)", function()
    ktox_assert_eq(demoEnum(), "RED")
end)

ktox_test("demoObject() returns 'RED' via ShapeRegistry", function()
    ktox_assert_eq(demoObject(), "RED")
end)

-- Singleton: ShapeRegistry is a global object (no local), directly accessible
ktox_test("ShapeRegistry.getDefaultColor() is callable directly (singleton)", function()
    ktox_assert_eq(ShapeRegistry.getDefaultColor(), "RED")
end)
