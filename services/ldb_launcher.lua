
local myname, ns = ...


local ldb = LibStub and LibStub:GetLibrary("LibDataBroker-1.1", true)
if not ldb then return end

ldb:NewDataObject("tekErr", {
	type = "launcher",
	icon = "Interface\\Icons\\Ability_Creature_Cursed_04",
	OnClick = function() ns.SendMessage("_SHOW_PANEL") end,
})
