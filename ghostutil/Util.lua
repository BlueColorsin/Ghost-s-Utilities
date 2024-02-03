local util = {};
---@class Utilities

local d = require "ghostutil.Debug"

<<<<<<< Updated upstream
=======
---@author GhostglowDev, galactic_2005
---@param ease string
---@return string FlxEase
local function getFlxEaseByString(ease)
    local eases = {
        ["back"] = "back", ["bounce"] = "bounce", ["circ"] = "circ", ["cube"] = "cube",
        ["elastic"] = "elastic", ["expo"] = "expo", ["quad"] = "quad", ["quart"] = "quart",
        ["quint"] = "quint", ["sine"] = "sine", ["smoothstep"] = "smoothStep", ["smootherstep"] = "smootherStep"
    }

    local easeEndings = {
        "InOut", "In", "Out"
    }

    local easeEnd = ''
    for _, value in ipairs(easeEndings) do
        if stringEndsWith(ease:lower(), value:lower()) then
            easeEnd = value
            break
        end
    end

    local easeNew = ease:sub(1, #ease - #easeEnd)
    if eases[easeNew:lower()] then
        easeNew = eases[easeNew:lower()]
        return "FlxEase." .. easeNew .. easeEnd
    end
    return "FlxEase.linear"
end

---Tweens a number (the tweened values are returned on a callback called "onNumberTween")
---@param tag string for `onTweenCompleted`
---@param from number The number where the tween starts at
---@param to number The number where the tween stops at
---@param duration number The time it takes to complete
---@param ease string FlxEase
---@author GhostglowDev, T-Bar
util.doTweenNumber = function(tag, from, to, duration, ease)
    if tag == nil or from == nil or to == nil then d.error("util.doTweenNumber:".. (tag == nil and "1" or ((tag == nil and (from == nil or to == nil)) and "1-2/3" or "2/3")) ..": Value is null/nil") return else
        value, duration, ease = tostring(value), tostring(duration) or "1", ease or "linear"
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.set(']]..tag..[[', 
                FlxTween.num(]]..tostring(from)..[[, ]]..tostring(to)..[[, ]]..duration..[[, {
                    ease: ]]..getFlxEaseByString(ease)..[[, 
                    onComplete: () -> { 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("onTweenCompleted", ["]]..tag..[["]); 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.remove(']]..tag..[[');
                    }
                }, (num) -> {
                    ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("onNumberTween", ["]]..tag..[[", num]);
                })
            );
        ]])
    end
end

>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
util.isNaN = util.Nil
util.isNull = util.Nil

---Checks if a value is nil / null / NaN
=======
---Runs a lua code from a file (any file format)
---@param file string The file to fetch (must include extension)
util.runLuaFromFile = function(file)
    if io.open("mods/".. currentModDirectory .. file) == nil then d.error("util.runLuaFromFile: File '"..file.."' doesn't exist!") return end 

    local loadCode = load or loadstring
    loadCode(getTextFromFile(file))()
end

---yeah man
---@param case any
---@param cases any
util.switch = function(case, cases)
    if (cases[case]) then cases[case]()
    elseif (cases["default"]) then cases["default"]() end
end

---Checks if the given value is type `t`
---@param self any
---@param t string 
util.isOfType = function(self, t)
    return type(self) == t:lower()
end

---Checks if a value is nil
>>>>>>> Stashed changes
---@param v any
---@return boolean
util.isNil = function(self)
    return type(self) == "nil"
end

<<<<<<< Updated upstream
---Checks if a value if a boolean type
---@param v any
=======
---Checks if a value is NaN
util.isNaN = util.isNil
---Checks if a value is null
util.isNull = util.isNil

---Checks if a value is a boolean
---@param self any
>>>>>>> Stashed changes
---@return boolean
util.isBool = function(self)
    return type(self) == "boolean"
end

<<<<<<< Updated upstream
---Checks if a value if a number type
---@param v any
=======
---Checks if a value is a number
---@param self any
>>>>>>> Stashed changes
---@return boolean
util.isNumber = function(self)
    return type(self) == "number"
end

<<<<<<< Updated upstream
=======
---Checks if a value is a string
---@param self any
---@return boolean
util.isString = function(self)
    return type(self) == "string"
end

---Checks if a value is a table
---@param self any
---@return boolean
util.isTable = function(self)
    return type(self) == "table"
end

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
---@param pos table<number> Positions in a table. Example: {100, 300}
---@param instantAdd? boolean Do you want to add it without needing to use `addLuaText()` after?
---@param size? number Scale of the text. Example: {2, 2.45}
---@param alignment? string Left, center, right
---@param color? string FlxColor (color of the text)
---@param centerType? string xy, x, y. Set it to nil if you don't want it to center.
---@author Apollo
util.quickText = function(tag, txt, fieldWidth, pos, instantAdd, size, alignment, color, centerType)
    pos = (util.isTable(pos) and {pos[1], pos[2]} or {pos, pos})
    makeLuaText(tag, txt, fieldWidth, pos[1], pos[2])
    setTextSize(tag, (size or 24))
    setTextAlignment(tag, (alignment or "left"))
    setTextColor(tag, (color or "FFFFFF"))
    if instantAdd then
        addLuaText(tag)
    end
    if centerType ~= nil then
        screenCenter(tag, (centerType or "xy"))
    end
end

---All-in-one `makeLuaSprite()`, made as a lua sprite counterpart to the function 'quickText'.
---@param tag string Sprite tag
---@param filePath string Sprite's file path, starts in the "images" folder (in assets or in mods)
---@param pos table<number> Positions in a table. Example: {100, 300}
---@param instantAdd? boolean Do you want to add it without needing to use `addLuaSprite()` after?
---@param inFrontOfChars? boolean Is the sprite in front of the characters?
---@param scrollFactor? table<number> Scroll Factor of the sprite. Example: {3, 1}
---@param scale? table<number> Scale of the sprite. Example: {2, 2.45}
---@param camera? string What camera should the sprite be added on?
---@param color? string FlxColor (color of the sprite)
---@param centerType? string xy, x, y. Set it to nil if you don't want it to center.
---@param shader? string Name of the shader from the `shaders` folder
---@author T-Bar, inspired by Apollo
util.quickSprite = function(tag, filePath, pos, instantAdd, inFrontOfChars, scrollFactor, scale, camera, centerType, color, shader)
    pos = (util.isTable(pos) and {pos, pos} or pos)
    scale = (util.isTable(scale) and {(scale or 1), (scale or 1)} or (scale or {1, 1}))
    scrollFactor = (util.isTable(scrollFactor) and {(scrollFactor[1] or (getCameraFromString(camera) == "camGame" and 1 or 0)), (scrollFactor[2] or (getCameraFromString(camera) == "camGame" and 1 or 0))} or (scrollFactor or (getCameraFromString(camera) == "camGame" and {1, 1} or {0, 0})))
	makeLuaSprite(tag, filePath, pos[1], pos[2])
	scaleObject(tag, scale[1], scale[2])
	setScrollFactor(tag, scrollFactor[1], scrollFactor[2])
	c.setSpriteColor(tag, color)
    setObjectCamera(tag, camera)
	setObjectShader(tag, (shader or nil))
	if instantAdd then
		addLuaSprite(tag, (inFrontOfChars or false))
	end
    if ceneterType ~= nil then
		screenCenter(tag, (centerType or "xy"))
    end
end

---All-in-one `makeGraphic()`, made as a lua graphic counterpart to the function 'quickSprite'.
---@param tag string Sprite tag
---@param pos table<number>|number Positions in a table. Example: {100, 300}. If both values are the same just put in the 
---@param dimensions table<number>|number 
---@param color? string FlxColor (color of the graphic)
---@param instantAdd? boolean Do you want to add it without needing to use `addLuaSprite` after?
---@param inFrontOfChars? boolean Is the graphic infront of the characters
---@param scrollFactor? table<number>|number Scroll factor of the graphic. Example: {3, 1}
---@param scale? table<number>|number Scale of the graphic. Example: {2, 2.1}
---@param camera? string "game", "hud" or "other"
---@param centerType? string xy, x, y. Set it to nil if you don't want it to center.
---@param shader? string Name of the shader the `shaders` folder
---@author GhostglowDev, inspired by Apollo and T-Bar
util.quickGraphic = function(tag, pos, dimensions, color, instantAdd, inFrontOfChars, scrollFactor, scale, camera, centerType, shader)
    pos = (util.isTable(pos) and {pos, pos} or pos)
    dimensions = (util.isTable(dimensions) and {dimensions, dimensions} or dimensions)
    scale = (util.isTable(scale) and {(scale or 1), (scale or 1)} or (scale or {1, 1}))
    scrollFactor = (util.isTable(scrollFactor) and {(scrollFactor or (getCameraFromString(camera) == "camGame" and 1 or 0)), (scrollFactor or (getCameraFromString(camera) == "camGame" and 1 or 0))} or (scrollFactor or (getCameraFromString(camera) == "camGame" and {1, 1} or {0, 0})))
    makeLuaSprite(tag, nil, pos[1], pos[2])
    makeGraphic(tag, dimensions[1], dimensions[2], (color or "FFFFFF"))
	scaleObject(tag, scale[1], scale[2])
	setScrollFactor(tag, (scrollFactor[1] or 1), (scrollFactor[2] or 1))
    setObjectCamera(tag, camera)
	setObjectShader(tag, (shader or nil))

	if instantAdd then
		addLuaSprite(tag, (inFrontOfChars or false))
	end
    if centerType ~= nil then
		screenCenter(tag, (centerType or "xy"))
    end
end

return util
>>>>>>> Stashed changes
