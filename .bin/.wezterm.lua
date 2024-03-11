local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

return {
	color_scheme = "iceberg-dark",

	-- window
	window_background_opacity = 0.8,
	text_background_opacity = 0.5,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,

	-- font
	font = wezterm.font("MesloLGS NF"),
	font_size = 14,

	-- ime
	use_ime = true,

	-- tmux like keybindings
	leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 },
	keys = {
		{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "q", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
		{ key = "w", mods = "LEADER", action = act.ShowTabNavigator },

		{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "H", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 10 }) },
		{ key = "L", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 10 }) },
		{ key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	},
}
