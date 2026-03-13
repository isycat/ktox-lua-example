package com.example.features

/**
 * Demonstrates exception handling support:
 * - throw → error()
 * - try/catch → pcall-based error handling
 * - try/catch/finally → pcall with always-runs cleanup
 * - try/finally without catch → pcall with re-throw
 * - Custom exception classes (as data classes)
 */

data class AppException(val message: String)

fun demoThrowAndCatch(): String {
    try {
        throw RuntimeException("something went wrong")
    } catch (e: Exception) {
        return "caught: error"
    }
    return "no error"
}

fun demoTryCatchFinally(): String {
    var result = ""
    try {
        result = "try"
        throw RuntimeException("fail")
    } catch (e: Exception) {
        result = result + "+catch"
    } finally {
        result = result + "+finally"
    }
    return result
}

fun demoTrySuccess(): String {
    var result = "error"
    try {
        val x = 42
        result = "success: $x"
    } catch (e: Exception) {
        result = "error"
    }
    return result
}

fun demoTryWithNumericOp(): Int {
    var result = 0
    try {
        val s = "123"
        result = s.toInt()
    } catch (e: Exception) {
        result = -1
    }
    return result
}

fun demoTryConversionError(): Int {
    var result = -1
    try {
        val s = "notanumber"
        result = s.toInt()
    } catch (e: Exception) {
        result = -1
    }
    return result
}

fun demoNestedTryCatch(): String {
    var log = ""
    try {
        log = log + "outer-try "
        try {
            throw RuntimeException("inner")
        } catch (e: Exception) {
            log = log + "inner-catch "
        }
        log = log + "after-inner "
    } catch (e: Exception) {
        log = log + "outer-catch "
    }
    return log.trim()
}
