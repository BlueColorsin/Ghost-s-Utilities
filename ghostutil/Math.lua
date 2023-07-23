local mt = {}
---@module GhostUtil
---@class Math

local d = require "ghostutil.Debug"

mt.lerp = function(a, b, r)
    return a + r * (b - a)
end

mt.boundTo = function(v, mx, mn)
    math.max(mn, math.min(mx, v));
end

mt.floorDecimal = function(val, dec)
    if val ~= nil then 
        addHaxeLibrary("Highscore")
        return runHaxeCode("return Highscore.floorDecimal("..val..", "..dec..");")
    else
        d.error("math.floorDecimal:1: No value is stated")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    end
end

mt.getMidpoint = function(x, y)
    return (x + y) / 2
end

return mt