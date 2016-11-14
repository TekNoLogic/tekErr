
local myname, ns = ...


local function OnHyperlinkClick(self, ...)
	ns.SendMessage("_HYPERLINK_CLICKED", ...)
end


local function OnMouseWheel(self, delta)
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
end


local function OnNewMessage(self, event, message)
	self:AddMessage(message)
end


local function OnShow()
	ns.SendMessage("_PANEL_OPENED")
end


function ns.CreateMessageFrame(parent)
	local frame = CreateFrame("ScrollingMessageFrame", nil, parent)

	frame:SetMaxLines(250)
	frame:SetFontObject(GameFontHighlightSmall)
	frame:SetJustifyH("LEFT")
	frame:SetFading(false)
	frame:EnableMouseWheel(true)
	frame:SetHyperlinksEnabled(true)

	frame:SetScript("OnHide", frame.ScrollToBottom)
	frame:SetScript("OnHyperlinkClick", OnHyperlinkClick)
	frame:SetScript("OnMouseWheel", OnMouseWheel)
	frame:SetScript("OnShow", OnShow)

	ns.RegisterCallback(frame, "_NEW_MESSAGE", OnNewMessage)

	ns.RegisterScrollReset(frame)
	ns.RegisterScrollReset = nil

	return frame
end
