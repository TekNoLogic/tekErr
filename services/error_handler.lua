
local myname, ns = ...


seterrorhandler(function(msg)
	local _, _, stacktrace = string.find(debugstack() or "", "[^\n]+\n(.*)")
	ns.SendMessage("_ERROR_RECEIVED", msg, stacktrace)
end)
