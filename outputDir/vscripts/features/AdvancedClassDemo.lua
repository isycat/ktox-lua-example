-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/AdvancedClassDemo.kt", {["1-33"]=1,["34"]=29,["35-38"]=30,["39-82"]=34,["83"]=48,["84"]=49,["85-88"]=50,["89"]=54,["90"]=55,["91"]=56,["92-95"]=57,["96"]=61,["97"]=62,["98"]=63,["99"]=64,["100-102"]=65})

Config = {}
Config.__index = Config

function Config:new(host, port)
    local self = setmetatable({}, Config)
    self.host = host
    self.port = port
    return self
end

Config.DEFAULT_PORT = 8080

function Config.default()
    return Config:new("localhost", 8080)
end

function Config.custom(host, port)
    return Config:new(host, port)
end


EventLog = {}

EventLog.count = 0

EventLog.prefix = "LOG"

function EventLog.record(msg)
    EventLog.count = EventLog.count + 1
    return tostring(EventLog.prefix) .. "\[" .. tostring(EventLog.count) .. "\]: " .. tostring(msg)
end

function EventLog.reset()
    EventLog.count = 0
end


Vector2 = {}
Vector2.__index = Vector2

function Vector2:new(x, y)
    local self = setmetatable({}, Vector2)
    self.x = x
    self.y = y
    return self
end

function Vector2:equals(other)
    return self.x == other.x and self.y == other.y
end
Vector2.__eq = function(a, b) return a:equals(b) end
function Vector2:toString()
    return "Vector2(" .. "x=" .. tostring(self.x) .. ", " .. "y=" .. tostring(self.y) .. ")"
end
Vector2.__tostring = function(a) return a:toString() end
function Vector2:copy(x, y)
    if x == nil then x = self.x end
    if y == nil then y = self.y end
    return Vector2:new(x, y)
end
function Vector2:component1()
    return self.x
end
function Vector2:component2()
    return self.y
end

AdvancedClassDemo = {}
AdvancedClassDemo.__index = AdvancedClassDemo

function AdvancedClassDemo:new()
    local self = setmetatable({}, AdvancedClassDemo)
    return self
end


function demoCompanion()
    local cfg = Config.default()
    local custom = Config.custom("example.com", 443)
    return tostring(cfg.host) .. ":" .. tostring(cfg.port) .. " / " .. tostring(custom.host) .. ":" .. tostring(custom.port)
end

function demoSingleton()
    EventLog.reset()
    local a = EventLog.record("start")
    local b = EventLog.record("end")
    return tostring(a) .. " | " .. tostring(b)
end

function demoDataClass()
    local v1 = Vector2:new(1, 2)
    local v2 = v1:copy(3, 2)
    local x = v2:component1()
    local y = v2:component2()
    return tostring(v1) .. " / " .. tostring(v2) .. " / " .. tostring(x) .. ":" .. tostring(y)
end

