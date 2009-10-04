local thisSession = {}

local function getName()
	local name, server = UnitName("target")
	if(not name) then return end

	if(server and server ~= "") then
		return name.."-"..server
	else
		return name
	end
end

local function doKarma(color, reason)
	cargKarma = cargKarma or {}
	local name = getName()
	if(not name) then return end

	cargKarma[name] = ("|cff%s%s %s|r"):format(color, name, reason)
	thisSession[name] = true
end

SlashCmdList["CARGKARMA_GOOD"] = function(msg) doKarma("00ff00", msg or "has good karma.") end
SlashCmdList["CARGKARMA_BAD"] = function(msg) doKarma("ff0000", msg or "has bad karma.") end
SLASH_CARGKARMA_GOOD1 = "/good"
SLASH_CARGKARMA_BAD1 = "/bad"

LibStub("LibCargEvents-1.0").RegisterEvent("cargGank", "PLAYER_TARGET_CHANGED", function()
	cargKarma = cargKarma or {}
	local name = getName()
	if(not name or not cargKarma[name] or thisSession[name]) then return end

	UIErrorsFrame:AddMessage(cargKarma[name])
	thisSession[name] = true
end)