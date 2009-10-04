--[[
	cargUI
]]
local LCE = LibStub("LibCargEvents-1.0")

PVPParentFrameTab2:Click()

local addonPath = debugstack():match("(.+\\).-\.lua:")
local texturepath = addonPath.."textures/"

local dummy = function() end

RAID_CLASS_COLORS['SHAMAN'] = { r = 0, g = .8, b = .6 }

LCE.RegisterEvent("cargUI", "PLAYER_ENTERING_WORLD", function()
	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMLEFT")
	ChatFrame1:SetWidth(300)
	ChatFrame1:SetFrameLevel(1)
	ChatFrame1.ClearAllPoints = dummy
	ChatFrame1.SetPoint = dummy
	ChatFrame1:SetUserPlaced(nil)

	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 6)
	ChatFrame3:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, 6)
	ChatFrame3.ClearAllPoints = dummy
	ChatFrame3.SetPoint = dummy
	ChatFrame3:SetUserPlaced(nil)
end)

UIParent:SetScale(0.75)

local bar1 = CreateFrame("Frame", "cargUI1", UIParent)
bar1:SetHeight(20)
bar1:SetBackdrop{
	bgFile = "Interface\\AddOns\\lolTip\\Textures\\UI-StatusBar", tile = true, tileSize = 16,
	edgeFile = "Interface\\AddOns\\lolTip\\Textures\\UI-Tooltip-Border", edgeSize = 8,
	insets = {left = 2, right = 2, top = 2, bottom = 2},
}
--frame1:SetBackdropColor(0.20, 0.40, 8.5, 1) --Saved if i want it that blue sometime again
bar1:SetBackdropColor(0.2, 0.2, 0.2, 0.6)
bar1:SetBackdropBorderColor(0, 0, 0)
bar1:SetFrameStrata"BACKGROUND"
bar1:SetPoint("BOTTOMLEFT", ChatFrame1, "BOTTOMLEFT", -1, -2)
bar1:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 1, -2)

local tastyFrame = CreateFrame("Frame", nil, UIParent)
tastyFrame:SetPoint("BOTTOM", 0, 10)
tastyFrame:SetWidth(50)
tastyFrame:SetHeight(20)
tastyFrame:SetScale(1.4)

local tastyText = tastyFrame:CreateFontString(nil, "OVERLAY")
tastyText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
tastyText:SetAllPoints()

tastyFrame:SetScript("OnEvent", function()
	local count = GetItemCount(19807)
	tastyText:SetText(count > 0 and count)
end)
tastyFrame:RegisterEvent"BAG_UPDATE"