-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/ExceptionDemo.kt", {["1-31"]=1,["32-36"]=15,["37-38"]=18,["39-42"]=20,["43"]=24,["44-49"]=25,["50-51"]=29,["52"]=31,["53-56"]=33,["57"]=37,["58-63"]=38,["64-65"]=42,["66-69"]=44,["70"]=48,["71-76"]=49,["77-78"]=53,["79-82"]=55,["83"]=59,["84-89"]=60,["90-91"]=64,["92-95"]=66,["96"]=70,["97-109"]=71,["110-111"]=80,["112-114"]=82})

AppException = {}
AppException.__index = AppException

function AppException:new(message)
    local self = setmetatable({}, AppException)
    self.message = message
    return self
end

function AppException:equals(other)
    return self.message == other.message
end
AppException.__eq = function(a, b) return a:equals(b) end
function AppException:toString()
    return "AppException(" .. "message=" .. tostring(self.message) .. ")"
end
AppException.__tostring = function(a) return a:toString() end
function AppException:copy(message)
    if message == nil then message = self.message end
    return AppException:new(message)
end
function AppException:component1()
    return self.message
end

function demoThrowAndCatch()
    local __ok, __err = pcall(function()
        error(RuntimeException:new("something went wrong"))
    end)
    if not __ok then
        local e = __err
        return "caught: error"
    end
    return "no error"
end

function demoTryCatchFinally()
    local result = ""
    local __ok, __err = pcall(function()
        result = "try"
        error(RuntimeException:new("fail"))
    end)
    if not __ok then
        local e = __err
        result = result .. "+catch"
    end
    result = result .. "+finally"
    return result
end

function demoTrySuccess()
    local result = "error"
    local __ok, __err = pcall(function()
        local x = 42
        result = "success: " .. tostring(x)
    end)
    if not __ok then
        local e = __err
        result = "error"
    end
    return result
end

function demoTryWithNumericOp()
    local result = 0
    local __ok, __err = pcall(function()
        local s = "123"
        result = ktox_toInt(s)
    end)
    if not __ok then
        local e = __err
        result = -1
    end
    return result
end

function demoTryConversionError()
    local result = -1
    local __ok, __err = pcall(function()
        local s = "notanumber"
        result = ktox_toInt(s)
    end)
    if not __ok then
        local e = __err
        result = -1
    end
    return result
end

function demoNestedTryCatch()
    local log = ""
    local __ok, __err = pcall(function()
        log = log .. "outer-try "
        local __ok, __err = pcall(function()
            error(RuntimeException:new("inner"))
        end)
        if not __ok then
            local e = __err
            log = log .. "inner-catch "
        end
        log = log .. "after-inner "
    end)
    if not __ok then
        local e = __err
        log = log .. "outer-catch "
    end
    return ktox_trim(log)
end

