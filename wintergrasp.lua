local ANNOUNCE_TIME = 15*60

local getWinterTime = GetWintergraspWaitTime
local announced, lastTime
local frame = CreateFrame"Frame"
frame:SetScript("OnUpdate", function(self, elapsed)
	local wgTime = getWinterTime()
	if(wgTime) then
		lastTime = wgTime
	elseif(lastTime) then
		lastTime = lastTime - elapsed
		wgTime = lastTime
	end

	if(not announced and wgTime and wgTime < ANNOUNCE_TIME and wgTime ~= 0) then
		announced = true
		RaidNotice_AddMessage(RaidBossEmoteFrame, "Wintergrasp begins soon!", ChatTypeInfo.EMOTE)
	elseif(announced and wgTime > ANNOUNCE_TIME) then
		announced = nil
	end
end)

function GetWintergraspWaitTime()
	return lastTime and lastTime > 0 and lastTime or getWinterTime()
end

WintergraspTimer.Hide = function() end