package com.example.features

/**
 * Demonstrates class definitions, constructor property fields, class
 * inheritance via `setmetatable`, and instance method calls.
 *
 * Generated Lua: Animal and Dog are both global tables with `:new()` constructors.
 * `demoInheritance()` is a global function callable from Main.lua after
 * `require("features/Animal")`.
 */
open class Animal(val name: String) {
    fun describe(): String = "Animal: ${this.name}"
}

class Dog(name: String) : Animal(name) {
    fun bark(): String = "${this.name} says: Woof!"
}

class AnimalDemo

fun demoInheritance(): String {
    val dog = Dog("Rex")
    val desc = dog.describe()
    val sound = dog.bark()
    return "${desc}, ${sound}"
}
