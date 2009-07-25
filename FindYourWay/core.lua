local db = {
	["books"] = "308460265522523547436467567456643524468390468400", -- Higher Learning coords
}

local helper = WorldMapDetailFrame:CreateTexture()
helper:SetAllPoints(WorldMapDetailFrame)
helper:SetTexture(0, 0, 0, 0.8)
helper:Hide()

local numShown = 0
local width, height = WorldMapDetailFrame:GetWidth(), WorldMapDetailFrame:GetHeight()
local used, unused = {}, {}

local function removePOI(poi)
	poi:Hide()
	poi:ClearAllPoints()
	used[poi] = nil
	unused[#unused+1] = poi
	numShown = numShown-1
	if(numShown == 0 and helper) then helper:Hide() end
end

local function OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:AddLine(self.x..", "..self.y)
	GameTooltip:Show()
end
local function OnLeave() GameTooltip:Hide() end
local function OnClick(self, button)
	if(IsAltKeyDown()) then
		for k in pairs(used) do removePOI(k) end
	else
		removePOI(self)
	end
end

local function createPOI()
	local poi = CreateFrame("Button", nil, WorldMapDetailFrame)
	poi:RegisterForClicks("RightButtonUp")
	poi:SetWidth(16)
	poi:SetHeight(16)
	poi:SetScript("OnEnter", OnEnter)
	poi:SetScript("OnLeave", OnLeave)
	poi:SetScript("OnClick", OnClick)
	local tex = poi:CreateTexture(nil, "OVERLAY")
	tex:SetTexture("Interface\\Minimap\\POIIcons")
	tex:SetTexCoord(13/16, 14/16, 2/16, 3/16)
	tex:SetAllPoints(poi)
	return poi
end

local function plot(x, y)
	local poi = tremove(unused) or createPOI()
	used[poi] = true
	numShown = numShown+1
	poi.x, poi.y = x, y
	poi:Show()
	poi:SetPoint("CENTER", WorldMapDetailFrame, "TOPLEFT", x/100*width, -y/100*height)
	if(numShown == 1 and helper) then helper:Show() end
end

function FindYourWay(msg)
	msg = msg:trim():lower()
	if(msg == "clear") then
		for k in pairs(used) do removePOI(k) end
	elseif(msg == "me") then
		local x, y = GetPlayerMapPosition("player")
		if(not x or not y) then return print("|cffee8800FindYourWay:|r Where are you?") end
		print("|cffee8800FindYourWay:|r "..("%.2f, %.2f"):format(x*100, y*100))
	elseif(msg) then
		local x, y = msg:match("([0-9%.]+)[/, ]+([0-9%.]+)")
		x, y = tonumber(x), tonumber(y)
		if(x and y) then return plot(x, y) end

		msg = db[msg] or msg:match(":?(%d+)$")
		if(msg and msg:len() % 6 == 0) then
			for i=1, msg:len(), 6 do
				x = msg:sub(i, i+2)
				y = msg:sub(i+3, i+5)
				x, y = tonumber(x)/10, tonumber(y)/10
				if(x and y) then plot(x, y) end
			end
		else
			print("|cffee8800FindYourWay:|r I can't understand you.")
		end
	end
end

SlashCmdList['FINDYOURWAY'] = FindYourWay
SLASH_FINDYOURWAY1 = "/way"
SLASH_FINDYOURWAY2 = "/fyw"
SLASH_FINDYOURWAY3 = "/findyourway"
SLASH_FINDYOURWAY4 = "/find"