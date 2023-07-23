local util = {};
---@module GhostUtil
---@class Utilities

util.debugPrint = function(text, color)
    if stringStartsWith(color, "0xFF") then else color = "0xFF"..color end
    runHaxeCode("game.addTextToDebug('"..tostring((text or "NULL")).."', "..(color or "0xFFFFFFFF")..");")
end

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