
local myname, ns = ...


seterrorhandler(function(msg)
	ns.SendMessage("_ERROR_RECEIVED", msg, debugstack(4), debuglocals(4))
end)
