local util = {};
---@class Utilities

local d = require "ghostutil.Debug"

---Converts any value to a boolean
---@param v any Value
---@return boolean
util.toBool = function(v)
    -- Conversion
    if tostring(v) == "0" then return false
    elseif tostring(v) == "1" then return true

    elseif tostring(v) == "false" then return false
    elseif tostring(v) == "true" then return true
    else d.error("utilities.toBool:1: Failed converting value to a boolean")
    end
end

util.isNaN = util.Nil
util.isNull = util.Nil

---Checks if a value is nil / null / NaN
---@param v any
---@return boolean
util.isNil = function(v)
    return type(v) == "nil"
end

---Checks if a value if a boolean type
---@param v any
---@return boolean
util.isBool = function(v)
    return type(v) == "boolean"
end

---Checks if a value if a number type
---@param v any
---@return boolean
util.isNumber = function(v)
    return type(v) == "number"
end

---Basically, `debugPrint()` with Color
---@param color string FlxColor
---@param text string
util.debugPrint = function(color, text)
    if stringStartsWith(color, "0xFF") then else color = "0xFF"..color end
    for i in text do
        runHaxeCode("game.addTextToDebug('"..tostring(text).."', "..(color or "0xFFFFFFFF")..");")
    end
end

---All-in-one `makeLuaText()` 
---@param tag string Text tag
---@param txt string Text's string
---@param fieldWidth number Field width of the text
---@param x number X position
---@param y number Y position
---@param scale number Scale of text
---@param instantAdd boolean Do you want to add it without needing to use `addLuaText()` after?
---@param alignment string Left, center, right
---@param color string FlxColor
---@param isCentered boolean Do you want it to be centered
---@param centerType string xy, x, y
util.quickText = function(tag, txt, fieldWidth, x, y, scale, instantAdd, alignment, color, isCentered, centerType)
    makeLuaText(tag, txt, fieldWidth, x, y)
    if scale == "" or scale == nil then
        setTextSize(tag, 24)
    else
        setTextSize(tag, scale)
    end
    if alignment == "" or alignment == nil or not alignment == "left" or not alignment == "center" or not alignment == "right" then
        setTextAlignment(tag, "left")
    else
        setTextAlignment(tag, alignment)
    end
    if not color == nil or not color == "" then
        setTextColor(tag, color)
    end
    if instantAdd then
        addLuaText(tag)
    end
    if isCentered then
        if centerType == "center" then
            screenCenter(tag, "xy")
        else
            screenCenter(tag, centerType)
        end
    end
end

return util;