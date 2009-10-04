--[[
	Yet another junk-selling addon
]]
local LCE = LibStub("LibCargEvents-1.0")

local function cash_to_string(cash)
	if(not cash) then return "no" end

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

local function getID(link) return link and tonumber(link:match("item:(%d+)")) end

LCE.RegisterEvent("cargSellsStuff", "VARIABLES_LOADED", function()
	cargSellsStuff = cargSellsStuff or {}
end)

LCE.RegisterEvent("cargSellsStuff", "MERCHANT_SHOW", function()
	local count = 0
	local profit = 0
	for bag = 0, 4 do
		for slot = 0, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if(link) then
				if(select(3, GetItemInfo(link)) == 0 or (cargSellsStuff and cargSellsStuff[getID(link)])) then
					local _, stack = GetContainerItemInfo(bag, slot)
					local value = select(11, GetItemInfo(link))
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

SlashCmdList['CARGSELLSSTUFF'] = function(link)
	local added, removed
	local found = {link:trim():split(" ")}

	for _, link in pairs(found) do
		local id = getID(link)
		if(id and cargSellsStuff[id]) then
			cargSellsStuff[id] = nil
			removed = removed and removed..", "..link or link
		elseif(id) then
			added = added and added..", "..link or link
			cargSellsStuff[id] = true
		end
	end

	if(removed) then print("Removed "..removed.." from cargSellsStuff") end
	if(added) then print("Added "..added.." to cargSellsStuff") end
end
SLASH_CARGSELLSSTUFF1 = '/junk'