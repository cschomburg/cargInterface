local thisSession = {}

SlashCmdList["CARGGANK"] = function()
	cargGank = cargGank or {}
	local name = UnitName("target") or UnitName("mouseover")
	if(name) then
		cargGank[name] = true
	end
end
SLASH_CARGGANK1 = "/gank"

LibStub("LibCargEvents-1.0").RegisterEvent("cargGank", "PLAYER_TARGET_CHANGED", function()
	cargGank = cargGank or {}
	local name = UnitName("target")
	if(not name or not cargGank[name] or thisSession[name]) then return end

	UIErrorsFrame:AddMessage(name.." ganked you before!", 1,0,0)
	thisSession[name] = true
end)