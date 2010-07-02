local patterns = {
	"http://*",
	"ftp://*",
	"git://*",
	"*@*",
}
for i,p in pairs(patterns) do patterns[i] = p:gsub("*", "[^%%s]+") end

StaticPopupDialogs["CHATLINKS"] = {
	text = "Link text",
	button2 = OKAY,
	hasEditBox = true,
    	hasWideEditBox = true,
	exclusive = 1,
	hideOnEscape = 1,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	whileDead = 1,
	timeout = 0,
}

local origs = {}
local function addMessage(self, text, ...)
	for i,pattern in pairs(patterns) do
		text = text:gsub(pattern, "|Hurl:%1|h|cffff00ff%1|r|h")
	end
	return origs[self](self, text, ...)
end

for i=1, NUM_CHAT_WINDOWS do
	if(i ~= 2) then
		local frame = _G["ChatFrame"..i]
		origs[frame] = frame.AddMessage
		frame.AddMessage = addMessage
	end
end

local _onHyperlinkShow = ChatFrame_OnHyperlinkShow
function ChatFrame_OnHyperlinkShow(self, link, text, button, ...)
	local type, value = link:match("(%a+):(.+)")

	if(type ~= "url") then
		return _onHyperlinkShow(self, link, text, button, ...)
	end

	local dialog = StaticPopup_Show("CHATLINKS")
	dialog.wideEditBox:SetText(value)
	dialog.wideEditBox:SetFocus()
	dialog.wideEditBox:HighlightText()
end
