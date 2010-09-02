local name, ns = ...

local textures = ns.texturePath

-- Display tracking on mouse over
local tracking = Minimap:CreateFontString(nil, "OVERLAY")
tracking:SetPoint("BOTTOMLEFT", Minimap, "TOPLEFT", 0, 4)
tracking:SetPoint("BOTTOMRIGHT", Minimap, "TOPRIGHT", 0, 4)
tracking:SetFontObject(GameFontHighlight)
tracking:Hide()

ns.OnLoad(function()

	local art3 = Minimap:CreateTexture(nil, "OVERLAY")
	art3:SetTexture(textures.."ring")
	art3:SetPoint("CENTER")
	art3:SetWidth(170)
	art3:SetHeight(170)
	art3:SetAlpha(0.7)

	local gloss = Minimap:CreateTexture(nil,"OVERLAY")
	gloss:SetAllPoints()
	gloss:SetTexture(textures.."minimap-gloss")
	gloss:SetAlpha(0.5)

	-- Positioning, setup
	Minimap:ClearAllPoints()
    Minimap:SetPoint("BOTTOMLEFT", 0, 0)
	MinimapCluster:ClearAllPoints()
	MinimapCluster:SetPoint("BOTTOMLEFT", 20, 20)
	MinimapCluster:EnableMouse(false)

	Minimap:SetBackdrop{
		bgFile = textures.."bg",
		insets = {left=-2, right=-2, top=-2, bottom=-2}
	}
	Minimap:SetBackdropColor(0, 0, 0, 0.5)

    MiniMapBattlefieldFrame:SetParent(UIParent)
    MiniMapBattlefieldFrame:ClearAllPoints()
	MiniMapBattlefieldFrame:SetPoint("RIGHT", -2, 0)

	Minimap:SetBlipTexture(textures.."track")

	Minimap:EnableMouseWheel(true)
	Minimap:SetZoom(3)
	Minimap.SetZoom = function() end

	-- Scaling on mouseWheel
	Minimap:SetScript("OnMouseWheel", function(self, delta)
		self:SetScale(self:GetScale()+0.1*delta*(IsShiftKeyDown() and 2 or 1))
	end)

	-- Toggle tracking
	Minimap:SetScript("OnEnter", function() tracking:Show() end)
	Minimap:SetScript("OnLeave", function() tracking:Hide() end)

	-- Rightclick for tracking-menu
	local _OnMouseUp = Minimap:GetScript("OnMouseUp")
	Minimap:SetScript("OnMouseUp", function(self, button, ...)
		if(button == "RightButton") then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, Minimap, 0, 0)
		else
			return _OnMouseUp(self, button, ...)
		end
	end)

	-- Hide minimap parts
	for _, frame in pairs{
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
	} do
		frame:Hide()
		frame.Show = frame.Hide
	end
end)

-- Update tracking
ns.RegisterEvent("MINIMAP_UPDATE_TRACKING", function()
	for i=1, GetNumTrackingTypes() do
		local name, _, active = GetTrackingInfo(i)
		if(active) then
			return tracking:SetText(name)
		end
	end

	tracking:SetText("None")
end)

-- Scale minimap down instead of hiding, so addons are not hindered
Minimap:SetZoom(0)
local shown = true
function ToggleMinimap()
	shown = not shown
	Minimap:SetScale(shown and 1 or 0.01)
end
