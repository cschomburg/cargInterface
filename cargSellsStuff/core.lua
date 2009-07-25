--[[
	Yet another junk-selling addon
]]
local function cash_to_string(cash)
	if not cash then return "?" end

	local gold   = floor(cash / (100 * 100))
	local silver = math.fmod(floor(cash / 100), 100)
	local copper = math.fmod(floor(cash), 100)
	gold         = gold   > 0 and "|cffffd700"..gold  .."g|r" or ""
	silver       = silver > 0 and "|cffc7c7cf"..silver.."s|r" or ""
	copper       = copper > 0 and "|cffeda55f"..copper.."c|r" or ""
	copper       = (silver ~= "" and copper ~= "") and " "..copper or copper
	silver       = (gold   ~= "" and silver ~= "") and " "..silver or silver

	return gold..silver..copper
end

local addon = CreateFrame"Frame"
addon:SetScript("OnEvent", function()
	if(event == "VARIABLES_LOADED") then
		cargSellsStuff = cargSellsStuff or {}
		return
	end
	local count = 0
	local profit = 0
	for bag = 0, 4 do
		for slot = 0, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if(link) then
				if(select(3, GetItemInfo(link)) == 0 or (cargSellsStuff and cargSellsStuff[link])) then
					local _, stack = GetContainerItemInfo(bag, slot)
					local value = GetSellValue and GetSellValue(link) or select(11, GetItemInfo(link))
					if(value) then profit = profit + stack*value end
					PickupContainerItem(bag, slot)
					PickupMerchantItem(0)
					count = count + 1
				end
			end
		end
	end

	if(count > 0) then
		print(("Sold %d trash items for %s."):format(count, cash_to_string(profit)))
	end
end)
addon:RegisterEvent("MERCHANT_SHOW")
addon:RegisterEvent("VARIABLES_LOADED")

SlashCmdList['CARGSELLSSTUFF'] = function(link)
	link = link:trim()
	if(cargSellsStuff[link]) then
		cargSellsStuff[link] = nil
		print("Removed "..link.." from cargSellsStuff")
	else
		cargSellsStuff[link] = true
		print("Added "..link.." to cargSellsStuff")
	end
end
SLASH_CARGSELLSSTUFF1 = '/junk'