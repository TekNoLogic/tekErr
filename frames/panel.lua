
local myname, ns = ...


local function OnLoad()
	local panel = ns.CreateDoublewidePanel()
	panel:SetTitle("tekErr")

	local editbox = ns.CreateEditbox(panel)
	editbox:SetHeight(25)
	editbox:SetPoint("TOPLEFT", 25, -75)
	editbox:SetPoint("RIGHT", -15, 0)

	local messages = ns.CreateMessageFrame(panel)
	messages:SetPoint("BOTTOMRIGHT", -15, 40)
	messages:SetPoint("TOPLEFT", editbox, "BOTTOMLEFT")

	-- f:SetScript("OnEvent", function(self, ...) self:AddMessage(string.join(", ", ...), 0.0, 1.0, 1.0) end)
	-- f:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	-- f:RegisterEvent("ADDON_ACTION_BLOCKED")  -- We usually don't care about these, as they aren't fatal


	ns.RegisterCallback(panel, "_SHOW_PANEL", ShowUIPanel)
end


ns.RegisterCallback("_THIS_ADDON_LOADED", OnLoad)
