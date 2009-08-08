--[[
	cargUI
]]

PVPParentFrameTab2:Click()

local texturepath
local dummy = function() end
if(IsAddOnLoaded("cargUI")) then -- Loaded in cargInterface or externally?
	texturepath = [[Interface\AddOns\cargUI\textures\]]
else
	texturepath = [[Interface\AddOns\cargInterface\cargUI\textures\]]
end

RAID_CLASS_COLORS['SHAMAN'] = { r = 0, g = .8, b = .6 }

local addon = CreateFrame("Frame", nil, UIParent)
addon:RegisterEvent"PLAYER_ENTERING_WORLD"
addon:SetScript("OnEvent", function()
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMLEFT")
	ChatFrame1:SetWidth(300)
	ChatFrame1.ClearAllPoints = dummy
	ChatFrame1.SetPoint = dummy
	ChatFrame1:SetUserPlaced(nil)

	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 6)
	ChatFrame3:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, 6)
	ChatFrame3.ClearAllPoints = dummy
	ChatFrame3.SetPoint = dummy
	ChatFrame3:SetUserPlaced(nil)
	ChatFrame1:SetFrameLevel(1)
end)
	
UIParent:SetScale(0.75)

texturepath = nil

local BAR_WIDTH = 220

local bar1, bar2
for i=1, 2 do
	local bar = CreateFrame("Frame", "cargUI"..i, UIParent)
	bar:SetHeight(20)
	bar:SetBackdrop({
		bgFile = "Interface\\AddOns\\lolTip\\Textures\\UI-StatusBar", tile = true, tileSize = 16,
		edgeFile = "Interface\\AddOns\\lolTip\\Textures\\UI-Tooltip-Border", edgeSize = 8,
		insets = {left = 2, right = 2, top = 2, bottom = 2},
	})
	--frame1:SetBackdropColor(0.20, 0.40, 8.5, 1) --Saved if i want it that blue sometime again
	bar:SetBackdropColor(0.2, 0.2, 0.2, 0.6)
	bar:SetBackdropBorderColor(0, 0, 0)
	bar:SetFrameStrata"BACKGROUND"
	if(bar1) then bar2 = bar else bar1 = bar end
end
bar1:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMLEFT", -1, -2)
bar1:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 1, -2)
bar2:SetPoint("BOTTOMRIGHT", BAR_WIDTH-18, -2)
bar2:SetWidth(BAR_WIDTH)
bar2:SetBackdropColor(0.1, 0.1, 0.1, 0.6)
bar2:SetFrameLevel(3)

local hideBarButton, hidden
local LFX = LibStub and LibStub("LibFx-1.1", true)
if(LFX) then
	hidden = true
	local offset = BAR_WIDTH-20
	local slide = LFX.New{
		frame = bar2,
		anim = "Translate",
		ramp = "Smooth",
		xOffset = offset,
		duration = 0.3,
	}

	hideBarButton = CreateFrame("Button", nil, UIParent)
	hideBarButton:SetScript("OnClick", function() fixed = not fixed end)
	hideBarButton:SetWidth(20)
	hideBarButton:SetHeight(20)
	hideBarButton:SetPoint("LEFT", bar2, "LEFT", 0, 0)
	hideBarButton:SetNormalFontObject("GameFontHighlightSmall")
	hideBarButton:SetText("<")
	hideBarButton:SetScript("OnClick", function(self)
		if(hidden) then
			slide.xOffset = -offset
			slide()
			self:SetText(">")
		else
			slide.xOffset = offset
			slide()
			self:SetText("<")
		end
		hidden = not hidden
	end)
end

local mouseOver = CreateFrame("Frame", nil, UIParent)
mouseOver:SetPoint("BOTTOMRIGHT")
mouseOver:SetWidth(BAR_WIDTH)
mouseOver:SetHeight(100)
mouseOver:SetScript("OnUpdate", function(self)
	local yes = MouseIsOver(self)
	if((yes and hidden) or (not yes and not hidden)) then
		hideBarButton:Click()
	end
end)
gMouse = mouseOver


--[[
local tastyFrame = CreateFrame("Frame", nil, UIParent)
tastyFrame:SetPoint("BOTTOM", 0, 10)
tastyFrame:SetWidth(50)
tastyFrame:SetHeight(20)
tastyFrame:SetScale(1.4)

local tastyText = tastyFrame:CreateFontString(nil, "OVERLAY")
tastyText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
tastyText:SetText("0")
tastyText:SetAllPoints()

tastyFrame:SetScript("OnEvent", function()
	tastyText:SetText(GetItemCount(19807))
end)
tastyFrame:RegisterEvent"BAG_UPDATE"
--]]