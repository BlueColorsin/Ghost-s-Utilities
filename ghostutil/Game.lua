local game = {};
---@class Game

local c = require "ghostutil.Color";
local d = require "ghostutil.Debug"
local m = require "ghostutil.Math"

---Returns the current health color of the target in hex
---@param char string Dad or Boyfriend
---@return string
game.getHealthColor = function(char)
    char = char:lower()
    if char == "bf" then char = "boyfriend" end
    if (char ~= "boyfriend" and char ~= "dad") then 
        d.error("game.getHealthColor:1: Unknown value: '"..char.."'")
    else
        return "0xFF"..c.rgbToHex(getProperty(char..".healthColorArray[0]"), getProperty(char..".healthColorArray[1]"), getProperty(char..".healthColorArray[2]"));
    end
end

---Checks if a certain LUA object exists
---@param objType string Sound, sprite or text
---@param obj string LUA object
---@return boolean
game.traceLuaObject = function(objType, obj)
    local exists = false
    if objType:lower() == "sound" then
        exists = luaSoundExists(obj)
    elseif objType:lower() == "sprite" then
        exists = luaSpriteExists(obj)
    elseif objType:lower() == "text" or objType:lower() == "txt" then
        exists = luaTextExists(obj)
    else
        d.error("game.traceLuaObject:1: Unknown value: '"..objType.."'")
    end

    return exists
end

---Sets the sprite's origin to its center - useful after adjusting `scale` to make sure rotations work as expected.
---@param obj string Object
game.centerOrigin = function(obj)
    setOrigin(getProperty(obj..".frameWidth") * 0.5, getProperty(obj..".frameHeight") * 0.5)
end

---Sets the sprite's origin position
---@param obj string Object
---@param x number New X origin position
---@param y number New Y origin position
game.setOrigin = function(obj, x, y)
    setProperty(obj..".origin.x", x); setProperty(obj..".origin.y", y)
end

---Returns the values of the origin position of the target object using a table
---@param obj string Object
---@return table
game.getOrigin = function(obj)
    local table = {
        x = getProperty(obj..".origin.x"),
        y = getProperty(obj..".origin.y")
    }
    return table;
end

---Sets the sprite's position
---@param obj string Object
---@param x number New X position
---@param y number New Y position
game.setPosition = function(obj, x, y)
    setProperty(obj..".x", x); setProperty(obj..".y", y)
end

---Returns the values of the position of the target object using a table
---@param obj string Object
---@return table
game.getPosition = function(obj)
    local table = {
        x = getProperty(obj..".x"),
        y = getProperty(obj..".y")
    }
    return table;
end

return game;