# Ghost' s Utilities
Friday Night Funkin': Psych Engine Utility by Ghost to make programming easier with more variables and unique functions

## You're struggling to code in Psych Engine LUA?
### Well, use GhostUtil!

GhostUtil provides a lot of unique variables and functions for you to mess around!

## How do I use GhostUtil?
### * GhostUtil is only tested on 0.6.3
It's simple. Put the "ghostutil" folder onto the main folder (where the .exe is located)

Now let's make a new script. Add these:
```lua
local colr = require "ghostutil.Color"
local debg = require "ghostutil.Debug"
local game = require "ghostutil.Game"
local math = require "ghostutil.Math" -- Naming the variable "math" is now possible in GhostUtil >1.0.0
local modc = require "ghostutil.Modcharts"
local util = require "ghostutil.Util"
local wind = require "ghostutil.Window"
```
These functions are responsible for loading up the modules from GhostUtil

## Let's try messing with the script.
From `up-n-down.lua` from `examples/modchart`;
```lua
local modc = require "ghostutil.Modcharts"
local bool = false

function onBeatHit()
    if curBeat % 8 == 0 then
        bool = not bool
        for i = 0,7 do
            modc.downscroll(i, bool, 2, "expoOut", true)
        end
    end
end
```

(`local modc = require "ghostutil.Modcharts"` is not needed if you already have the requires" 

MORE EXAMPLES ON `Ghost-s-Utilities/examples`!!
**CHECK OUT THE [WIKI](https://github.com/GhostglowDev/Ghost-s-Utilities/wiki) FOR MORE FUNCTIONS.**

## Note
When using the `Window` class, add `window.init()` before doing anything with the Window functions/variables
"window" in `window.init()` depends on what you set the variable to. If it's `wind` then `wind.init()`, etc.
