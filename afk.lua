--[[
	Blatant LazyAFK-ripoff (by Cralor),
	but I included a display of missed whispers
]]

local AFK
local messages, strings = {}, {}

local addon = CreateFrame("Frame", nil, UIParent)
addon:Hide()
addon:SetHeight(160)
addon:SetWidth(350)
addon:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
addon:SetBackdrop{
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = {
        left = 11,
        right = 12,
        top = 12,
        bottom = 11
    }
}
local text = addon:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
text:SetText("You are AFK!")
text:SetPoint("TOP", 0, -20)
local timer = addon:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge")
timer:SetText("0:00")
timer:SetPoint("TOP", 0, -55)

local button = CreateFrame("Button", nil, addon, "UIPanelButtonTemplate")
button:SetHeight(45)
button:SetWidth(125)
button:SetPoint("BOTTOM", 0, 15)
button:SetText("I'm Back!")
button:RegisterForClicks("AnyUp")
button:SetScript("OnClick", function() SendChatMessage("", "AFK") end)

local function updateMessages()
	for i=1, max(#strings, #messages) do
		if(i > #messages) then
			strings[i]:Hide()
		else
			if(not strings[i]) then
				local string = addon:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
				local prev = strings[i-1]
				if(prev) then
					string:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -2)
					string:SetPoint("TOPRIGHT", prev, "BOTTOMRIGHT", 0, -2)
				else
					string:SetPoint("TOPLEFT", 20, -90)
					string:SetPoint("TOPRIGHT", -20, -90)
				end
				string:SetJustifyH("LEFT")
				string:SetTextColor(1, 0.5, 1)
				strings[i] = string
			end
			local string = strings[i]
			string:Show()
			string:SetText(messages[i])
		end
	end
	addon:SetHeight(160+14*#messages)
end

addon:SetScript("OnEvent", function(self, event, ...) self[event](self, event, ...) end)

function addon:PLAYER_FLAGS_CHANGED(event)
	if(UnitIsAFK("player")) then
		self:Show()
		AFK = time()
	else
		AFK = nil
		self:Hide()
		messages = {}
		updateMessages()
	end
end
addon.PLAYER_ENTERING_WORLD = addon.PLAYER_FLAGS_CHANGED

function addon:CHAT_MSG_WHISPER(event, msg, author)
	if not AFK then return end
	messages[#messages+1] = ("|cffcccccc%s»|r %s: %s"):format(date"%H%M.%S", author, msg)
	updateMessages()
end

local update = 0
addon:SetScript("OnUpdate", function(self, elapsed)
	update = update + elapsed
	if(update < 0.3) then return end
	update = 0

	local total = time()-AFK
	local sec = mod(total, 60)
	local min = mod(floor(total / 60), 60)
	local hour = floor(total / 3600)
	timer:SetFormattedText("%01d:%02d:%02d", hour, min, sec)
end)
addon:RegisterEvent("CHAT_MSG_WHISPER")
addon:RegisterEvent("PLAYER_FLAGS_CHANGED")
addon:RegisterEvent("PLAYER_ENTERING_WORLD")