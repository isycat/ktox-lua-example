-- test_advanced_classes.lua
-- Tests for companion objects, singleton objects, and data classes.

require("ktox-lib")
ktox_require("features/AdvancedClassDemo")

-- ─── Companion object ─────────────────────────────────────────────────────────

ktox_test("Config.DEFAULT_PORT is 8080", function()
    ktox_assert_eq(Config.DEFAULT_PORT, 8080)
end)

ktox_test("Config.default() returns localhost:8080", function()
    local cfg = Config.default()
    ktox_assert_eq(cfg.host, "localhost")
    ktox_assert_eq(cfg.port, 8080)
end)

ktox_test("Config.custom() returns custom host and port", function()
    local cfg = Config.custom("example.com", 443)
    ktox_assert_eq(cfg.host, "example.com")
    ktox_assert_eq(cfg.port, 443)
end)

ktox_test("demoCompanion() combines both configs", function()
    ktox_assert_eq(demoCompanion(), "localhost:8080 / example.com:443")
end)

-- ─── Singleton object ─────────────────────────────────────────────────────────

ktox_test("EventLog.prefix is 'LOG'", function()
    ktox_assert_eq(EventLog.prefix, "LOG")
end)

ktox_test("EventLog.record() increments count and formats message", function()
    EventLog.reset()
    local msg = EventLog.record("hello")
    ktox_assert_eq(msg, "LOG[1]: hello")
    ktox_assert_eq(EventLog.count, 1)
end)

ktox_test("EventLog.reset() sets count back to 0", function()
    EventLog.reset()
    EventLog.record("a")
    EventLog.record("b")
    ktox_assert_eq(EventLog.count, 2)
    EventLog.reset()
    ktox_assert_eq(EventLog.count, 0)
end)

ktox_test("demoSingleton() returns two log messages", function()
    EventLog.reset()
    ktox_assert_eq(demoSingleton(), "LOG[1]: start | LOG[2]: end")
end)

-- ─── Data class ───────────────────────────────────────────────────────────────

ktox_test("Vector2:new() stores fields", function()
    local v = Vector2:new(3, 4)
    ktox_assert_eq(v.x, 3)
    ktox_assert_eq(v.y, 4)
end)

ktox_test("Vector2:equals() compares fields", function()
    local a = Vector2:new(1, 2)
    local b = Vector2:new(1, 2)
    local c = Vector2:new(1, 3)
    ktox_assert_eq(a:equals(b), true)
    ktox_assert_eq(a:equals(c), false)
end)

ktox_test("Vector2 __eq metamethod works", function()
    local a = Vector2:new(5, 6)
    local b = Vector2:new(5, 6)
    ktox_assert_eq(a == b, true)
end)

ktox_test("Vector2:toString() formats correctly", function()
    local v = Vector2:new(7, 8)
    ktox_assert_eq(v:toString(), "Vector2(x=7, y=8)")
end)

ktox_test("Vector2 __tostring metamethod works", function()
    local v = Vector2:new(9, 10)
    ktox_assert_eq(tostring(v), "Vector2(x=9, y=10)")
end)

ktox_test("Vector2:copy() with new values replaces specified fields", function()
    local v1 = Vector2:new(1, 2)
    local v2 = v1:copy(3, nil)
    ktox_assert_eq(v2.x, 3)
    ktox_assert_eq(v2.y, 2)
end)

ktox_test("Vector2:copy() with no args returns identical vector", function()
    local v1 = Vector2:new(4, 5)
    local v2 = v1:copy()
    ktox_assert_eq(v2.x, 4)
    ktox_assert_eq(v2.y, 5)
end)

ktox_test("Vector2:component1() returns x", function()
    local v = Vector2:new(11, 22)
    ktox_assert_eq(v:component1(), 11)
end)

ktox_test("Vector2:component2() returns y", function()
    local v = Vector2:new(11, 22)
    ktox_assert_eq(v:component2(), 22)
end)

ktox_test("demoDataClass() exercises copy and componentN", function()
    local result = demoDataClass()
    ktox_assert_eq(result, "Vector2(x=1, y=2) / Vector2(x=3, y=2) / 3:2")
end)
