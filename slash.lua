SlashCmdList["RELOAD_UI"] = function() ReloadUI() end
SLASH_RELOAD_UI1 = "/rl"

SlashCmdList["DOM_TOGGLE"] = function()
	Dominos:ToggleFrames("all")
	Dominos:ShowFrames("3")
end
SLASH_DOM_TOGGLE1 = "/dt"