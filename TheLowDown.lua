


local frame, handlers, running = CreateFrame("Frame"), {}, {}
frame.name = "tekErr-TheLowDown"
frame:Hide()


frame:SetScript("OnUpdate", function (frame, elapsed)
	for name,v in pairs(handlers) do
		if running[name] then
			v.elapsed = v.elapsed + elapsed
			if v.elapsed >= v.rate then
				v.func()
				v.elapsed = 0
			end
		end
	end
end)


local function Register(name, func, rate)
	handlers[name] = {
		name = name,
		func = func,
		rate = rate or 0,
	}
end


local function Start(name)
	handlers[name].elapsed = 0
	running[name] = true
	frame:Show()
end


local function Stop(name)
	running[name] = nil
	if not next(running) then frame:Hide() end
end

-------------------


function TheLowDownRegisterFrame(frame)
	local scrolldown = frame.ScrollDown
	local scrollframe = frame

	Register("DownTick", function()
		if scrollframe:AtBottom() then Stop("DownTick")
		else scrolldown(scrollframe) end
	end, 0.1)

	Register("DownTimeout", function()
		Stop("DownTimeout")
		Start("DownTick")
	end, 20)

	for _,func in ipairs{"ScrollUp", "ScrollDown", "ScrollToTop", "PageUp", "PageDown"} do
		local orig = frame[func]
		frame[func] = function(...)
			Stop("DownTick")
			Start("DownTimeout", 1)
			orig(...)
		end
	end
end


