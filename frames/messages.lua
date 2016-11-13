
local myname, ns = ...


local LINKSTR = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"


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
	ns.RegisterScrollReset(frame)
	ns.RegisterScrollReset = nil


	seterrorhandler(function(msg)
		local _, _, stacktrace = string.find(debugstack() or "", "[^\n]+\n(.*)")
		frame:AddMessage(string.format(LINKSTR, date("%X"), stacktrace, msg))
		if not frame:IsVisible() then ns.SendMessage("_NEW_ERROR") end
	end)


	frame:EnableMouseWheel(true)
	frame:SetHyperlinksEnabled(true)
	frame:SetScript("OnHide", frame.ScrollToBottom)
	frame:SetScript("OnMouseWheel", OnMouseWheel)

	return frame
end
