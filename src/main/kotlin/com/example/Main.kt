package com.example

import com.example.features.demoAllCompoundAssignOverloads
import com.example.features.demoClassExtensionProperty
import com.example.math.Calculator
import com.example.features.demoCollections
import com.example.features.demoCollectionOperators
import com.example.features.demoCompanion
import com.example.features.demoCompoundAssignment
import com.example.features.demoControlFlow
import com.example.features.demoCoolCatPlusAssign
import com.example.features.demoCounter
import com.example.features.demoCustomInfix
import com.example.features.demoDataClass
import com.example.features.demoDoWhile
import com.example.features.demoEnum
import com.example.features.demoExtensionFunction
import com.example.features.demoExtensionFunctionOnUserDefined
import com.example.features.demoExtensionProperty
import com.example.features.demoInheritance
import com.example.features.demoInvokeOperator
import com.example.features.demoMaps
import com.example.features.demoMatches
import com.example.features.demoNullSafety
import com.example.features.demoObject
import com.example.features.demoScopeFunctions
import com.example.features.demoSingleton
import com.example.features.demoStringTemplate
import com.example.features.demoTypeWhen
import com.example.features.demoVec2Operators
import com.example.features.demoWhen
import com.example.features.demoWhenV2
import com.example.features.demoWith
import com.example.features.demoMultiLineString
import com.example.features.demoTrimMargin
import com.example.features.demoStringCase
import com.example.features.demoStringTrim
import com.example.features.demoStringSearch
import com.example.features.demoStringSubstring
import com.example.features.demoStringSplit
import com.example.features.demoStringLines
import com.example.features.demoStringReplace
import com.example.features.demoStringReplaceRegex
import com.example.features.demoStringRepeat
import com.example.features.demoStringPad
import com.example.features.demoStringRemove
import com.example.features.demoStringConvert
import com.example.features.demoStringBlank
import com.example.features.demoStringFormat
import com.example.features.demoStringReversed
import com.example.features.demoStringContainsAndCount
import com.example.features.demoThrowAndCatch
import com.example.features.demoTryCatchFinally
import com.example.features.demoTrySuccess
import com.example.features.demoTryWithNumericOp
import com.example.features.demoTryConversionError
import com.example.features.demoNestedTryCatch

/**
 * Entry point for the example project.
 *
 * Every supported language feature is exercised on the run path so that
 * `./gradlew runLua` proves all generated Lua is valid and correct.
 */
fun main() {
    // ---------- classes + methods ----------
    println("Calculator()")
    val calc = Calculator()
    println(calc.add(2, 3))         // 5
    println(calc.multiply(4, 5))    // 20

    // ---------- inheritance ----------
    println("demoInheritance()")
    println(demoInheritance())      // Animal: Rex, Rex says: Woof!
    println("-----------------------")

    // ---------- enum + object ----------
    println("demoEnum()")
    println(demoEnum())             // RED
    println("demoObject()")
    println(demoObject())           // RED
    println("-----------------------")

    // ---------- when expression ----------
    println("demoWhen() & V2")
    println(demoWhen(2))            // two
    println(demoWhenV2(5))          // four-to-six
    println("-----------------------")

    // ---------- control flow (for/while/if-expression) ----------
    println("demoControlFlow()")
    println(demoControlFlow())      // 20
    println("-----------------------")

    // ---------- string template ----------
    println("demoStringTemplate()")
    println(demoStringTemplate())   // Running on Lua 5
    println("-----------------------")

    // ---------- null-safe chain (?. / ?:) ----------
    println("demoNullSafety()")
    println(demoNullSafety())       // -10
    println("-----------------------")

    // ---------- `also`, `let`, and `takeIf` scope functions ----------
    println("demoScopeFunctions()")
    println(demoScopeFunctions())   // 19
    println("-----------------------")

    // ---------- collection functions (map, filter, forEach, etc.) ----------
    println("demoCollections()")
    println(demoCollections())      // 22
    println("-----------------------")

    // ---------- map functions (mapOf, containsKey, mapValues, etc.) ----------
    println("demoMaps()")
    println(demoMaps())             // 67
    println("-----------------------")

    // ---------- operators (compound assignment, ++/--, unary, do-while) ----------
    println("demoCompoundAssignment()")
    println(demoCompoundAssignment())  // 24
    println("demoDoWhile()")
    println(demoDoWhile())             // 5
    println("-----------------------")

    // ---------- class features (body properties, getter, setter, type-when) ----------
    println("demoCounter()")
    println(demoCounter())             // 3
    println("demoTypeWhen")
    println(demoTypeWhen("hello"))     // string
    println(demoTypeWhen(42))          // number
    println(demoTypeWhen(true))        // boolean
    println("-----------------------")

    // ---------- operator overloads (Vec2: +, -, *, unary-, compareTo, toString) ----
    println("demoVec2Operators()")
    println(demoVec2Operators())       // 10
    println("demoInvokeOperator()")
    println(demoInvokeOperator())      // 21
    println("-----------------------")

    // ---------- extension function -------------------------------------------------
    println("demoExtensionFunction()")
    println(demoExtensionFunction())   // hello !
    println("-----------------------")

    // ---------- custom infix function -----------------------------------------------
    println("demoCustomInfix()")
    println(demoCustomInfix())         // 1
    println("-----------------------")

    // ---------- with() scope function -----------------------------------------------
    println("demoWith()")
    println(demoWith())                // 30
    println("-----------------------")

    // ---------- collection binary operators (+, -) ----------------------------------
    println("demoCollectionOperators()")
    println(demoCollectionOperators()) // 10
    println("-----------------------")

    // ---------- matches (dot and infix) ---------------------------------------------
    println("demoMatches()")
    println(demoMatches())             // 3
    println("-----------------------")

    // ---------- companion object + singleton + data class ───────────────────────
    println("demoCompanion()")
    println(demoCompanion())           // localhost:8080 / example.com:443
    println("demoSingleton()")
    println(demoSingleton())           // LOG[1]: start | LOG[2]: end
    println("demoDataClass()")
    println(demoDataClass())           // Vector2(x=1, y=2) / Vector2(x=3, y=2) / 3:2
    println("-----------------------")

    // ---------- string functions ----------------------------------------------------
    println("demoMultiLineString()")
    println(demoMultiLineString())     // Roses are red,
    println("demoTrimMargin()")
    println(demoTrimMargin())          // Hello,\nWorld!
    println("demoStringCase()")
    println(demoStringCase())          // HELLO WORLD/hello world
    println("demoStringTrim()")
    println(demoStringTrim())          // hello
    println("demoStringSearch()")
    println(demoStringSearch())        // 7/true/true/true
    println("demoStringSubstring()")
    println(demoStringSubstring())     // World
    println("demoStringSplit()")
    println(demoStringSplit())         // 3
    println("demoStringLines()")
    println(demoStringLines())         // 3
    println("demoStringReplace()")
    println(demoStringReplace())       // Hello, Kotlin!
    println("demoStringReplaceRegex()")
    println(demoStringReplaceRegex())  // foo#bar#
    println("demoStringRepeat()")
    println(demoStringRepeat())        // ababab
    println("demoStringPad()")
    println(demoStringPad())           // 00042/42---
    println("demoStringRemove()")
    println(demoStringRemove())        // Hello/Hello
    println("demoStringConvert()")
    println(demoStringConvert())       // 42/true/true
    println("demoStringBlank()")
    println(demoStringBlank())         // true/true
    println("demoStringFormat()")
    println(demoStringFormat())        // Hello, World! You are 30 years old.
    println("demoStringReversed()")
    println(demoStringReversed())      // olleH
    println("demoStringContainsAndCount()")
    println(demoStringContainsAndCount()) // true/13
    println("-----------------------")

    // ---------- exception handling ---------------------------------------------------
    println("demoThrowAndCatch()")
    println(demoThrowAndCatch())       // caught: error
    println("demoTryCatchFinally()")
    println(demoTryCatchFinally())     // try+catch+finally
    println("demoTrySuccess()")
    println(demoTrySuccess())          // success: 42
    println("demoTryWithNumericOp()")
    println(demoTryWithNumericOp())    // 123
    println("demoTryConversionError()")
    println(demoTryConversionError())  // -1
    println("demoNestedTryCatch()")
    println(demoNestedTryCatch())      // outer-try inner-catch after-inner
    println("-----------------------")

    println("demoCoolCatPlusAssign()")
    println(demoCoolCatPlusAssign())
    println("demoExtensionProperty()")
    println(demoExtensionProperty())
    println("demoExtensionFunctionOnUserDefined()")
    println(demoExtensionFunctionOnUserDefined())
    println("demoClassExtensionProperty()")
    println(demoClassExtensionProperty())
    println("demoAllCompoundAssignOverloads()")
    println(demoAllCompoundAssignOverloads())
    println("-----------------------")
}

