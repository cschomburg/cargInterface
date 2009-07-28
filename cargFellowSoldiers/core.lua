--[[
	cargFellowSoldiers
]]
local texturepath
local dummy = function() end
if(IsAddOnLoaded("cargFellowSoldiers")) then -- Loaded in cargInterface or externally?
	texturepath = [[Interface\AddOns\cargFellowSoldiers\]]
else
	texturepath = [[Interface\AddOns\cargInterface\cargFellowSoldiers\]]
end
local blizzIcon = [[Interface\Worldmap\WorldMapPartyIcon]]

local friends = {}
for i=1, GetNumFriends() do
	friends[GetFriendInfo(i)] = true
end
for i=1, GetNumGuildMembers(true) do
	friends[GetGuildRosterInfo(i)] = true
end
local _G = getfenv(0)
local setTex = WorldMapRaid1Icon.SetTexture

local i=1
while(_G['WorldMapRaid'..i]) do
	local icon = _G['WorldMapRaid'..i..'Icon']
	icon.SetVertexColor = dummy
	icon.SetTexture = dummy
	i = i+1
end

local addon = CreateFrame"Frame"
addon:SetScript("OnEvent", function()
	local colorServer = select(2, IsInInstance()) == "pvp"
	local i=1
	while(_G['WorldMapRaid'..i]) do
		local button = _G['WorldMapRaid'..i]
		local unit = button.unit
		if(unit) then
			local name, server = UnitName(unit)
			local icon = _G['WorldMapRaid'..i..'Icon']
			server = server == "" and nil or server

			if(friends[name] and not server) then
				setTex(icon, texturepath.."GreenDot")
				button:SetFrameLevel(5)
			elseif(name and not server and colorServer) then
				setTex(icon, texturepath.."BlueDot")
				button:SetFrameLevel(4)
			else
				setTex(icon, blizzIcon)
				button:SetFrameLevel(3)
			end
			i = i+1
		end
	end
end)
addon:RegisterEvent"RAID_ROSTER_UPDATE"
addon:RegisterEvent"PLAYER_ENTERING_WORLD"