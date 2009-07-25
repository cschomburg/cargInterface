--[[
	cargLoader
]]

local addon = CreateFrame("Frame", "cargLoader", UIParent)
local _G = getfenv(0)

local slash = {
	["gatherer,gt"] = "Gatherer,GathererDB_Wowhead,Routes",
	["peggle"] = "Peggle",
}

function addon:event(event)
   if(event == "UPDATE_BATTLEFIELD_STATUS") then
		self:loadAddOn("Capping", 1)
		if(select(6, GetBattlefieldStatus(1)) > 0) then
			self:loadAddOn("Proximo", 1)
		end
	end
end

function addon:loadAddOn(addon, nohint) 
	local loaded, reason = LoadAddOn(addon)
	if(not loaded) then
		ChatFrame1:AddMessage("Loading of "..addon.." failed: "..tostring(reason).."")
	else
		if(not nohint) then 
			ChatFrame1:AddMessage("Loading of "..addon.." was successful.")
		end
	end
end

addon:RegisterEvent"UPDATE_BATTLEFIELD_STATUS"
addon:SetScript("OnEvent", addon.event)

SlashCmdList['LOADADDON'] = function(msg) addon:loadAddOn(msg) end
SLASH_LOADADDON1 = '/loadaddon'
SLASH_LOADADDON2 = '/la'

for cmdstring, addons in pairs(slash) do
	local cmds = {(","):split(cmdstring)}
	local name = "LOADADDON_"..(cmds[1]:upper())
	SlashCmdList[name] = function() for _, v in pairs({(","):split(addons)}) do self:loadAddOn(v) end end
	for i, cmd in ipairs(cmds) do
		_G["SLASH_ADDON_"..name..i] = cmd
	end
end