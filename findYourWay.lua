local zones = {
	["Dalaran"] = {
		["higher learning books"] = "308460265522523547436467567456643524468390468400"
	},
	["ThunderBluff"] = {
		["bank"] = "471586",
		["flight master"] = "467497",
		["guild master"] = "372641",
		["inn"] = "465641",
		["mailbox"] = "452594",
		["auction house"] = "397500",
		["weapon master"] = "409521",
		["stable master"] = "448603",
		["battle master"] = "576769",
		["druid class trainer"] = "768293",
		["hunter class trainer"] = "604813",
		["mage class trainer"] = "307303",
		["priest class trainer"] = "307303",
		["shaman class trainer"] = "228200",
		["warrior class trainer"] = "604813",
		["alchemy profession trainer"] = "468338",
		["blacksmithing profession trainer"] = "394560",
		["cooking profession trainer"] = "515523",
		["enchanting profession trainer"] = "448377",
		["first aid profession trainer"] = "302210",
		["fishing profession trainer"] = "561458",
		["herbalism profession trainer"] = "496413",
		["inscription profession trainer"] = "290214",
		["leatherworking profession trainer"] = "430440",
		["mining profession trainer"] = "346573",
		["skinning profession trainer"] = "445429",
		["tailoring profession trainer"] = "430440",
		["zeppelin"] = "185255",
	},
	["Orgrimmar"] = {
		["bank"] = "495686",
		["flight master"] = "464638",
		["guild master"] = "437745",
		["inn"] = "546672",
		["mailbox"] = "504696",
		["auction house"] = "548635",
		["weapon master"] = "815193",
		["stable master"] = "701150",
		["hall of legends"] = "405684",
		["battle master"] = "795303",
		["barber"] = "472544",
		["hunter class trainer"] = "673170",
		["mage class trainer"] = "386879",
		["priest class trainer"] = "358889",
		["shaman class trainer"] = "357372",
		["rogue class trainer"] = "426535",
		["warlock class trainer"] = "484453",
		["warrior class trainer"] = "793309",
		["paladin class trainer"] = "357372",
		["alchemy profession trainer"] = "566340",
		["blacksmithing profession trainer"] = "820234",
		["cooking profession trainer"] = "570526",
		["enchanting profession trainer"] = "537380",
		["engineering profession trainer"] = "758251",
		["first aid profession trainer"] = "342843",
		["fishing profession trainer"] = "695299",
		["herbalism profession trainer"] = "552401",
		["inscription profession trainer"] = "568461",
		["leatherworking profession trainer"] = "628450",
		["mining profession trainer"] = "729260",
		["skinning profession trainer"] = "628450",
		["tailoring profession trainer"] = "627503",
	},
	["Undercity"] = {
		["bank"] = "667441",
		["flight master"] = "627487",
		["guild master"] = "695443",
		["inn"] = "679372",
		["mailbox"] = "681383",
	},
	["SilvermoonCity"] = {
	},
}

local helper = CreateFrame("Frame", nil, WorldMapDetailFrame)
helper:SetAllPoints(WorldMapDetailFrame)
helper:SetFrameLevel(2)
helper.tex = helper:CreateTexture()
helper.tex:SetTexture(0, 0, 0, 0.8)
helper.tex:SetAllPoints(helper)
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

local function translateShort(msg)
	if(tonumber(msg) and msg:len() % 6 == 0) then
		for i=1, msg:len(), 6 do
			x = msg:sub(i, i+2)
			y = msg:sub(i+3, i+5)
			x, y = tonumber(x)/10, tonumber(y)/10
			if(x and y) then plot(x, y) end
		end
		return true
	end
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

		local wowheadURL = msg:match(":?(%d+)$")
		if(not (wowheadURL and translateShort(wowheadURL))) then
			local zone = GetMapInfo()
			local zoneDB = zone and zones[zone]
			if(zoneDB) then
				msg = msg:gsub(" ", "(.-)")
				for name, coords in pairs(zoneDB) do
					if(name:match(msg)) then
						translateShort(coords)
					end
				end
			else
				print("|cffee8800FindYourWay:|r I can't understand you.")
			end
		end
	end
end

SlashCmdList['FINDYOURWAY'] = FindYourWay
SLASH_FINDYOURWAY1 = "/way"
SLASH_FINDYOURWAY2 = "/fyw"
SLASH_FINDYOURWAY3 = "/findyourway"
SLASH_FINDYOURWAY4 = "/find"