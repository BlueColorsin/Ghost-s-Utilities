local modchart = {};
---@class Modchart

local u = require "ghostutil.Util"
local d = require "ghostutil.Debug"

---Transitions to their respective downscroll positions
---@param note integer 0-3 is the opponent's and 4-7 is the player's 
---@param toggle boolean Downscroll (Reminder: Toggling this whilst on downscroll will make it upscroll.)
---@param duration number Time it takes to complete
---@param ease string FlxEase
---@param withUi boolean Do you want the UI to be in their own "scroll" position?
---@param modchartTag string The tag for the `onTweenCompleted()` function
modchart.downscroll = function(note, toggle, duration, ease, withUi, modchartTag)
    if not u.isBool(toggle) then d.error("modchart.downscroll:2: Expected a boolean") end 

    local notes = {y = {defaultOpponentStrumY0,defaultOpponentStrumY1,defaultOpponentStrumY2,defaultOpponentStrumY3,defaultPlayerStrumY0,defaultPlayerStrumY1,defaultPlayerStrumY2,defaultPlayerStrumY3}}
    local strum = ((note <= 3) and "opponentStrums" or "playerStrums")
    noteTweenY((modchartTag or ((toggle and "ModchartDownscroll" or "ModchartUpscroll")..note)), note, notes.y[(note + 1)] + (toggle and (withUi and 510 or 470) or 0), (duration or 1), ease)
    setPropertyFromGroup(strum, ((strum == "opponentStrums") and note or (note - 4)), "downScroll", (toggle and (not downscroll) or downscroll))

    if withUi then
        doTweenY((modchartTag or "ModchartDownscrollUi_TimeTxt"), "timeTxt", (toggle and (downscroll and 19 or 676) or (downscroll and 676 or 19)), (duration or 1), ease)
        doTweenY((modchartTag or "ModchartDownscrollUi_TimeBar"), "timeBar", (toggle and (downscroll and 31.25 or 688.25) or (downscroll and 688.25 or 31.25)), (duration or 1), ease)
        doTweenY((modchartTag or "ModchartDownscrollUi_TimeBG"), "timeBarBG", (toggle and (downscroll and 27.25 or 684.25) or (downscroll and 684.25 or 27.25)), (duration or 1), ease)

        doTweenY((modchartTag or "ModchartDownscrollUi_HealthBar"), "healthBar", (toggle and (downscroll and 644.8 or 83.2) or (downscroll and 83.2 or 644.8)), (duration or 1), ease)
        doTweenY((modchartTag or "ModchartDownscrollUi_HealthBG"), "healthBarBG", (toggle and (downscroll and 640.8 or 79.2) or (downscroll and 79.2 or 640.8)), (duration or 1), ease)
        doTweenY((modchartTag or "ModchartDownscrollUi_ScoreText"), "scoreTxt", (toggle and (downscroll and 676.8 or 115.2) or (downscroll and 115.2 or 676.8)), (duration or 1), ease)
        doTweenY((modchartTag or "ModchartDownscrollUi_IconP1"), "iconP1", (toggle and (downscroll and 569.8 or 8.2) or (downscroll and 8.2 or 569.8)), (duration or 1), ease)
        doTweenY((modchartTag or "ModchartDownscrollUi_IconP2"), "iconP2", (toggle and (downscroll and 569.8 or 8.2) or (downscroll and 8.2 or 569.8)), (duration or 1), ease)
    end
    runHaxeCode("game.callOnLuas('onTweenCompleted', ['"..(modchartTag or ("ModchartDownscroll"..note)).."']);")
end

---Transitions to middlescroll
---@param toggle boolean Middlescroll or nah?
---@param duration number The time it takes to complete
---@param opponentVisible boolean Do you want the opponent's strum to be visible?
---@param ease string FlxEase
---@param modchartTag string Tag for the function `onTweenCompleted()` - The tag will be [yourTag]<index> (e.g. MyTag1) for the the second note
modchart.middlescroll = function(toggle, opponentVisible, duration, ease, modchartTag)
    if not u.isBool(toggle) then d.error("modchart.middlescroll:1: Expected a boolean") end
    local midPos = {dad = {82, 194, 971, 1083}, bf = {412, 524, 636, 748}}
    local notes = {x = {defaultOpponentStrumX0,defaultOpponentStrumX1,defaultOpponentStrumX2,defaultOpponentStrumX3,defaultPlayerStrumX0,defaultPlayerStrumX1,defaultPlayerStrumX2,defaultPlayerStrumX3}}
    local doTween = (opponentVisible and noteTweenX or noteTweenAlpha)
    for i = 0,3 do
        doTween((modchartTag or (toggle and "ModchartMiddlescrollDad" or "ModchartUnMiddlescrollDad"))..i, i, (toggle and (opponentVisible and midPos.dad[(i+1)] or 0) or (opponentVisible and notes.x[(i+1)] or 1)), (duration or 1), ease)
        noteTweenX((modchartTag or (toggle and "ModchartMiddlescrollBf" or "ModchartUnMiddlescrollBf"))..i, (i+4), (toggle and midPos.bf[(i+1)] or notes.x[(i+5)]), (duration or 1), ease)
    end
end

---Swaps the opponent's strums with the player's
---@param swap boolean Self-explanatory
---@param duration number The time it takes for it to complete
---@param ease string FlxEase
---@param modchartTag string Tag for the function `onTweenCompleted()`
modchart.swapStrums = function(swap, duration, ease, modchartTag)
    if not u.isBool(swap) then d.error("modchart.swapStrums:1: Expected a boolean") end
    local notes = {x = {defaultOpponentStrumX0,defaultOpponentStrumX1,defaultOpponentStrumX2,defaultOpponentStrumX3,defaultPlayerStrumX0,defaultPlayerStrumX1,defaultPlayerStrumX2,defaultPlayerStrumX3}}
    for i = 0,7 do
        noteTweenX((modchartTag or (swap and ("ModchartSwapStrums") or ("ModchartUnSwapStrums")))..i, i, ((i <= 3) and (swap and notes.x[i+5] or notes.x[i+1]) or (swap and notes.x[(i+1)-4] or notes.x[(i+5)-4])), (duration or 1), ease)
    end
end

return modchart;