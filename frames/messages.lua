
local myname, ns = ...


local LINKSTR = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"


local function OnErrorReceived(self, event, msg, stacktrace)
	self:AddMessage(LINKSTR:format(date("%X"), stacktrace, msg))
	if not self:IsVisible() then ns.SendMessage("_NEW_ERROR") end
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


function ns.CreateMessageFrame(parent)
	local frame = CreateFrame("ScrollingMessageFrame", nil, parent)

	frame:SetMaxLines(250)
	frame:SetFontObject(GameFontHighlightSmall)
	frame:SetJustifyH("LEFT")
	frame:SetFading(false)
	frame:EnableMouseWheel(true)
	frame:SetHyperlinksEnabled(true)

	frame:SetScript("OnHide", frame.ScrollToBottom)
	frame:SetScript("OnMouseWheel", OnMouseWheel)

	ns.RegisterCallback(frame, "_ERROR_RECEIVED", OnErrorReceived)

	ns.RegisterScrollReset(frame)
	ns.RegisterScrollReset = nil

	return frame
end
