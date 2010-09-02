local name, ns = ...

if(not ns.cata) then
	-- Battlegrounds tab first, please!
	PVPParentFrameTab2:Click()
end

local addonPath = debugstack():match("(.+\\).-\.lua:")
local texturepath = addonPath.."textures/"

local dummy = function() end

RAID_CLASS_COLORS['SHAMAN'] = { r = 0, g = .8, b = .6 }

ns.OnLoad(function()
	WatchFrame:ClearAllPoints()
	WatchFrame:SetPoint("TOPRIGHT", UIParent, 0, -200)
	WatchFrame.ClearAllPoints = dummy
	WatchFrame.SetPoint = dummy
	WatchFrame:SetHeight(500)

	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint("BOTTOMRIGHT", -10, 10)
	ChatFrame1:SetWidth(300)
	ChatFrame1:SetFrameStrata("MEDIUM")
	ChatFrame1.ClearAllPoints = dummy
	ChatFrame1.SetPoint = dummy
	ChatFrame1:SetUserPlaced(nil)

	ChatFrame3:ClearAllPoints()
	ChatFrame3:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 16)
	ChatFrame3:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 0, 16)
	ChatFrame3.ClearAllPoints = dummy
	ChatFrame3.SetPoint = dummy
	ChatFrame3:SetUserPlaced(nil)
end)

UIParent:SetScale(0.75)

local chatBG = CreateFrame("Frame", nil, UIParent)
chatBG:SetBackdrop{
	bgFile = "Interface\\AddOns\\lolTip\\Textures\\UI-StatusBar",
	edgeFile = "Interface\\AddOns\\lolTip\\Textures\\UI-Tooltip-Border", edgeSize = 8,
	insets = {left = 1, right = 1, top = 1, bottom = 1},
}
chatBG:SetFrameStrata("BACKGROUND")
chatBG:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", -4, 4)
chatBG:SetPoint("BOTTOMRIGHT", ChatFrame1, "BOTTOMRIGHT", 4, -4)
chatBG:SetBackdropColor(0.2, 0.2, 0.2, 0.6)
chatBG:SetBackdropBorderColor(0, 0, 0)

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

--[[
local bottombar = CreateFrame("Frame", "BottomBar", UIParent)
bottombar:SetBackdrop{bgFile="Interface\\AddOns\\cargInterface\\textures\\bottompanelC"}
bottombar:SetPoint("BOTTOMLEFT", 0, -40)
bottombar:SetPoint("BOTTOMRIGHT", 0, -40)
bottombar:SetHeight(128)
bottombar:SetBackdropColor(90/255, 70/255, 70/255)
bottombar:SetFrameStrata("BACKGROUND")
]]
--WorldFrame:ClearAllPoints()
--WorldFrame:SetPoint("TOPLEFT")
--WorldFrame:SetPoint("BOTTOMRIGHT", 0, 28)
