
local myname, ns = ...


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

	editbox:SetScript("OnTextSet", function(self)
		if self:GetText() == "" then
			editbox:SetHeight(25)
		else
			editbox:SetHeight(250)
			editbox:SetFocus()
			editbox:HighlightText()
		end
	end)
	editbox:SetScript("OnEscapePressed", editbox.ClearFocus)
	editbox:SetScript("OnEditFocusLost", function(editbox) editbox:SetText("") end)

	return editbox
end
