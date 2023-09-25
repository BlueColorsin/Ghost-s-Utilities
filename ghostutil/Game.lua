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

return game;