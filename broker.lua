local cargoShip = LibStub("LibCargoShip-2.1")
local LFX = LibStub("LibFx-1.1")

local BAR_WIDTH = 160
local hidden

local BrokerBar = CreateFrame("Frame", nil, UIParent)
BrokerBar:SetHeight(20)
BrokerBar:SetBackdrop{
	bgFile = "Interface\\AddOns\\lolTip\\Textures\\UI-StatusBar", tile = true, tileSize = 16,
	edgeFile = "Interface\\AddOns\\lolTip\\Textures\\UI-Tooltip-Border", edgeSize = 8,
	insets = {left = 2, right = 2, top = 2, bottom = 2},
}
BrokerBar:SetBackdropBorderColor(0, 0, 0)
BrokerBar:SetFrameStrata"BACKGROUND"
BrokerBar:SetWidth(BAR_WIDTH)
BrokerBar:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
BrokerBar:SetFrameLevel(3)
BrokerBar:SetPoint("BOTTOMRIGHT", BAR_WIDTH+2, -2)

local hidden = true
local slide = LFX.New{
	frame = BrokerBar,
	anim = "Translate",
	ramp = "Smooth",
	duration = 0.3,
	xOffset = BAR_WIDTH,
}

local function toggleBar()
	slide.xOffset = slide.xOffset * -1
	slide()
	hidden = not hidden
end

local mouseOver = CreateFrame("Frame", nil, UIParent)
mouseOver:SetPoint("BOTTOMRIGHT")
mouseOver:SetWidth(BAR_WIDTH)
mouseOver:SetHeight(BAR_WIDTH)
mouseOver:SetScript("OnUpdate", function(self)
	local yes = MouseIsOver(self)
	if(((yes and hidden) or (not yes and not hidden)) and not slide:IsRunning()) then
		toggleBar()
	end
end)

local friends = cargoShip{
	name = "picoFriends",
	noIcon = true
}
friends:SetPoint("BOTTOMRIGHT", BrokerBar, "BOTTOMRIGHT", -5, 2)

local durability = cargoShip{
	name = "Attrition",
	noIcon = true,
}
durability:SetPoint("RIGHT", friends, "LEFT", -15, 0)

local fps = cargoShip("picoFPS")
fps:SetPoint("RIGHT", durability, "LEFT", -15, 0)

local bugs = cargoShip("BugSack")
bugs:SetPoint("RIGHT", durability, "LEFT", -90, 0)

local bottomDisplay = cargoShip{
	scale = 1.5,
	fontStyle = "OUTLINE",
}
bottomDisplay:SetPoint("BOTTOM", 0, 10)

BrokerBar:RegisterEvent("PLAYER_ENTERING_WORLD")
BrokerBar:SetScript("OnEvent", function(self, event)
	if(select(2, IsInInstance()) == "pvp") then
		bottomDisplay:SetDataObject("cargoHonor")
	else
		bottomDisplay:SetDataObject("TourGuide")
	end
end)
