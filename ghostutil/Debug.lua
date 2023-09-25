local debug = {};
---@class Debug

debug.ver = "1.0.0"
debug.stage = "experimental-release"

---Prints out a GhostUtil error message
---@param message string The error message
---@param ifDebug boolean Is it visible only when `luaDebugMode` is turned on?
debug.error = function(message, ifDebug)
    ifDebug = (ifDebug or true)
    if ifDebug then
        if luaDebugMode then
            runHaxeCode("game.addTextToDebug('ERROR: "..scriptName..":GhostUtil: "..message.."', 0xFFFF0000);")
        end
    else
        runHaxeCode("game.addTextToDebug('ERROR: "..scriptName..":GhostUtil: "..message.."', 0xFFFF0000);")
    end
end

---Prints out a GhostUtil warning message
---@param message string The warning message
---@param ifDebug boolean Is it visible only when `luaDebugMode` is turned on?
debug.warning = function(message, ifDebug)
    -- basically the same as error message but with orange text instead of red
    if ifDebug == nil then ifDebug = true end
    if ifDebug then
        if luaDebugMode then
            runHaxeCode("game.addTextToDebug('WARNING: "..scriptName..":GhostUtil: "..message.."', 0xFFFFC803);")
        end
    else
        runHaxeCode("game.addTextToDebug('WARNING: "..scriptName..":GhostUtil: "..message.."', 0xFFFFC803);")
    end
end

---Prints out a GhostUtil log
---@param message string Message to log
---@param ifDebug boolean Is it visible only when `luaDebugMode` is turned on?
debug.log = function(message, ifDebug)
    -- basically the same as error message but with orange text instead of red
    if ifDebug == nil then ifDebug = true end
    if ifDebug then
        if luaDebugMode then
            runHaxeCode("game.addTextToDebug('LOG: "..scriptName..":GhostUtil: "..message.."', 0xFF00FF00);")
        end
    else
        runHaxeCode("game.addTextToDebug('LOG: "..scriptName..":GhostUtil: "..message.."', 0xFF00FF00);")
    end
end

return debug;