local debug = {};
---@module GhostUtil
---@class Debug

debug.error = function(message, ifDebug)
    if ifDebug == nil then ifDebug = true end
    if ifDebug then
        if luaDebugMode then
            runHaxeCode("game.addTextToDebug('ERROR: "..scriptName..":GhostUtil: "..message.."', 0xFFFF0000);")
        end
    else
        runHaxeCode("game.addTextToDebug('ERROR: "..scriptName..":GhostUtil: "..message.."', 0xFFFF0000);")
    end
end

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

return debug;