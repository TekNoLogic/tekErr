
local myname, ns = ...


local icons = {}
local function SetIcon(self, texture)
	icons[self]:SetTexture(texture)
end


local function OnMouseDown(self)
	icons[self]:SetTexCoord(.1,.9,.1,.9)
end


local function OnMouseUp(self)
	icons[self]:SetTexCoord(0,1,0,1)
end


function ns.CreateMinimapButton()
	local butt = CreateFrame("Button", nil, Minimap)
	butt:SetWidth(31)
	butt:SetHeight(31)
	butt:SetFrameStrata("LOW")
	butt:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
	butt:SetPoint("RIGHT", Minimap, "LEFT")

	local icon = butt:CreateTexture(nil, "BACKGROUND")
	icon:SetPoint("TOPLEFT", 6, -6)
	icon:SetPoint("BOTTOMRIGHT", -6, 6)

	local overlay = butt:CreateTexture(nil, "OVERLAY")
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	overlay:SetWidth(53)
	overlay:SetHeight(53)
	overlay:SetPoint("TOPLEFT")

	icons[butt] = icon

	butt.SetIcon = SetIcon

	butt:RegisterForClicks("AnyUp")

	butt:SetScript("OnMouseDown", OnMouseDown)
	butt:SetScript("OnMouseUp", OnMouseUp)

	return butt
end
