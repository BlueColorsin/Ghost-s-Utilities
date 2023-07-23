local modchart = require "ghostutil.Modcharts"
local bool = false

function onBeatHit()
    if curBeat % 8 == 0 then
        if bool == false then bool = true else bool = false end
        for i = 0,7 do
            modchart.downscroll(i, bool, 2, "expoOut", true)
        end
    end
end