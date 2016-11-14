
local myname, ns = ...


local LINKSTR = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"
local OUTPUT = "Message: %s\n\nStack:\n%s\nCount: %s\n\nLocals:\n%s"

local counts = {}
local index = 0
local indexes = {}
local locals = {}
local messages = {}
local stacks = {}
local function OnErrorReceived(self, event, msg, stacktrace, debuglocals)
	if indexes[stacktrace] then return end

	index = index + 1
	indexes[stacktrace] = index
	counts[index] = (counts[index] or 0) + 1
	messages[index] = msg
	stacks[index] = stacktrace
	locals[index] = debuglocals
	self:AddMessage(LINKSTR:format(date("%X"), index, msg))
	if not self:IsVisible() then ns.SendMessage("_NEW_ERROR") end
end


local function OnHyperlinkClick(self, link, text)
	local _, _, index = string.find(link, "tekerr:(.+)")
	index = tonumber(index)
	local stack = stacks[index] or "<none>"
	local debuglocal = locals[index] or "<none>"
	local msg = OUTPUT:format(messages[index], stack, counts[index], debuglocal)
	ns.SendMessage("_HYPERLINK_CLICKED", msg)
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

	ns.RegisterCallback(frame, "_ERROR_RECEIVED", OnErrorReceived)

	ns.RegisterScrollReset(frame)
	ns.RegisterScrollReset = nil

	return frame
end
