--[[
	cargUI
]]

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

local BAR_WIDTH = 300

local bar1, bar2
for i=1, 2 do
	local bar = CreateFrame("Frame", "cargUI"..i, UIParent)
	bar:SetHeight(20)
	bar:SetBackdrop({
		bgFile = "Interface\\AddOns\\cargTip\\textures\\statusbar", tile = true, tileSize = 16,
		edgeFile = "Interface\\AddOns\\cargTip\\textures\\border", edgeSize = 8,
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
bar2:SetPoint("BOTTOMRIGHT", 282, -2)
bar2:SetWidth(BAR_WIDTH)
bar2:SetBackdropColor(0.1, 0.1, 0.1, 0.6)

local LFX = LibStub and LibStub("LibFx-1.1", true)
if(LFX) then
	local hidden = true
	local offset = BAR_WIDTH-20
	local slide = LFX.New{
		frame = bar2,
		anim = "Translate",
		ramp = "Smooth",
		xOffset = offset,
		duration = 0.5,
	}

	local hideBarButton = CreateFrame("Button", nil, UIParent)
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

local friends = cargoShip("picoFriends", { noIcon = true, })
friends:SetPoint("BOTTOMRIGHT", bar2, "BOTTOMRIGHT", -5, 2)

local durability = cargoShip("Attrition", { noIcon = true, })
durability:SetPoint("RIGHT", friends, "LEFT", -15, 0)

local fps = cargoShip("picoFPS")
fps:SetPoint("RIGHT", durability, "LEFT", -15, 0)

local xp = cargoShip("picoEXP", {
	noIcon = true,
	scale = 1.4,
	fontStyle = "OUTLINE",
})
xp:SetPoint("RIGHT", durability, "LEFT", -60, 0)

local bugs = cargoShip("BugSack", {})
bugs:SetPoint("RIGHT", xp, "LEFT", -15, 0)

local honor = cargoShip("cargoHonor", {
	scale = 1.7,
	fontStyle = "OUTLINE",
})
honor:SetPoint("BOTTOM", 0, 10)

local f = CreateFrame"Frame"
f:SetScript("OnEvent", function(self, event)
	if(select(2, IsInInstance()) == "pvp") then
		honor:Show()
		xp:Hide()
	else
		honor:Hide()
		xp:Show()
	end
end)
f:RegisterEvent"PLAYER_ENTERING_WORLD"


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