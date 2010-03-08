local frames = {}

for i=1, INBOXITEMS_TO_DISPLAY do
	local text = _G["MailItem"..i.."Button"]:CreateFontString(nil, "ARTWORK", "NumberFontNormal")
	text:SetPoint("BOTTOMRIGHT", -5, 2)
	frames[i] = text

	local cod = _G["MailItem"..i.."ButtonCOD"]
	cod:ClearAllPoints()
	cod:SetPoint("TOP", 0, -2)
end


hooksecurefunc("InboxFrame_Update", function()
	local offset = (InboxFrame.pageNum - 1) * INBOXITEMS_TO_DISPLAY
	for i=1, INBOXITEMS_TO_DISPLAY do
		local text, attachments = frames[i], 0
		local money, _, _, itemCount = select(5, GetInboxHeaderInfo(i+offset))

		if(itemCount) then
			text:SetText(itemCount)
		elseif(money and money > 0) then
			local gold = floor(money / 10000)
			local silver = floor(mod(money / 100, 100))
			local copper = floor(mod(money, 100))

			local formatted
			if(gold > 0) then
				formatted = ("|cffffd700%dg|r"):format(gold)
			elseif(silver > 0) then
				formatted = ("|cffc7c7cf%ds|r"):format(silver)
			else
				formatted = ("|cffeda55f%dc|r"):format(copper)
			end
			text:SetText(formatted)
		else
			text:SetText("")
		end
	end
end)

local _OnClick = InboxFrame_OnClick
InboxFrame_OnClick = function(self, index, ...)
	local _, _, _, _, money, COD, _, hasItem, _, wasReturned, _, canReply = GetInboxHeaderInfo(index)
 	if(IsShiftKeyDown()) then
		if(money > 0) then
			TakeInboxMoney(index)
		elseif(COD > 0) then
			return
		elseif(hasItem and COD == 0) then
			TakeInboxItem(index)
		end
	elseif(IsControlKeyDown() and not wasReturned and canReply) then
		ReturnInboxItem(index)
	else
		return _OnClick(self, index, ...)
	end
end