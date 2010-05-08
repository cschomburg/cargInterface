--[[
	cargMinimap
]]

local LCE = LibStub("LibCargEvents-1.0")
local LFX = LibStub("LibFx-1.1")

local addonPath = debugstack():match("(.+\\).-\.lua:")
local texturepath = addonPath.."textures\\"

local dummy = function() end
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
local tracking = Minimap:CreateFontString(nil, "OVERLAY")
tracking:SetPoint("BOTTOMLEFT", Minimap, "TOPLEFT", 0, 4)
tracking:SetPoint("BOTTOMRIGHT", Minimap, "TOPRIGHT", 0, 4)
tracking:SetFontObject(GameFontHighlight)
tracking:Hide()

function GetMinimapShape() return 'SQUARE' end

local mmp
LCE("PLAYER_LOGIN", function()
	local art1 = Minimap:CreateTexture(nil, "BACKGROUND")
	art1:SetPoint("CENTER")
	art1:SetTexture(texturepath.."art1")
	art1:SetWidth(300)
	art1:SetHeight(300)
	art1:SetAlpha(0.1)
	LFX.New{
		frame = art1,
		anim = "Rotate",
		deg = 360,
		duration = 20,
		loop = true,
	}()

	local art2 = Minimap:CreateTexture(nil, "BACKGROUND")
	art2:SetPoint("CENTER")
	art2:SetTexture(texturepath.."art2")
	art2:SetWidth(375)
	art2:SetHeight(375)
	art2:SetAlpha(0.2)
	LFX.New{
		frame = art2,
		anim = "Rotate",
		deg = 360,
		duration = 30,
		loop = true,
	}()

	local art3 = Minimap:CreateTexture("gRing", "OVERLAY")
	art3:SetTexture(texturepath.."ring")
	art3:SetPoint("CENTER")
	art3:SetWidth(170)
	art3:SetHeight(170)
	art3:SetAlpha(0.7)

	local gloss = Minimap:CreateTexture(nil,"OVERLAY")
	gloss:SetAllPoints()
	gloss:SetTexture(texturepath.."minimap-gloss")
	gloss:SetAlpha(0.5)

	Minimap:ClearAllPoints()
    Minimap:SetPoint("BOTTOMLEFT", 0, 0)
	MinimapCluster:ClearAllPoints()
	MinimapCluster:SetPoint("BOTTOMLEFT", 20, 20)
	MinimapCluster:EnableMouse(false)

	Minimap:SetBackdrop{
		bgFile = texturepath.."bg",
		insets = {left=-2, right=-2, top=-2, bottom=-2}
	}
	Minimap:SetBackdropColor(0, 0, 0, 0.5)

    MiniMapBattlefieldFrame:SetParent(UIParent)
    MiniMapBattlefieldFrame:ClearAllPoints()
	MiniMapBattlefieldFrame:SetPoint("RIGHT", -2, 0)

	Minimap:SetBlipTexture(texturepath.."track")

	Minimap:EnableMouseWheel(true)
	Minimap:SetZoom(3)
	Minimap.SetZoom = dummy

	Minimap:SetScript("OnMouseWheel", function(self)
		self:SetScale(self:GetScale()+0.1*arg1*(IsShiftKeyDown() and 2 or 1))
	end)
	
	Minimap:SetScript("OnEnter", function() tracking:Show() end)
	Minimap:SetScript("OnLeave", function() tracking:Hide() end)

	Minimap:SetScript("OnMouseUp", function(self, button)
		if(button == "RightButton") then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, Minimap, 0, 0)
		else
			origClick(self)
		end
	end)

	for _, frame in pairs(frames) do
		frame.Show = dummy
		frame:Hide()
	end
end)

LCE("MINIMAP_UPDATE_TRACKING", function()
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
local shown = true
function ToggleMinimap()
	if(shown) then
		Minimap:SetScale(0.01)
	else
		Minimap:SetScale(1)
	end
	shown = not shown
end