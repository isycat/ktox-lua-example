-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/Shapes.kt", {["1-36"]=1,["37"]=28,["38"]=29,["39-40"]=30,["41-42"]=31,["43-44"]=32,["45-46"]=33,["47-78"]=35,["79"]=57,["80"]=58,["81-82"]=59,["83-84"]=60,["85-86"]=61,["87-88"]=62,["89-92"]=64,["93"]=69,["94"]=70,["95-96"]=71,["97-98"]=72,["99-100"]=73,["101-102"]=74,["103-105"]=76})

local Color = {}

Color.RED = "RED"
Color.GREEN = "GREEN"
Color.BLUE = "BLUE"

ShapeRegistry = {}

function ShapeRegistry.getDefaultColor()
    return "RED"
end


Shapes = {}
Shapes.__index = Shapes

function Shapes:new()
    local self = setmetatable({}, Shapes)
    return self
end


function demoEnum()
    return Color.RED
end

function demoObject()
    return ShapeRegistry.getDefaultColor()
end

function demoWhen(n)
    local result = "other"
    if n == 1 then
        result = "one"
    elseif n == 2 then
        result = "two"
    elseif n == 3 then
        result = "three"
    elseif n == 4 or n == 5 or n == 6 then
        result = "four-to-six"
    end
    return result
end

function demoWhenV2(n)
    return (function()
        if n == 1 then
            return "one"
        elseif n == 2 then
            return "two"
        elseif n == 3 then
            return "three"
        elseif (n >= 4 and n <= 6) then
            return "four-to-six"
        else
            return "other"
        end
    end)()
end

function demoWhenExpression(n)
    return (function()
        if n == 1 then
            return "one"
        elseif n == 2 then
            return "two"
        else
            return "other"
        end
    end)()
end

function demoWhenNoSubject(x)
    local label = ""
    if x > 100 then
        label = "huge"
    elseif x > 10 then
        label = "big"
    elseif x > 0 then
        label = "positive"
    else
        label = "non-positive"
    end
    return label
end

function demoWhenRange(n)
    local result = "unknown"
    if (n >= 1 and n <= 3) then
        result = "low"
    elseif (n >= 4 and n < 8) then
        result = "mid"
    elseif not (n >= 1 and n <= 10) then
        result = "out"
    else
        result = "high"
    end
    return result
end

