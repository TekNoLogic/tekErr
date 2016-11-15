
local myname, ns = ...


local frame = ns.CreateMinimapButton()
frame:SetIcon("Interface\\Icons\\INV_Elemental_Primal_Fire")

frame:SetScript("OnClick", function(self) ns.SendMessage("_SHOW_PANEL") end)
frame:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "BOTTOMRIGHT")
	GameTooltip:AddLine("tekErr")
	GameTooltip:AddLine("You have new script errors!",.8,.8,.8,1)
	GameTooltip:Show()
end)
frame:SetScript("OnLeave", function() GameTooltip:Hide() end)

local el = 0
local BLINKRATE = 1
frame:SetScript("OnUpdate", function(self, elapsed)
	local alpha = (el <= BLINKRATE) and el or (BLINKRATE*2)-el
	self:SetAlpha(alpha/BLINKRATE)
	el = el + elapsed
	if el >= (BLINKRATE*2) then el = 0 end
end)
frame:SetScript("OnShow", function(self)
	self:SetAlpha(0)
	el = 0
end)

frame:Hide()


ns.RegisterCallback(frame, "_NEW_MESSAGE", frame.Show)
ns.RegisterCallback(frame, "_PANEL_OPENED", frame.Hide)
