local debug = require "ghostutil.Debug"
local game = require "ghostutil.Game"
local media = require "ghostutil.Media"
local window = require "ghostutil.Window"

function onCreatePost()
    window._createPost()
    debug._createPost()
    media._createPost()
end

function onDestroy()
    window._destroy()
    game._destroy()
end
