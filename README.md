# ktox-lua-example

> **Docs:** [isycat.github.io/ktox-lua](https://isycat.github.io/ktox-lua)

Example project for [ktox-lua](https://isycat.github.io/ktox-lua) — a Gradle plugin that transpiles Kotlin (JVM) source code to Lua.

## What this project demonstrates

The Kotlin source files in `src/main/kotlin/com/example/` cover a wide range of language features, each with a matching Lua test in `src/lua-test/`:

| Feature area | Kotlin source | Lua test |
|---|---|---|
| Basic class & methods | `math/Calculator.kt` | `test_calculator.lua` |
| Inheritance & polymorphism | `features/Animal.kt` | `test_inheritance.lua` |
| `when` expression | `features/ControlFlowDemo.kt` | `test_when.lua` |
| Control flow (`for`, `while`, `if`-expression) | `features/ControlFlowDemo.kt` | `test_control_flow.lua` |
| Null safety (`?.`, `?:`) | `features/NullSafetyDemo.kt` | `test_null_safety.lua` |
| Collections (`map`, `filter`, `forEach`, …) | `features/CollectionDemo.kt` | `test_collections.lua` |
| Maps | `features/MapDemo.kt` | `test_maps.lua` |
| Operator overloads & infix functions | `features/OperatorsDemo.kt`, `features/InfixAndOperatorDemo.kt` | `test_operators.lua`, `test_infix_and_operators.lua` |
| Class features (properties, getters/setters, companion, data class) | `features/ClassFeaturesDemo.kt` | `test_class_features.lua` |
| Advanced class features (extension functions/properties, scope functions) | `features/AdvancedClassDemo.kt` | `test_advanced_classes.lua` |
| Enums & objects | `features/Shapes.kt` | `test_enums_objects.lua` |
| String operations | `features/StringDemo.kt` | `test_strings.lua` |
| Exception handling | `features/ExceptionDemo.kt` | `test_exceptions.lua` |

Generated Lua is written to `outputDir/vscripts/` and is committed to source control so you can inspect the transpiler output without building.

## Requirements

- JDK 21 or later (the Gradle wrapper downloads Gradle automatically)

## Building

```bash
./gradlew build
```

## Running the generated Lua

```bash
./gradlew runLua
```

This executes `Main.lua` (the entry point configured in `build.gradle.kts`) and exercises every demonstrated feature.

## Plugin configuration (`build.gradle.kts`)

```kotlin
kotlinToLua {
    // Strip "com.example" so generated Lua sits at the project root
    rootNamespace = "com.example"
    // Entry point for ./gradlew runLua
    luaEntryPoint = "Main.lua"
    // Output directory for generated Lua
    outputDirectory = layout.projectDirectory.dir("outputDir/vscripts")
}
```

See the [ktox-lua docs](https://isycat.github.io/ktox-lua) for the full list of configuration options and supported Kotlin features.

