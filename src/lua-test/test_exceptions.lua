-- test_exceptions.lua
-- Tests for exception handling in the transpiled Kotlin code.
require("ktox-lib")
ktox_require("features/ExceptionDemo")

ktox_test("demoThrowAndCatch catches exception", function()
    local result = demoThrowAndCatch()
    ktox_assert_eq(result, "caught: error")
end)

ktox_test("demoTryCatchFinally runs all sections", function()
    local result = demoTryCatchFinally()
    ktox_assert_eq(result, "try+catch+finally")
end)

ktox_test("demoTrySuccess returns value on success", function()
    local result = demoTrySuccess()
    ktox_assert_eq(result, "success: 42")
end)

ktox_test("demoTryWithNumericOp converts string to int", function()
    local result = demoTryWithNumericOp()
    ktox_assert_eq(result, 123)
end)

ktox_test("demoTryConversionError returns -1 on bad input", function()
    local result = demoTryConversionError()
    ktox_assert_eq(result, -1)
end)

ktox_test("demoNestedTryCatch handles nested try blocks", function()
    local result = demoNestedTryCatch()
    ktox_assert_eq(result, "outer-try inner-catch after-inner")
end)

-- -------------------------------------------------------------------------
-- Raw pcall / error tests (Lua stdlib, not transpiled)
-- -------------------------------------------------------------------------

ktox_test("pcall catches errors thrown by error()", function()
    local ok, err = pcall(function()
        error("test error")
    end)
    ktox_assert_false(ok)
    ktox_assert_not_nil(err)
end)

ktox_test("pcall returns true when no error", function()
    local ok, result = pcall(function()
        return 42
    end)
    ktox_assert_true(ok)
end)
