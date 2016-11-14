
local myname, ns = ...


local function OnDisplayError(self, event, message)
	self:SetText(message)
end


local function OnEditFocusLost(self)
	self:SetText("")
end


local function OnTextSet(self)
	if self:GetText() == "" then
		self:SetHeight(25)
	else
		self:SetHeight(250)
		self:SetFocus()
		self:HighlightText()
	end
end


function ns.CreateEditbox(parent)
	local editbox = CreateFrame("EditBox", nil, parent)

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

	editbox:SetScript("OnTextSet", OnTextSet)
	editbox:SetScript("OnEditFocusLost", OnEditFocusLost)
	editbox:SetScript("OnEscapePressed", editbox.ClearFocus)

	ns.RegisterCallback(editbox, "_DISPLAY_ERROR", OnDisplayError)

	return editbox
end
