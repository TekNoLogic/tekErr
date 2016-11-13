
-- This module manages offical client events like "UNIT_AURA" as well as custom
-- intra-addon messages.  Special handling of savedvariables happens on load and
-- player logout, along with some custom messages to signal when certain data
-- has been initialized.

-- Login event order is as follows:
-- * Addon code is loaded
-- * Savedvars are initialized if `ns.dbname` or `ns.dbpcname` have been set
-- * "_THIS_ADDON_LOADED" message is sent
-- * "ADDON_LOADED" event triggered by this addon is dispatched to callbacks
-- * "PLAYER_LOGIN" event is fired by the system if loaded on login, otherwise
--   one is generated if we were loaded on demand

-- Logout event order is as follows:
-- * Default values are erased from savedvars if `ns.dbdefaults` or
--   `ns.dbpcdefaults` are defined
-- * "PLAYER_LOGOUT" event is dispatched to callbacks


local myname, ns = ...


local NOOP = function() end


local callbacks = {}
local frame = CreateFrame("Frame")
function ns.RegisterCallback(context, message, func)
	-- Allow context-less calls like ns.RegisterCallback("PLAYER_LOGIN", OnLogin)
	if type(context) == "string" and type(message) == "function" then
		context, message, func = message, context, message
	end

	assert(context, "`context` must not be nil")
	assert(message, "`message` must not be nil")
	if not callbacks[message] then callbacks[message] = {} end
	callbacks[message][context] = func

	if next(callbacks[message]) then
		frame:RegisterEvent(message)
	else
		frame:UnregisterEvent(message)
	end
end


function ns.UnregisterCallback(context, message)
	ns.RegisterCallback(context, message, nil)
end


local method, context_arg, message_arg
local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50
local function call()
	method(context_arg, message_arg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50)
end


local function errorhandler(err)
	return geterrorhandler()(err)
end


function ns.SendMessage(message, ...)
	assert(message, "`message` must not be nil")
	assert(select("#", ...) <= 50, "Too many args!")
	if not callbacks[message] then return end

	for context,func in pairs(callbacks[message]) do
		local old_arg1, old_arg2, old_arg3, old_arg4, old_arg5, old_arg6, old_arg7, old_arg8, old_arg9, old_arg10, old_arg11, old_arg12, old_arg13, old_arg14, old_arg15, old_arg16, old_arg17, old_arg18, old_arg19, old_arg20, old_arg21, old_arg22, old_arg23, old_arg24, old_arg25, old_arg26, old_arg27, old_arg28, old_arg29, old_arg30, old_arg31, old_arg32, old_arg33, old_arg34, old_arg35, old_arg36, old_arg37, old_arg38, old_arg39, old_arg40, old_arg41, old_arg42, old_arg43, old_arg44, old_arg45, old_arg46, old_arg47, old_arg48, old_arg49, old_arg50 = arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50
		arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50 = ...

		local old_method, old_context_arg, old_message_arg = method, context_arg, message_arg
		method, context_arg, message_arg = func, context, message

		xpcall(call, errorhandler)

		method, context_arg, message_arg = old_method, old_context_arg, old_message_arg
		arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38, arg39, arg40, arg41, arg42, arg43, arg44, arg45, arg46, arg47, arg48, arg49, arg50 = old_arg1, old_arg2, old_arg3, old_arg4, old_arg5, old_arg6, old_arg7, old_arg8, old_arg9, old_arg10, old_arg11, old_arg12, old_arg13, old_arg14, old_arg15, old_arg16, old_arg17, old_arg18, old_arg19, old_arg20, old_arg21, old_arg22, old_arg23, old_arg24, old_arg25, old_arg26, old_arg27, old_arg28, old_arg29, old_arg30, old_arg31, old_arg32, old_arg33, old_arg34, old_arg35, old_arg36, old_arg37, old_arg38, old_arg39, old_arg40, old_arg41, old_arg42, old_arg43, old_arg44, old_arg45, old_arg46, old_arg47, old_arg48, old_arg49, old_arg50
	end
end


local function ProcessOnLoad(arg1)
	if arg1 ~= myname then return end

	if ns.dbname then
		local defaults = ns.dbdefaults or {}
		_G[ns.dbname] = setmetatable(_G[ns.dbname] or {}, {__index = defaults})
		ns.db = _G[ns.dbname]
	end

	if ns.dbpcname then
		local defaults = ns.dbpcdefaults or {}
		_G[ns.dbpcname] = setmetatable(_G[ns.dbpcname] or {}, {__index = defaults})
		ns.dbpc = _G[ns.dbpcname]
	end

	ns.SendMessage("_THIS_ADDON_LOADED")
	callbacks["_THIS_ADDON_LOADED"] = nil

	ProcessOnLoad = nil
	ns.UnregisterCallback(frame, "ADDON_LOADED")

	if ns.dbdefaults or ns.dbpcdefaults then
		ns.RegisterCallback(frame, "PLAYER_LOGOUT", NOOP)
	end
end


local function ProcessLogout()
	if ns.dbdefaults then
		for i,v in pairs(ns.dbdefaults) do
			if ns.db[i] == v then ns.db[i] = nil end
		end
	end

	if ns.dbpcdefaults then
		for i,v in pairs(ns.dbpcdefaults) do
			if ns.dbpc[i] == v then ns.dbpc[i] = nil end
		end
	end
end


frame:SetScript("OnEvent", function(self, event, arg1, ...)
	if ProcessOnLoad and event == "ADDON_LOADED" then ProcessOnLoad(arg1) end
	if event == "PLAYER_LOGOUT" then ProcessLogout() end

	ns.SendMessage(event, arg1, ...)

	-- If we were loaded on demand, make sure a "PLAYER_LOGIN" message is sent
	if event == "ADDON_LOADED" and arg1 == myname and IsLoggedIn() then
		ns.SendMessage("PLAYER_LOGIN")
		callbacks["PLAYER_LOGIN"] = nil
	end

	-- We don't need to hold on to these callbacks once the event has fired
	if event == "PLAYER_LOGIN" then callbacks["PLAYER_LOGIN"] = nil end
end)


ns.RegisterCallback(frame, "ADDON_LOADED", NOOP)
