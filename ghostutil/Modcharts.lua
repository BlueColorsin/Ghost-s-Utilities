local modchart = {};
---@module GhostUtil
---@class Modchart

local u = require "ghostutil.Util"
local m = require "ghostutil.Math"
local c = require "ghostutil.Color"
local d = require "ghostutil.Debug"

modchart.downscroll = function(note, toggle, duration, ease, withUi, modchartTag)
    if withUi then tweenTo = 510 else tweenTo = 470 end
    if tostring(toggle):lower() == "true" then
        if downscroll then
            if note >= 0 and note <= 3 then
                noteTweenY((modchartTag or ("ModchartDownscroll"..note)), note, defaultOpponentStrumY0 - tweenTo, (duration or 1), ease)
                setPropertyFromGroup("opponentStrums", note, "downScroll", false)
            else
                noteTweenY((modchartTag or ("ModchartDownscroll"..note)), note, defaultPlayerStrumY0 - tweenTo, (duration or 1), ease)
                setPropertyFromGroup("playerStrums", (note - 4), "downScroll", false)
            end
        else
            if note >= 0 and note <= 3 then
                noteTweenY((modchartTag or ("ModchartDownscroll"..note)), note, defaultPlayerStrumY0 + tweenTo, (duration or 1), ease)
                setPropertyFromGroup("opponentStrums", note, "downScroll", true)
            else
                noteTweenY((modchartTag or ("ModchartDownscroll"..note)), note, defaultPlayerStrumY0 + tweenTo, (duration or 1), ease)
                setPropertyFromGroup("playerStrums", (note - 4), "downScroll", true)
            end
        end
    elseif tostring(toggle):lower() == "false" then
        if downscroll then
            if note >= 0 and note <= 3 then
                noteTweenY((modchartTag or ("ModchartUpscroll"..note)), note, defaultOpponentStrumY0, (duration or 1), ease)
                setPropertyFromGroup("opponentStrums", note, "downScroll", true)
            else
                noteTweenY((modchartTag or ("ModchartUpscroll"..note)), note, defaultPlayerStrumY0, (duration or 1), ease)
                setPropertyFromGroup("playerStrums", (note - 4), "downScroll", true)
            end
        else
            if note >= 0 and note <= 3 then
                noteTweenY((modchartTag or ("ModchartUpscroll"..note)), note, defaultOpponentStrumY0, (duration or 1), ease)
                setPropertyFromGroup("playerStrums", note, "downScroll", false)
            else
                noteTweenY((modchartTag or ("ModchartUpscroll"..note)), note, defaultPlayerStrumY0, (duration or 1), ease)
                setPropertyFromGroup("opponentStrums", (note - 4), "downScroll", false)
            end
        end
    else
        d.error("modchart.downscroll:2: Expected a boolean")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    end

    if withUi then
        if tostring(toggle):lower() == "true" then
            if downscroll then
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeTxt"), "timeTxt", 19, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBar"), "timeBar", 31.25, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBG"), "timeBarBG", 27.25, (duration or 1), ease)

                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBar"), "healthBar", 644.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBG"), "healthBarBG", 640.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_ScoreText"), "scoreTxt", 676.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP1"), "iconP1", 569.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP2"), "iconP2", 569.8, (duration or 1), ease)
            else
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeTxt"), "timeTxt", 676, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBar"), "timeBar", 688.25, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBG"), "timeBarBG", 684.25, (duration or 1), ease)

                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBar"), "healthBar", 83.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBG"), "healthBarBG", 79.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_ScoreText"), "scoreTxt", 115.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP1"), "iconP1", 8.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP2"), "iconP2", 8.2, (duration or 1), ease)
            end
        elseif tostring(toggle):lower() == "false" then
            if downscroll then
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeTxt"), "timeTxt", 676, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBar"), "timeBar", 688.25, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBG"), "timeBarBG", 684.25, (duration or 1), ease)

                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBar"), "healthBar", 83.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBG"), "healthBarBG", 79.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_ScoreText"), "scoreTxt", 115.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP1"), "iconP1", 8.2, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP2"), "iconP2", 8.2, (duration or 1), ease)
            else
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeTxt"), "timeTxt", 19, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBar"), "timeBar", 31.25, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_TimeBG"), "timeBarBG", 27.25, (duration or 1), ease)

                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBar"), "healthBar", 644.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_HealthBG"), "healthBarBG", 640.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_ScoreText"), "scoreTxt", 676.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP1"), "iconP1", 569.8, (duration or 1), ease)
                doTweenY((modchartTag or "ModchartDownscrollUi_IconP2"), "iconP2", 569.8, (duration or 1), ease)
            end
        else end
    end
end

modchart.middlescroll = function(toggle, duration, ease, modchartTag)
    if toggle == true then

    elseif toggle == false then

    else
        d.error("modchart.middlescroll:1: Expected a boolean")
        -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
    end
end

modchart.swapStrums = function(swap, duration, ease, modchartTag, goOffscreen)
    if goOffscreen == nil then goOffscreen = false end
    if not goOffscreen then
        if tostring(swap):lower() == "true" then
            noteTweenX((modchartTag or "ModchartSwapStrums0"), 0, defaultPlayerStrumX0, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartSwapStrums1"), 1, defaultPlayerStrumX1, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartSwapStrums2"), 2, defaultPlayerStrumX2, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartSwapStrums3"), 3, defaultPlayerStrumX3, (duration or 2), (ease or "linear"));

            noteTweenX((modchartTag or "ModchartSwapStrums4"), 4, defaultOpponentStrumX0, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartSwapStrums5"), 5, defaultOpponentStrumX1, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartSwapStrums6"), 6, defaultOpponentStrumX2, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartSwapStrums7"), 7, defaultOpponentStrumX3, (duration or 2), (ease or "linear"));
        elseif tostring(swap):lower() == "false" then
            noteTweenX((modchartTag or "ModchartUnSwapStrums0"), 0, defaultOpponentStrumX0, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartUnSwapStrums1"), 1, defaultOpponentStrumX1, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartUnSwapStrums2"), 2, defaultOpponentStrumX2, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartUnSwapStrums3"), 3, defaultOpponentStrumX3, (duration or 2), (ease or "linear"));

            noteTweenX((modchartTag or "ModchartUnSwapStrums4"), 4, defaultPlayerStrumX0, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartUnSwapStrums5"), 5, defaultPlayerStrumX1, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartUnSwapStrums6"), 6, defaultPlayerStrumX2, (duration or 2), (ease or "linear"));
            noteTweenX((modchartTag or "ModchartUnSwapStrums7"), 7, defaultPlayerStrumX3, (duration or 2), (ease or "linear"));
        else
            d.error("modchart.swapStrums:1: Expected a boolean")
            -- Error format: (script_directory):GhostUtil: (function):(parameter): (error)
        end
    else
        d.error("modchart.swapStrums:5: Still in work in progress.")
    end
end

return modchart;