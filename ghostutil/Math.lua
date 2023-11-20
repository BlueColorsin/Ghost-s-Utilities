local mt = setmetatable({}, {
    __index = math,
})

---@class Math

local d = require "ghostutil.Debug"

---Used to account for floating-point inaccuracies.
mt.epsilon = 0.0000001;
---Maximum value of an integer
mt.max_int = 0x7FFFFFFF;
---Minimum value of an integer
mt.min_int = -mt.max_int

---Maximum value of a floating number
mt.max_float = 1.79e+308;
---Minimum value of a floating number
mt.min_float = 0.0000000001;

---Imaginary number, i
mt.imaginary = mt.sqrt(-1)

---Infinity
mt.infinity = mt.huge
---Negative Infnity
mt.negative_infinity = -mt.infinity

---Linear Interpolation
---@param a number Point A
---@param b number Point B
---@param r number Ratio
---@return number
mt.lerp = function(a, b, r)
    return a + r * (b - a)
end

--[[Series / Summation
---@param x number To sum
@param n number Upper limit of summation
@param i number Index of summation
@return number
mt.sum = function(x, n, i)
    return (x) * ((n + 1) - i)
end]]

---Positive to Negative and Negative to Positive.
---@param n number Value
---@return number
mt.invert = function(n)
    return (n) * -1
end

---Checks if `x` is a positive number (0 is not positive nor negative so it will return false.)
---@param x number Value
---@return boolean
mt.isPositive = function(x)
    return (x > 0)
end

---Checks if `x` is a negative number (0 is not positive nor negative so it will return false.)
---@param x number Value
---@return boolean
mt.isNegative = function(x)
    return (x < 0)
end

---Factorial of a number (Integers only. Decimals doesn't work)
---@param n number To be factored
---@return integer
mt.fact = function(n)
    n = mt.floor(n) -- Decimal factorial doesnt work.
    if n <= 0 then return 1 else return n * mt.fact(n-1) end
end

---Bound a number by a minimum and maximum. Ensures that this number is no smaller than the minimum, and no larger than the maximum
---@param v number Value
---@param mx number Maximum
---@param mn number Minimum
---@return number
mt.boundTo = function(v, mx, mn)
    return mt.max(mn, mt.min(mx, v));
end

mt.floorDecimal = mt.round
mt.roundDecimal = mt.round

---Limits the amount of decimals
---@param x number Number
---@param dc number Target amount of decimals (Optional, default = 2)
---@return number
mt.round = function(x, dc)
    if x ~= nil then 
        addHaxeLibrary("Highscore")
        return runHaxeCode("return Highscore.floorDecimal("..x..", "..dc..");")
    else
        d.error("math.floorDecimal:1: No value is stated")
        return nil
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    end
end

---Returns the midpoint of a certain distance
---@param x number Point 1
---@param y number Point 2
---@return number
mt.getMidpoint = function(x, y)
    return (x + y) / 2
end

return mt