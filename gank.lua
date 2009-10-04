local thisSession = {}

SlashCmdList["CARGGANK"] = function()
	cargGang = cargGang or {}
	local name = UnitName("target") or UnitName("mouseover")
	if(name) then
		cargGang[name] = true
	end
end
SLASH_CARGGANK1 = "/gank"

LCE.RegisterEvent("cargGang", "TARGET_CHANGED", function()
	cargGang = cargGang or {}
	local name = UnitName("target")
	if(not name or not cargGang[name] or thisSession[name]) then return end

	UIErrorsFrame:AddMessage(name.." ganked you!", 1,0,0)
	thisSession[name] = true
end)