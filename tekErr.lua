

local linkstr = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"
local lastName, editbox, butt


local buttfunc = tekErrMinimapButton
tekErrMinimapButton = nil


local function OnHyperlinkClick(frame, link, text)
	local _, _, msg = string.find(link, "tekerr:(.+)")
	editbox:SetText(text.. "\n".. msg)
end


local f = CreateFrame("ScrollingMessageFrame", nil, UIParent)
f:SetMaxLines(250)
f:SetFontObject(GameFontHighlightSmall)
f:SetJustifyH("LEFT")
f:SetFading(false)
f:EnableMouseWheel(true)
f:SetScript("OnMouseWheel", function(frame, delta)
	if delta > 0 then
		if IsShiftKeyDown() then frame:ScrollToTop()
		else frame:ScrollUp() end
	elseif delta < 0 then
		if IsShiftKeyDown() then frame:ScrollToBottom()
		else frame:ScrollDown() end
	end
end)
f:SetScript("OnShow", function() if butt then butt:Hide() end end)
f:SetScript("OnHide", f.ScrollToBottom)
f:SetScript("OnHyperlinkClick", OnHyperlinkClick)
f:SetScript("OnEvent", function(self, ...) self:AddMessage(string.join(", ", ...), 0.0, 1.0, 1.0) end)
f:RegisterEvent("ADDON_ACTION_FORBIDDEN")
--~ f:RegisterEvent("ADDON_ACTION_BLOCKED")  -- We usually don't care about these, as they aren't fatal
f:Hide()
TheLowDownRegisterFrame(f)
TheLowDownRegisterFrame = nil


seterrorhandler(function(msg)
	local _, _, stacktrace = string.find(debugstack() or "", "[^\n]+\n(.*)")
	f:AddMessage(string.format(linkstr, date("%X"), stacktrace, msg))
	if not butt then butt = buttfunc(f); buttfunc = nil end
	if not f:IsVisible() then butt:Show() end
end)


local OptionHouse = LibStub("OptionHouse-1.1")
local _, title = GetAddOnInfo("tekErr")
local author, version = GetAddOnMetadata("tekErr", "Author"), GetAddOnMetadata("tekErr", "Version")
local oh = OptionHouse:RegisterAddOn("tekErr", title, author, version)
oh:RegisterCategory("Errors", function()
	local frame = CreateFrame("Frame", nil, UIParent)

	editbox = CreateFrame("EditBox", nil, frame)
	editbox:SetPoint("TOPLEFT")
	editbox:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, -100)
	editbox:SetFontObject(GameFontHighlightSmall)
	editbox:SetTextInsets(8,8,8,8)
	editbox:SetBackdrop{
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	}
	editbox:SetBackdropColor(.1,.1,.1,.3)
	editbox:SetMultiLine(true)
	editbox:SetAutoFocus(false)
	editbox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

	f:SetParent(frame)
	f:SetPoint("BOTTOMLEFT")
	f:SetPoint("TOPRIGHT", editbox, "BOTTOMRIGHT")
	f:SetFrameStrata("DIALOG")
	f:Show()

	frame:SetScript("OnShow", function(frame)
		f:SetFrameLevel(frame:GetFrameLevel())
		frame:SetScript("OnShow", nil)
	end)

	return frame
end)

