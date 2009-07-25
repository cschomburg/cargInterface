--[[
	cargFellowSoldiers
]]
local texturepath
if(IsAddOnLoaded("cargFellowSoldiers")) then -- Loaded in cargInterface or externally?
	texturepath = [[Interface\AddOns\cargFellowSoldiers\]]
else
	texturepath = [[Interface\AddOns\cargInterface\cargFellowSoldiers\]]
end

local addon = CreateFrame"Frame"
local friends = {}
local _G = getfenv(0)
for i=1, GetNumFriends() do
	friends[GetFriendInfo(i)] = true
end

addon:SetScript("OnEvent", function()
	local blizzIcon = [[Interface\Worldmap\WorldMapPartyIcon]]
	local name, server, icon

	local colorServer = select(2, IsInInstance()) == "pvp"
	for i=1, MAX_RAID_MEMBERS do
		name, server = UnitName("raid"..i)
		icon = _G['WorldMapRaid'..i..'Icon']
		button = _G['WorldMapRaid'..i]
		server = server == "" and nil or server

		if(icon and friends[name] and not server) then
			icon:SetTexture(texturepath.."GreenDot")
			button:SetFrameLevel(5)
		elseif(icon and name and not server and colorServer) then
			icon:SetTexture(texturepath.."BlueDot")
			button:SetFrameLevel(4)
		elseif(icon) then
			icon:SetTexture(blizzIcon)
			button:SetFrameLevel(3)
		end
	end
end)
addon:RegisterEvent"PLAYER_ENTERING_WORLD"
addon:RegisterEvent"RAID_ROSTER_UPDATE"