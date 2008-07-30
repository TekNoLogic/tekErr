

local linkstr = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"
local lastName, butt


local buttfunc = tekErrMinimapButton
tekErrMinimapButton = nil


local panel = LibStub("tekPanel-Auction").new("tekErrPanel", "tekErr")
local f = CreateFrame("ScrollingMessageFrame", nil, panel)
f:SetPoint("TOPLEFT", 25, -225)
f:SetPoint("BOTTOMRIGHT", -15, 40)
f:SetFrameStrata("DIALOG")
f:SetMaxLines(250)
f:SetFontObject(GameFontHighlightSmall)
f:SetJustifyH("LEFT")
f:SetFading(false)
f:SetScript("OnShow", function() if butt then butt:Hide() end end)
f:SetScript("OnEvent", function(self, ...) self:AddMessage(string.join(", ", ...), 0.0, 1.0, 1.0) end)
f:RegisterEvent("ADDON_ACTION_FORBIDDEN")
--~ f:RegisterEvent("ADDON_ACTION_BLOCKED")  -- We usually don't care about these, as they aren't fatal
TheLowDownRegisterFrame(f)
TheLowDownRegisterFrame = nil


seterrorhandler(function(msg)
	local _, _, stacktrace = string.find(debugstack() or "", "[^\n]+\n(.*)")
	f:AddMessage(string.format(linkstr, date("%X"), stacktrace, msg))
	if not butt then butt = buttfunc(f); buttfunc = nil end
	if not f:IsVisible() then butt:Show() end
end)


panel:SetScript("OnShow", function(self)
	local editbox = CreateFrame("EditBox", nil, panel)
	editbox:SetPoint("TOPLEFT", 25, -75)
	editbox:SetPoint("RIGHT", -15, 0)
	editbox:SetPoint("BOTTOM", f, "TOP")
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

	f:EnableMouseWheel(true)
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


-----------------------------
--      Slash Handler      --
-----------------------------

SLASH_TEKERR1 = "/err"
SLASH_TEKERR2 = "/tekerr"
function SlashCmdList.TEKERR() ShowUIPanel(panel) end


----------------------------------------
--      Quicklaunch registration      --
----------------------------------------

local ldb = LibStub and LibStub:GetLibrary("LibDataBroker-1.1", true)
if ldb then
	ldb:NewDataObject("tekErr", {
		type = "launcher",
		icon = "Interface\\Icons\\Ability_Creature_Cursed_04",
		OnClick = SlashCmdList.TEKERR,
	})
end
