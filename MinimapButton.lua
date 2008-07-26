
local OptionHouse = LibStub("OptionHouse-1.1")

function tekErrMinimapButton()
	local frame = CreateFrame("Button", nil, Minimap)
	--~ 	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	frame:SetWidth(31)
	frame:SetHeight(31)
	frame:SetFrameStrata("LOW")
	--~ frame:SetToplevel(1)
	frame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	frame:SetPoint("RIGHT", Minimap, "LEFT")

	local icon = frame:CreateTexture(nil, "BACKGROUND")
	icon:SetTexture("Interface\\Icons\\INV_Elemental_Primal_Fire")
	--~ 	icon:SetWidth(20)
	--~ 	icon:SetHeight(20)
	--~ 	icon:SetPoint("TOPLEFT", 7, -5)
	--~ 	icon:SetPoint("BOTTOMRIGHT", 4, 6)
	icon:SetPoint("TOPLEFT", 6, -6)
	icon:SetPoint("BOTTOMRIGHT", -6, 6)

	local overlay = frame:CreateTexture(nil, "OVERLAY")
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	overlay:SetWidth(53)
	overlay:SetHeight(53)
	overlay:SetPoint("TOPLEFT")

	frame:RegisterForClicks("AnyUp")

	frame:SetScript("OnMouseDown", function(self) icon:SetTexCoord(.1,.9,.1,.9) end)
	frame:SetScript("OnMouseUp", function(self)
		icon:SetTexCoord(0,1,0,1)
		OptionHouse:Open("tekErr", "Errors")
	end)

	frame:SetScript("OnEnter", function(self)
--~ 		GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
		GameTooltip:SetOwner(self, "BOTTOMRIGHT")
		GameTooltip:AddLine("tekErr")
		GameTooltip:AddLine("You have new script errors!",.8,.8,.8,1)
		GameTooltip:Show()
	end)
	frame:SetScript("OnLeave", function() GameTooltip:Hide() end)

	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		icon:SetTexCoord(0,1,0,1)
	end)

	local el = 0
	local BLINKRATE = 1
	frame:SetScript("OnUpdate", function(self, elapsed)
		local alpha = (el <= BLINKRATE) and el or (BLINKRATE*2)-el
		frame:SetAlpha(alpha/BLINKRATE)
		el = el + elapsed
		if el >= (BLINKRATE*2) then el = 0 end
	end)
	frame:SetScript("OnShow", function(self)
		self:SetAlpha(0)
		el = 0
	end)

	frame:Hide()

	return frame
end
