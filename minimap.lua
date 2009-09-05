--[[
	cargMinimap
]]

local LCE = LibStub("LibCargEvents-1.0")
local addonPath = debugstack():match("(.+\\).-\.lua:")
local texturepath = addonPath.."textures\\"

local dummy = function() return nil end
local frames = {
	MinimapZoomIn,
	MinimapZoomOut,
	MinimapToggleButton,
	MinimapBorderTop,
	MiniMapWorldMapButton,
	MinimapBorder,
	MiniMapBattlefieldBorder,
	MiniMapMailBorder,
	MiniMapMailFrame,
	GameTimeFrame,
	MinimapNorthTag,
	MiniMapVoiceChatFrame,
	MinimapZoneTextButton,
	VoiceChatTalkers,
	MiniMapTracking,
}

local origClick = Minimap:GetScript("OnMouseUp")
local tracking = UIParent:CreateFontString()
tracking:SetPoint("BOTTOMRIGHT", MinimapCluster, "TOPRIGHT", -20, 20)
tracking:SetFontObject(GameFontHighlight)
tracking:Hide()

local mmp
LCE.RegisterEvent("cargMinimap", "PLAYER_LOGIN", function()
	if(event ~= "PLAYER_LOGIN") then return nil end

	--local ring = Minimap:CreateTexture("cargMinimapRing","OVERLAY")
	--ring:SetWidth(170)
	--ring:SetHeight(170)
	--ring:SetTexture(texturepath.."ring")
	--ring:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
	--ring:SetAlpha(.2)

	MinimapCluster:ClearAllPoints()
    MinimapCluster:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT")
	MinimapCluster:SetScale(0.01)

    MiniMapBattlefieldFrame:SetParent(Minimap)
    MiniMapBattlefieldFrame:ClearAllPoints()
    MiniMapBattlefieldFrame:ClearAllPoints()
	MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, "TOPRIGHT", -24, 1)
	
	Minimap:EnableMouseWheel(true)

	Minimap:SetScript("OnMouseWheel", function()
			if(arg1 < 0) then
				Minimap_ZoomIn()
			else
				Minimap_ZoomOut()
			end
	end)
	
	Minimap:SetMaskTexture(texturepath.."mask")
	
	Minimap:SetScript("OnEnter", function() tracking:Show() end)
	Minimap:SetScript("OnLeave", function() tracking:Hide() end)

	Minimap:SetScript("OnMouseUp", function(self, button)
		if(button == "RightButton") then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, Minimap, 0, 0)
		else
			origClick(self)
		end
	end)

	maskTexture = nil

	for _, frame in pairs(frames) do
		frame.Show = dummy
		frame:Hide()
	end
	frames = nil
	texturepath = nil
end)

LCE.RegisterEvent("cargMinimap", "MINIMAP_UPDATE_TRACKING", function()
	local trackName, trackActive
	for i=1, GetNumTrackingTypes() do
		trackName, _, trackActive = GetTrackingInfo(i)
		if(trackActive) then
			tracking:SetText(trackName)
			break
		end
	end
	if(not trackActive) then tracking:SetText("None") end
end)

Minimap:SetZoom(0)
local shown = false
function ToggleMinimap()
	if(shown) then
		MinimapCluster:SetScale(0.01)
	else
		MinimapCluster:SetScale(2.4)
	end
	shown = not shown
end