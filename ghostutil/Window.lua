local window = {};
---@class Window

local d = require "ghostutil.Debug"
<<<<<<< Updated upstream

---Simply loads the library "Application" from `lime.app`
window.init = function() 
    addHaxeLibrary("Application", "lime.app");
end

window.defaultHeight = 720;
window.defaultWidth = 1280;
=======
local u = require "ghostutil.Util"

local activeTweens = {}
local extraWindows = {}

window.defaultDimensions = {width = 1280, height = 720}
window.desktopDimensions = {width = nil, height = nil}

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

function removeActiveWindowTween(t)
    debugPrint("window.removeActiveWindowTween")
    for i = 1, #activeTweens do
        if activeTweens[i][1] == t then 
            table.remove(activeTweens, i)
            return  
        end
    end
end

---@private
function window._createPost()
    addHaxeLibrary("Application", "lime.app")
    addHaxeLibrary("Image", "lime.graphics")
    window.desktopDimensions = {
        width = getPropertyFromClass("openfl.Lib", "application.window.display.bounds.width"),
        height = getPropertyFromClass("openfl.Lib", "application.window.display.bounds.height")
    }
end

---@private
function window._destroy()
    if #extraWindows < 1 then return end
    for i = 1, #extraWindows do
        if extraWindows[i][2] then
            runHaxeCode(
                extraWindows[i][1].. [[.close();
            ]])
        end
    end
end
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
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
=======
---@param duration? number The time it takes to complete
---@param ease? string FlxEase
window.windowTweenX = function(tag, value, duration, ease)
    if tag == nil or value == nil then d.error("window.windowTweenX:".. (tag == nil and "1" or ((tag == nil and value == nil) and "1-2" or "2")) ..": Value is null/nil") return else
        value, duration, ease = tostring(value), tostring(duration) or "1", ease or "linear"
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.set(']]..tag..[[', 
                FlxTween.tween(Application.current.window, {x: ]]..value..[[}, ]]..duration..[[, {
                    ease: ]]..getFlxEaseByString(ease)..[[, 
                    onComplete: () -> { 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("onTweenCompleted", ["]]..tag..[["]); 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("removeActiveWindowTween", ["]]..tag..[["]);

                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.remove(']]..tag..[[');
                    }
                })
            );
>>>>>>> Stashed changes
        ]])
    end
end

---Tweens the window Y position to the target value
---@param value number Target Y position to tween to
<<<<<<< Updated upstream
---@param duration number The time it takes to complete
---@param ease string FlxEase
---@param onCompleteTag string Tag for the `onTweenComplete()` function
window.windowTweenY = function(value, duration, ease, onCompleteTag)
    if value == nil then
        d.error("window.windowTweenY:1: Value is null/nil")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
=======
---@param duration? number The time it takes to complete
---@param ease? string FlxEase
window.windowTweenY = function(tag, value, duration, ease)
    if tag == nil or value == nil then d.error("window.windowTweenY:".. (tag == nil and "1" or ((tag == nil and value == nil) and "1-2" or "2")) ..": Value is null/nil") return else
        value, duration, ease = tostring(value), tostring(duration) or "1", ease or "linear"
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.set(']]..tag..[[', 
                FlxTween.tween(Application.current.window, {y: ]]..value..[[}, ]]..duration..[[, {
                    ease: ]]..getFlxEaseByString(ease)..[[, 
                    onComplete: () -> { 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("onTweenCompleted", [']]..tag..[[']); 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("removeActiveWindowTween", [']]..tag..[[']);

                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.remove(']]..tag..[[');
                    }
                })
            );
        ]])
    end

    table.insert(activeTweens, {tag, false})
end

---Tweens the window position to the target values
---@param tag string For pausing/resuming, cancelling and for `onTweenCompleted`.
---@param values table<number>|number The values. {x, y}. If both are same just type in the value in the `number` type
---@param duration? number The time it takes to complete
---@param ease? string FlxEase
window.windowTweenPosition = function(tag, values, duration, ease) 
    if tag == nil or values[1] == nil or values[2] == nil then d.error("window.windowTweenPosition:".. (tag == nil and "1" or ((tag == nil and (values[1] == nil or values[2] == nil)) and "1-2" or "2")) ..": Value is null/nil") return else
        duration, ease = tostring(duration) or "1", ease or "linear"
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.set(']]..tag..[[', 
                FlxTween.tween(Application.current.window, {x: ]]..tostring(values[1])..[[, y: ]]..tostring(values[2])..[[}, ]]..duration..[[, {
                    ease: ]]..getFlxEaseByString(ease)..[[, 
                    onComplete: () -> { 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("onTweenCompleted", ["]]..tag..[["]); 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("removeActiveWindowTween", ["]]..tag..[["]);

                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.remove(']]..tag..[[');
                    }
                })
            );
        ]])
    end
end

---Pauses an active window tween
---@param t string Window tween tag
window.pauseTween = function(t)
    local exists = false
    if #activeTweens < 1 then
        d.error("window.pauseTween: There's no active window tweens.")
        return
    end

    for i = 1, #activeTweens do
        if activeTweens[i][1] == t then
            exists = true
            if activeTweens[i][2] == true then
                d.warning("window.pauseTween: The tween '"..t.."' is already paused.")
                return
            end
            activeTweens[i][2] = true
            break
        end
    end

    if exists then
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.get(']].. t ..[[').active = false;
        ]])
    end
end

---Resumes a paused window tween
---@param t string Window tween tag
window.resumeTween = function(t)
    local exists = false
    if #activeTweens < 1 then
        d.error("window.resumeTween: There's no active window tweens.")
        return
    end

    for i = 1, #activeTweens do
        if activeTweens[i][1] == t then
            exists = true
            if activeTweens[i][2] == false then
                d.warning("window.resumeTween: The tween '"..t.."' is already playing.")
                return
            end
            activeTweens[i][2] = false
            break
        end
    end

    if exists then
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.get(']].. t ..[[').active = true;
        ]])
        return
    end
    d.error("window.resumeTween:1: The tween with tag '"..t.."' doesn't exist.")
end

---Cancels a window tween
---@param t string Window tween tag
window.cancelTween = function(t)
    local exists = false
    if #activeTweens < 1 then
        d.error("window.cancelTween: There's no active window tweens.")
        return
    end

    for i = 1, #activeTweens do
        if activeTweens[i][1] == t then
            exists = true
            table.remove(activeTweens, i)
            break
        end
    end

    if exists then
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.get(']].. t ..[[').cancel();
            ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.get(']].. t ..[[').destroy();
            ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.remove(']].. t ..[[');
        ]])
        return
    end
    d.error("window.cancelTween:1: The tween with tag '".. t .."' doesn't exist.")
end

---Centers the window 
---@param xy? string x, y or xy
window.screenCenter = function(xy)
    xy = xy or "xy"
    if xy == "xy" then
        window.setPosition({
            (window.desktopDimensions.width - window.getProperty("width")) / 2,
            (window.desktopDimensions.height - window.getProperty("height")) / 2
        })
    elseif xy == "x" then
        window.setProperty("x", (window.desktopDimensions.width - window.getProperty("width")) / 2)
    elseif xy == "y" then
        window.setProperty("y", (window.desktopDimensions.height - window.getProperty("height")) / 2)
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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
=======
---@param tag string For pausing/resuming, cancelling and for `onTweenCompleted`.
---@param values table<number>|number The values. {width, height}. If both values are the same then type in the value in `number` type
---@param duration? number The time it takes to complete
---@param ease? string FlxEase
window.tweenResizeTo = function(tag, values, duration, ease)
    if tag == nil or value == nil then d.error("window.windowTweenResize:".. (tag == nil and "1" or ((tag == nil and value == nil) and "1-2" or "2")) ..": Value is null/nil") return else
        value, duration, ease = tostring(value), tostring(duration) or "1", ease or "linear"
        runHaxeCode(
            (version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.set(']]..tag..[[', 
                FlxTween.tween(Application.current.window, {width: ]]..(u.isTable(values) and values[1] or values)..[[, height: ]]..(u.isTable(values) and values[1] or values)..[[}, ]]..duration..[[, {
                    ease: ]]..getFlxEaseByString(ease)..[[, 
                    onComplete: () -> { 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("onTweenCompleted", ["]]..tag..[["]); 
                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.callOnLuas("removeActiveWindowTween", ["]]..tag..[["]);

                        ]]..(version >= "0.7.0" and "game" or "PlayState.instance")..[[.modchartTweens.remove(']]..tag..[[');
                    }
                })
            );
        ]])
    end

    table.insert(activeTweens, {tag, false})
end

---Image must be located in mods/images or assets/images
---@param img string Image
window.setIcon = function(img)
    runHaxeCode([[
        Application.current.window.setIcon(Image.fromFile(Paths.image(']]..img..[[')));
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
=======
---Focuses the current window
window.focus = function()
    runHaxeCode("Application.current.window.focus();")
end

---Creates a window
---@param winName string The "tag" for the window name
---@param attributes? table<any> The new window attributes {x, y, width, height, title, resizable, minimized, maximized, fullscreen, borderless, alwaysOnTop} All arguments are optional.
---@param closeOnDestroy? boolean Closes the extra windows on destroy
window.createWindow = function(winName, attributes, closeOnDestroy)
    if winName == nil then
        d.error("window.createWindow:1: Expected string, got null.")
        return
    end

    resizable = resizable == nil and true or resizable
    runHaxeCode([[
        ]]..winName..[[ = Application.current.createWindow({
            x: ]]..(attributes[1][1] or 0)..[[,
            y: ]]..(attributes[1][2] or 0)..[[,
            width: ]]..(attributes[2][1] or 1280)..[[,
            height: ]]..(attributes[2][2] or 720)..[[,
            title: ]]..(attributes[3] or "New Window")..[[,
            resizable: ]]..(attributes[4])..[[,
            minimized: ]]..(attributes[5] or false)..[[,
            maximized: ]]..(attributes[6] or false)..[[,
            fullscreen: ]]..(attributes[7] or false)..[[,
            borderless: ]]..(attributes[8] or false)..[[,
            alwaysOnTop: ]]..(attributes[9] or false)..[[,
        });
    ]])

    closeOnDestroy = closeOnDestroy == nil and true or closeOnDestroy
    table.insert(extraWindows, {winName, (closeOnDestroy)})
end

>>>>>>> Stashed changes
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