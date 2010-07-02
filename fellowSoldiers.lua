--[[
	FellowSoldiers
]]
local name, ns = ...

local textures = ns.texturePath
local blizzIcon = [[Interface\WorldMap\WorldMapPartyIcon]]

local dummy = function() end

local fLevel = WorldMapRaid1:GetFrameLevel()

local friends = {}

local _G = getfenv(0)
local setTex = WorldMapRaid1Icon.SetTexture

local addon = CreateFrame("Frame", nil, WorldMapButton)
addon:SetScript("OnUpdate", function()
	local i=1
	while(_G['WorldMapRaid'..i] and _G['WorldMapRaid'..i]:IsShown()) do
		local button = _G['WorldMapRaid'..i]
		local unit = button.unit
		if(unit) then
			local name = UnitName(unit)
			local icon = _G['WorldMapRaid'..i..'Icon']

			if(friends[name]) then
				setTex(icon, textures.."GreenDot")
				button:SetFrameLevel(fLevel+1)
			else
				setTex(icon, blizzIcon)
				button:SetFrameLevel(fLevel)
			end
			i = i+1
		end
	end
end)

ns.OnLoad(function()
	for i=1, GetNumFriends() do
		friends[GetFriendInfo(i)] = true
	end
	for i=1, GetNumGuildMembers(true) do
		friends[GetGuildRosterInfo(i)] = true
	end
end)
