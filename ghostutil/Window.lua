local window = {};
---@class Window

local d = require "ghostutil.Debug"

---Simply loads the library "Application" from `lime.app`
window.init = function() 
    addHaxeLibrary("Application", "lime.app");
end

window.defaultHeight = 720;
window.defaultWidth = 1280;

---Sets the window position to the target value
---@param x number
---@param y number
window.setPosition = function(x, y)
    window.setProperty("x", x); window.setProperty("y", y);
end

---Closes the window
window.close = function()
    os.exit()
end

---Tweens the window X position to the target value
---@param value number Target X position to tween to
---@param duration number The time it takes to complete
---@param ease string FlxEase
---@param onCompleteTag string Tag for the `onTweenComplete()` function
window.windowTweenX = function(value, duration, ease, onCompleteTag)
    if value == nil then d.error("window.windowTweenX:1: Value is null/nil") else
        runHaxeCode([[
            var winX:FlxTween;
            if (winX != null) winX.cancel();
            winX = FlxTween.tween(Application.current.window, {x: ]]..tostring(value)..[[}, ]]..(tostring(duration) or "1")..[[, {ease: FlxEase.]]..(ease or "linear")..[[, onComplete:
                function(){ game.callOnLuas("onTweenCompleted", ["]]..(onCompleteTag or "WindowTweenX")..[["]); }
            });
        ]])
    end
end

---Tweens the window Y position to the target value
---@param value number Target Y position to tween to
---@param duration number The time it takes to complete
---@param ease string FlxEase
---@param onCompleteTag string Tag for the `onTweenComplete()` function
window.windowTweenY = function(value, duration, ease, onCompleteTag)
    if value == nil then
        d.error("window.windowTweenY:1: Value is null/nil")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    else
        runHaxeCode([[
            var winY:FlxTween;
            if (winY != null) winY.cancel();
            winY = FlxTween.tween(Application.current.window, {y: ]]..tostring(value)..[[}, ]]..(tostring(duration) or "1")..[[, {ease: FlxEase.]]..(ease or "linear")..[[, onComplete:
                function(){ game.callOnLuas("onTweenCompleted", ["]]..(onCompleteTag or "WindowTweenY")..[["]); }
            });
        ]])
    end
end

---Disclaimer: Only works when the window is in fullscreen / default size
---@param xy string x, y or xy
window.screenCenter = function(xy)
    if (xy or "xy") == "xy" then
        window.setProperty("x", 320)
        window.setProperty("y", 180)
    elseif (xy or "xy") == "x" then
        window.setProperty("x", 320)
    elseif (xy or "xy") == "y" then
        window.setProperty("y", 180)
    else
        d.error("window.screenCenter:1: Unknown value or null")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    end
end

---Disclaimer: Only works when the window is in fullscreen / default size
---@param xy string x, y or xy
---@param duration number The time it takes to complete
---@param ease string FlxEase
---@param onCompleteTag string Tag for the `onTweenComplete()` function
window.tweenToCenter = function(xy, duration, ease, onCompleteTag)
    if (xy or "xy") == "xy" then
        window.windowTweenX(320, (duration or 1), (ease or "linear"), (onCompleteTag or "TweenToCenterX"))
        window.windowTweenY(180, (duration or 1), (ease or "linear"), (onCompleteTag or "TweenToCenterY"))
    elseif (xy or "xy") == "x" then
        window.windowTweenX(320, (duration or 1), (ease or "linear"), (onCompleteTag or "TweenToCenterX"))
    elseif (xy or "xy") == "y" then
        window.windowTweenY(180, (duration or 1), (ease or "linear"), (onCompleteTag or "TweenToCenterY"))
    end
end

---Resizes the window
---@param height number Target height
---@param width number Target width
window.resizeTo = function(height, width)
    window.setProperty("height", (height or 720))
    window.setProperty("width", (width or 1280))
end

---Resizes the window using tweens
---@param height number Target height
---@param width number Target width
---@param duration number The time it takes to complete
---@param ease string FlxEase
---@param onCompleteTag string Tag for th `onTweenCompleted()` function
window.tweenResizeTo = function(height, width, duration, ease, onCompleteTag)
    runHaxeCode([[
        var winResize:FlxTween;
        if (winResize != null) winResize.cencel();
        winResize = FlxTween.tween(Application.current.window, {height: ]]..tostring((height or 720))..[[, width: ]]..tostring((width or 1280))..[[}, ]]..(tostring(duration) or "1")..[[, {ease: FlxEase.]]..(ease or "linear")..[[, onComplete:
            function(){ game.callOnLuas("onTweenCompleted", ["]]..(onCompleteTag or "TweenResizeTo")..[["]); }
        });
    ]])
end

---Creates a alert window
---@param title string Alert window title
---@param msg string Alert window message
window.alert = function(title, msg)
    runHaxeCode("Application.current.window.alert('"..tostring((msg or (scriptName..":GhostUtil: window.alert:2: Expected a value"))).."', '"..tostring((title or "GhostUtil Error")).."');")
end

---Changes the application title
---@param title string Application title
window.changeTitle = function(title)
    window.setProperty("title", (title or "Friday Night Funkin': Psych Engine"))
end

---Sets a certain property of the current window
---@param var string Target property to set
---@param val any New value
window.setProperty = function(var, val)
    if val == nil or val == "" then
        d.error("window.setProperty:2: Unknown value or null")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    else
        if var == "borderless" then
            setPropertyFromClass("lime.app.Application", "current.window.borderless", val)
        elseif var == "height" then
            setPropertyFromClass("lime.app.Application", "current.window.height", val)
        elseif var == "width" then
            setPropertyFromClass("lime.app.Application", "current.window.width", val)
        elseif var == "x" then
            setPropertyFromClass("lime.app.Application", "current.window.x", val)
        elseif var == "y" then
            setPropertyFromClass("lime.app.Application", "current.window.y", val)
        elseif var == "fullscreen" then
            setPropertyFromClass("lime.app.Application", "current.window.fullscreen", val)
        elseif var == "title" then
            setPropertyFromClass("lime.app.Application", "current.window.title", val)
        elseif var == "resizable" or var == "canResize" then
            setPropertyFromClass("lime.app.Application", "current.window.resizable", val)
        --[[elseif var == "iconImage" then
            runHaxeCode("Application.current.window.setIcon("..tostring(val)..");")]]
        else
            if var == nil then
                d.error("window.setProperty:1: Attempt to set a window's null property")
                -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
            else
                d.error("window.setProperty:1: Attempt to set an unknown window property")
                -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
            end
        end
    end
end

---Gets the specified property of the current window
---@param var string Target property to return
---@return any property Object Property
window.getProperty = function(var)
    if var == nil or var == "" then
        d.error("window.getProperty:1: Attempted to get a null window's property")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    else
        if var == "borderless" then
            return getPropertyFromClass("lime.app.Application", "current.window.borderless")
        elseif var == "height" then
            return getPropertyFromClass("lime.app.Application", "current.window.height")
        elseif var == "width" then
            return getPropertyFromClass("lime.app.Application", "current.window.width")
        elseif var == "x" then
            return getPropertyFromClass("lime.app.Application", "current.window.x")
        elseif var == "y" then
            return getPropertyFromClass("lime.app.Application", "current.window.y")
        elseif var == "fullscreen" then
            return getPropertyFromClass("lime.app.Application", "current.window.fullscreen")
        elseif var == "title" then
            return getPropertyFromClass("lime.app.Application", "current.window.title")
        elseif var == "resizable" then
            return getPropertyFromClass("lime.app.Application", "current.window.resizable")
        end
    end
end

return window;