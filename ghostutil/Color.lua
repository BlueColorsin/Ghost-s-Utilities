local color = {};
---@class Color

local d = require "ghostutil.Debug"

color.WHITE = "0xFFFFFFFF"
color.GRAY = "0xFF808080"
color.BLACK = "0xFF000000"

color.RED = "0xFFFF0000"
color.BLUE = "0xFF0000FF"
color.GREEN = "0xFF008000"
color.PINK = "0xFFFFC0CB"
color.MAGENTA = "0xFFFF00FF"
color.PURPLE = "0xFF800080"
color.LIME = "0xFF00FF00"
color.YELLOW = '0xFFFFFF00'
color.ORANGE = "0xFFFFA500"
color.CYAN = "0xFF00FFFF"

---Sets an object color to the target value
---@param spr string Object
---@param val string The target color. (RRGGBB)
color.setSpriteColor = function(spr, val)
    if spr ~= nil then setProperty(spr..".color", (val or "FFFFFF")) else
        d.error("color.setSpriteColor:1: Expected a value")
    end
end

---Returns an object color
---@param spr string
color.getSpriteColor = function(spr)
    if spr ~= nil then return getProperty(spr..".color") else
        d.error("color.getSpriteColor:1: Expected a value")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    end
end

---Converts RGB to the Hex format (RRGGBB).
---@param r integer
---@param g integer
---@param b integer
---@return string
color.rgbToHex = function(r,g,b)
    if r == nil or g == nil or b == nil then
        d.warning("color.rgbToHex: Invalid value. nil -> 255")
    end
    return string.format("%02X%02X%02X", (r or 255), (g or 255), (b or 255))
end

return color;