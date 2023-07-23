local game = {};
---@module GhostUtil
---@class Game

local c = require "ghostutil.Color";
local d = require "ghostutil.Debug"

-- LUA Variables
-- idk what to put

-- Functions
game.getHealthColor = function(char)
    char = char:lower()
    if not char == "boyfriend" or not char == "dad" then
        if char == "bf" then char = "boyfriend" else
            d.error("game.getHealthColor:1: Unknown value: '"..char.."'")
        end
    end
    return "0xFF"..c.rgbToHex(getProperty(char..".healthColorArray[0]"), getProperty(char..".healthColorArray[1]"), getProperty(char..".healthColorArray[2]"));
end

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