-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/ClassFeaturesDemo.kt", {["1-15"]=1,["16"]=17,["17-20"]=18,["21-115"]=22,["116"]=76,["117"]=77,["118"]=78,["119"]=79,["120-122"]=80})

Counter = {}
Counter.__index = Counter

function Counter:new()
    local self = setmetatable({}, Counter)
    self.count = 0
    return self
end

function Counter:increment()
    self.count = self.count + 1
    return self.count
end

function Counter:reset()
    self.count = 0
end

function Counter:readCount()
    return self.count
end


Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle:new(w, h)
    local self = setmetatable({}, Rectangle)
    self.w = w
    self.h = h
    return self
end

function Rectangle:getArea()
    return self.w * self.h
end

function Rectangle:getPerimeter()
    return (self.w + self.h) * 2
end


Label = {}
Label.__index = Label

function Label:new(initial)
    local self = setmetatable({}, Label)
    self.text = initial
    return self
end

function Label:setText(v)
    self.text = v
end

function Label:readText()
    return self.text
end


-- Interface: Describable
local Describable = {}
Describable.__index = Describable

function Describable:describe() end
function Describable:shortName() end

Product = {}
Product.__index = Product

function Product:new(name, price)
    local self = setmetatable({}, Product)
    self.name = name
    self.price = price
    return self
end

function Product:describe()
    return tostring(self.name) .. ": " .. tostring(self.price)
end

function Product:shortName()
    return self.name
end


ClassFeaturesDemo = {}
ClassFeaturesDemo.__index = ClassFeaturesDemo

function ClassFeaturesDemo:new()
    local self = setmetatable({}, ClassFeaturesDemo)
    return self
end


function demoTypeWhen(x)
    return (function()
        if type(x) == "string" then
            return "string"
        elseif type(x) == "number" then
            return "number"
        elseif type(x) == "boolean" then
            return "boolean"
        else
            return "other"
        end
    end)()
end

function demoCounter()
    local c = Counter:new()
    c:increment()
    c:increment()
    c:increment()
    return c:readCount()
end

