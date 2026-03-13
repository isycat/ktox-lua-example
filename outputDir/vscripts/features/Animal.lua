-- package: com.example.features

require("ktox-lib")
ktox_sourcemap_traceback(debug and debug.getinfo and (debug.getinfo(1) or {}).short_src or "", "features/Animal.kt", {["1-43"]=1,["44"]=22,["45"]=23,["46"]=24,["47-49"]=25})

Animal = {}
Animal.__index = Animal

function Animal:new(name)
    local self = setmetatable({}, Animal)
    self.name = name
    return self
end

function Animal:describe()
    return "Animal: " .. tostring(self.name)
end


Dog = setmetatable({}, {__index = Animal})
Dog.__index = Dog

function Dog:new(name)
    local self = Animal:new(name)
    setmetatable(self, Dog)
    return self
end

function Dog:bark()
    return tostring(self.name) .. " says: Woof!"
end


AnimalDemo = {}
AnimalDemo.__index = AnimalDemo

function AnimalDemo:new()
    local self = setmetatable({}, AnimalDemo)
    return self
end


function demoInheritance()
    local dog = Dog:new("Rex")
    local desc = dog:describe()
    local sound = dog:bark()
    return tostring(desc) .. ", " .. tostring(sound)
end

