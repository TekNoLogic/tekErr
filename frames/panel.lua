
local myname, ns = ...


local linkstr = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"


local function OnLoad()
	local panel = ns.tekPanelAuction("tekErrPanel", "tekErr")

	local editbox = ns.CreateEditbox(panel)
	editbox:SetHeight(25)
	editbox:SetPoint("TOPLEFT", 25, -75)
	editbox:SetPoint("RIGHT", -15, 0)

	local messages = ns.CreateMessageFrame(panel)
	messages:SetPoint("BOTTOMRIGHT", -15, 40)
	messages:SetPoint("TOPLEFT", editbox, "BOTTOMLEFT")

	messages:SetScript("OnShow", function() ns.SendMessage("_PANEL_OPENED") end)
	-- f:SetScript("OnEvent", function(self, ...) self:AddMessage(string.join(", ", ...), 0.0, 1.0, 1.0) end)
	-- f:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	--~ f:RegisterEvent("ADDON_ACTION_BLOCKED")  -- We usually don't care about these, as they aren't fatal


	ns.RegisterCallback(panel, "_SHOW_PANEL", ShowUIPanel)


	messages:SetScript("OnHyperlinkClick", function(self, link, text)
		local _, _, msg = string.find(link, "tekerr:(.+)")
		editbox:SetText(text.. "\n".. msg)
	end)
end


ns.RegisterCallback("_THIS_ADDON_LOADED", OnLoad)
