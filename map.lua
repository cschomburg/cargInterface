-- Scaling fixes, needed since WorldMapFrame became tainted
local _SetupFullScreenScale = SetupFullScreenScale
function SetupFullscreenScale(self)
	if(self ~= WorldMapFrame) then
		return _SetupFullscreenScale(self)
	end
end

local function tweak()
	BlackoutWorld:Hide()
	WorldMapFrame:EnableKeyboard(nil)
	WorldMapFrame:EnableMouse(nil)
	WorldMapFrame:SetScale(0.75)

	UIPanelWindows["WorldMapFrame"].area = "center"
	WorldMapFrame:SetAttribute("UIPanelLayout-defined", nil)
end

hooksecurefunc("WorldMap_ToggleSizeUp", tweak)
tweak()
