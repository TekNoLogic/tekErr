
local myname, ns = ...


local linkstr = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"


local panel = ns.tekPanelAuction("tekErrPanel", "tekErr")
local f = CreateFrame("ScrollingMessageFrame", nil, panel)
f:SetPoint("BOTTOMRIGHT", -15, 40)
f:SetMaxLines(250)
f:SetFontObject(GameFontHighlightSmall)
f:SetJustifyH("LEFT")
f:SetFading(false)
f:SetScript("OnShow", function() ns.SendMessage("_PANEL_OPENED") end)
f:SetScript("OnEvent", function(self, ...) self:AddMessage(string.join(", ", ...), 0.0, 1.0, 1.0) end)
f:RegisterEvent("ADDON_ACTION_FORBIDDEN")
--~ f:RegisterEvent("ADDON_ACTION_BLOCKED")  -- We usually don't care about these, as they aren't fatal
TheLowDownRegisterFrame(f)
TheLowDownRegisterFrame = nil


ns.RegisterCallback("_SHOW_PANEL", function() ShowUIPanel(panel) end)


seterrorhandler(function(msg)
	local _, _, stacktrace = string.find(debugstack() or "", "[^\n]+\n(.*)")
	f:AddMessage(string.format(linkstr, date("%X"), stacktrace, msg))
	if not f:IsVisible() then ns.SendMessage("_NEW_ERROR") end
end)


panel:SetScript("OnShow", function(self)
	local editbox = CreateFrame("EditBox", nil, panel)
	editbox:SetPoint("TOPLEFT", 25, -75)
	editbox:SetPoint("BOTTOMRIGHT", panel, "TOPRIGHT", -15, -100)
	editbox:SetFontObject(GameFontHighlightSmall)
	editbox:SetTextInsets(8,8,8,8)
	editbox:SetBackdrop{
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	}
	editbox:SetBackdropColor(.1,.1,.1,1)
	editbox:SetMultiLine(true)
	editbox:SetAutoFocus(false)
	editbox:SetScript("OnTextSet", function(self)
		if self:GetText() == "" then
			editbox:SetPoint("BOTTOMRIGHT", panel, "TOPRIGHT", -15, -100)
		else
			editbox:SetPoint("BOTTOMRIGHT", panel, "TOPRIGHT", -15, -325)
			editbox:SetFocus()
			editbox:HighlightText()
		end
	end)
	editbox:SetScript("OnEscapePressed", editbox.ClearFocus)
	editbox:SetScript("OnEditFocusLost", function(editbox) editbox:SetText("") end)

	f:SetPoint("TOPLEFT", editbox, "BOTTOMLEFT")
	f:EnableMouseWheel(true)
	f:SetHyperlinksEnabled(true)
	f:SetScript("OnHide", f.ScrollToBottom)
	f:SetScript("OnHyperlinkClick", function(frame, link, text)
		local _, _, msg = string.find(link, "tekerr:(.+)")
		editbox:SetText(text.. "\n".. msg)
	end)
	f:SetScript("OnMouseWheel", function(frame, delta)
		if delta > 0 then
			if IsShiftKeyDown() then frame:ScrollToTop()
			else frame:ScrollUp() end
		elseif delta < 0 then
			if IsShiftKeyDown() then frame:ScrollToBottom()
			else frame:ScrollDown() end
		end
	end)

	self:SetScript("OnShow", nil)
end)
