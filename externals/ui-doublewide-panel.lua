
local myname, ns = ...


--[[
Creates a frame using the Auction House textures.

Make sure you use ShowUIPanel(...) to show your frame, this ensures it is
positioned by the game's engine, and closes with the ESC key.
]]
function ns.CreateDoublewidePanel()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:SetToplevel(true)
	frame:SetFrameLevel(100) -- Force frame to a high level so it shows on top the first time it's displayed
	frame:SetSize(832, 447)
	frame:SetPoint("TOPLEFT", 0, -104)
	frame:EnableMouse(true) -- To avoid click-thru

	frame:Hide()

	frame:SetAttribute("UIPanelLayout-defined", true)
	frame:SetAttribute("UIPanelLayout-enabled", true)
	frame:SetAttribute("UIPanelLayout-area", "doublewide")
	frame:SetAttribute("UIPanelLayout-whileDead", true)


	local portrait_frame = CreateFrame("Frame", nil, frame)
	portrait_frame:SetSize(57, 57)
	portrait_frame:SetPoint("TOPLEFT", 9, -7)

	local portrait = portrait_frame:CreateTexture(nil, "OVERLAY")
	portrait:SetAllPoints()
	SetPortraitTexture(portrait, "player")

	portrait_frame:SetScript("OnEvent", function(self, event, unit)
		if unit == "player" then SetPortraitTexture(portrait, "player") end
	end)
	portrait_frame:RegisterEvent("UNIT_PORTRAIT_UPDATE")


	local title = frame:CreateFontString(nil, "OVERLAY")
	title:SetFontObject(GameFontNormal)
	title:SetPoint("TOP", 0, -18)

	function frame:SetTitle(text) title:SetText(text) end


	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", 3, -8)
	close:SetScript("OnClick", function() HideUIPanel(frame) end)


	local topleft = frame:CreateTexture(nil, "ARTWORK")
	topleft:SetSize(256, 256)
	topleft:SetPoint("TOPLEFT", 0, 0)
	topleft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopLeft")

	local top = frame:CreateTexture(nil, "ARTWORK")
	top:SetSize(320, 256)
	top:SetPoint("TOPLEFT", 256, 0)
	top:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Top")

	local topright = frame:CreateTexture(nil, "ARTWORK")
	topright:SetSize(256, 256)
	topright:SetPoint("TOPLEFT", top, "TOPRIGHT")
	topright:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopRight")

	local bottomleft = frame:CreateTexture(nil, "ARTWORK")
	bottomleft:SetSize(256, 256)
	bottomleft:SetPoint("TOPLEFT", 0, -256)
	bottomleft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotLeft")

	local bottom = frame:CreateTexture(nil, "ARTWORK")
	bottom:SetSize(320, 256)
	bottom:SetPoint("TOPLEFT", 256, -256)
	bottom:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Bot")

	local bottomright = frame:CreateTexture(nil, "ARTWORK")
	bottomright:SetSize(256, 256)
	bottomright:SetPoint("TOPLEFT", bottom, "TOPRIGHT")
	bottomright:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight")

	return frame
end
