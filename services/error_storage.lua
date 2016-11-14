
local myname, ns = ...


local LIMIT = 1000
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

	if index == LIMIT then
		ns.SendMessage("_NEW_MESSAGE", "|cffff4040 ERROR LIMIT REACHED|r")
		ns.RegisterCallback(self, "_ERROR_RECEIVED")
	end

	index = index + 1
	indexes[stacktrace] = index
	counts[index] = (counts[index] or 0) + 1
	messages[index] = msg
	stacks[index] = stacktrace
	locals[index] = debuglocals
	ns.SendMessage("_NEW_MESSAGE", LINKSTR:format(date("%X"), index, msg))
end


local function OnHyperlinkClick(self, event, link)
	local _, _, index = string.find(link, "tekerr:(.+)")
	index = tonumber(index)
	local stack = stacks[index] or "<none>"
	local debuglocal = locals[index] or "<none>"
	local msg = OUTPUT:format(messages[index], stack, counts[index], debuglocal)
	ns.SendMessage("_DISPLAY_ERROR", msg)
end


ns.RegisterCallback("_ERROR_RECEIVED", OnErrorReceived)
ns.RegisterCallback("_HYPERLINK_CLICKED", OnHyperlinkClick)
