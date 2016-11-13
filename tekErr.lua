
local myname, ns = ...


local linkstr = "|cffff4040[%s] |Htekerr:%s|h%s|h|r"


local function OnLoad()
	local panel = ns.tekPanelAuction("tekErrPanel", "tekErr")

	local editbox = ns.CreateEditbox(panel)
	editbox:SetPoint("TOPLEFT", 25, -75)
	editbox:SetPoint("BOTTOMRIGHT", panel, "TOPRIGHT", -15, -100)

	local messages = ns.CreateMessageFrame(panel)
	messages:SetPoint("BOTTOMRIGHT", -15, 40)
	messages:SetPoint("TOPLEFT", editbox, "BOTTOMLEFT")

	messages:SetScript("OnShow", function() ns.SendMessage("_PANEL_OPENED") end)


	ns.RegisterCallback(panel, "_SHOW_PANEL", ShowUIPanel)


	messages:SetScript("OnHyperlinkClick", function(self, link, text)
		local _, _, msg = string.find(link, "tekerr:(.+)")
		editbox:SetText(text.. "\n".. msg)
	end)


	for i,v in pairs(ns) do
		if i:match("^Create") then ns[i] = nil end
	end
end


ns.RegisterCallback("_THIS_ADDON_LOADED", OnLoad)
