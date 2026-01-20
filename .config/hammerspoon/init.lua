-- To change config file location by executing the following command in Termina
-- $ defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

hs.hotkey.bind({ "option" }, "space", function()
	local appName = "WezTerm"
	local app = hs.application.get(appName)

	if app == nil or app:isHidden() then
		hs.application.launchOrFocus(appName)

	-- resize & centering
	-- win = app:mainWindow()
	-- local screen = hs.mouse.getCurrentScreen()
	-- local max = screen:frame()
	--
	-- local width = max.w * 0.9
	-- local height = max.h * 0.9
	--
	-- local x = max.x + (max.w - width) / 2
	-- local y = max.y + (max.h - height) / 2
	--
	-- win:setFrame({ x = x, y = y, w = width, h = height }, 0.05)
	else
		app:hide()
	end
end)
