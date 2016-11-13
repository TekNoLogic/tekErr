
local myname, ns = ...


local linkstr = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"


function ns.CreateMessageFrame(parent)
	local frame = CreateFrame("ScrollingMessageFrame", nil, parent)

	frame:SetMaxLines(250)
	frame:SetFontObject(GameFontHighlightSmall)
	frame:SetJustifyH("LEFT")
	frame:SetFading(false)
	TheLowDownRegisterFrame(frame)
	TheLowDownRegisterFrame = nil


	seterrorhandler(function(msg)
		local _, _, stacktrace = string.find(debugstack() or "", "[^\n]+\n(.*)")
		frame:AddMessage(string.format(linkstr, date("%X"), stacktrace, msg))
		if not frame:IsVisible() then ns.SendMessage("_NEW_ERROR") end
	end)


	frame:EnableMouseWheel(true)
	frame:SetHyperlinksEnabled(true)
	frame:SetScript("OnHide", frame.ScrollToBottom)
	frame:SetScript("OnHyperlinkClick", function(self, link, text)
		local _, _, msg = string.find(link, "tekerr:(.+)")
		editbox:SetText(text.. "\n".. msg)
	end)
	frame:SetScript("OnMouseWheel", function(self, delta)
		if delta > 0 then
			if IsShiftKeyDown() then
				self:ScrollToTop()
			else
				self:ScrollUp()
			end
		elseif delta < 0 then
			if IsShiftKeyDown() then
				self:ScrollToBottom()
			else
				self:ScrollDown()
			end
		end
	end)

	return frame
end
