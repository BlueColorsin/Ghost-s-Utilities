# Ghost's Utilities

Ghost's Utilities or more known as GhostUtil is a module/addon to Psych Engine to make programming more easier and tidier.
GhostUtil provides a lot of unique variables and functions for you to mess around!

## The Basics

### How do I use GhostUtil?
* Add the "ghostutil" folder to the main Psych Engine folder. (where the `.exe` is)
![image](https://github.com/GhostglowDev/Ghost-s-Utilities/assets/108509756/076a2654-46fd-4231-b4ba-2512f4ee880c)


* To use GhostUtil, you must import it's modules; use the `require` function on a variable.
Since we're using base lua functions, this is not needed to be in a function.                       
![image](https://github.com/GhostglowDev/Ghost-s-Utilities/assets/108509756/aa15d81d-d20b-4685-b788-ed479765bfff)

* Let's try messing with the script!
```lua
local math = require "ghostutil.Math"
local game = require "ghostutil.Game"

function onCreate()
    luaDebugMode = true
    game.doTweenScale("tweenScale", "boyfriend", {2, 2.1}, "expoOut")
    game.doTweenPosition({"boyfriendcool", "boyfriendswag"}, "boyfriend", {
        game.getPosition("boyfriend").x - 100,
        math.boundTo(game.getPosition("dad").y + 100, -100, 200)
    }, 2, "expoOut")
end
```
This does a tweens boyfriend's scale to 2x it's default size. It also tweens boyfriend's position!

`math.boundTo` was to limit the coordinates to reach a certain number

### For more advanced informations:
**CHECK OUT THE [WIKI](https://github.com/GhostglowDev/Ghost-s-Utilities/wiki) FOR MORE FUNCTIONS.**

### Older Versions
**Psych Engine**:

* below 0.6.3:
Mostly because most of the lua functions that GhostUtil use doesn't exist.

 * 0.7.1h:
It breaks GhostUtil (mostly because of `runHaxeCode`); so use the latest version or 0.7.3 instead.

**GhostUtil**:

* below 2.0.0a:
When using the `Window` class, add `window.init()` before doing anything with the Window functions/variables
"window" in `window.init()` depends on what you set the variable to. If it's `wind` then `wind.init()`, etc.


* below 1.0.0:
Naming the variable `math` will break the script.
