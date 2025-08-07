-- To change config file location by executing the following command in Termina
-- $ defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

hs.hotkey.bind({ "option" }, "space", function()
  local appName = "WezTerm"
  local app = hs.application.get(appName)

  if app == nil or app:isHidden() then
    hs.application.launchOrFocus(appName)
  else
    app:hide()
  end
end)
