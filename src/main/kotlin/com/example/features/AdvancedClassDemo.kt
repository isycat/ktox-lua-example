package com.example.features

/**
 * Demonstrates:
 *   - Companion objects: static factory methods and constants on the class table
 *   - Singleton objects: global tables with static state and methods
 *   - Data classes: auto-generated equals, toString, copy, componentN
 */

// ─── Companion object ─────────────────────────────────────────────────────────

/** A class that owns a companion object providing a factory and a constant. */
class Config(val host: String, val port: Int) {
    companion object {
        val DEFAULT_PORT = 8080
        fun default(): Config = Config("localhost", 8080)
        fun custom(host: String, port: Int): Config = Config(host, port)
    }
}

// ─── Singleton object ──────────────────────────────────────────────────────────

/** A global singleton that accumulates a running total. */
object EventLog {
    var count = 0
    val prefix = "LOG"

    fun record(msg: String): String {
        EventLog.count++
        return "${EventLog.prefix}[${EventLog.count}]: $msg"
    }

    fun reset() {
        EventLog.count = 0
    }
}

// ─── Data class ───────────────────────────────────────────────────────────────

/** A simple value type; equals/toString/copy/componentN are auto-generated. */
data class Vector2(val x: Int, val y: Int)

class AdvancedClassDemo

// ─── Demo functions ───────────────────────────────────────────────────────────

fun demoCompanion(): String {
    val cfg = Config.default()
    val custom = Config.custom("example.com", 443)
    return "${cfg.host}:${cfg.port} / ${custom.host}:${custom.port}"
}

fun demoSingleton(): String {
    EventLog.reset()
    val a = EventLog.record("start")
    val b = EventLog.record("end")
    return "${a} | ${b}"
}

fun demoDataClass(): String {
    val v1 = Vector2(1, 2)
    val v2 = v1.copy(3, 2)
    val x = v2.component1()
    val y = v2.component2()
    return "${v1} / ${v2} / ${x}:${y}"
}
