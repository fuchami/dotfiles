local wezterm = require("wezterm")
local act = wezterm.action

-- Use a table-style configuration for clarity and conciseness
local config = {
	automatically_reload_config = true,

	-- Appearance
	color_scheme = "iceberg-dark",
	window_background_opacity = 0.75,
	text_background_opacity = 0.75,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_decorations = "RESIZE",
	show_new_tab_button_in_tab_bar = false,
	initial_cols = 150,
	initial_rows = 40,

	-- Font settings
	font = wezterm.font("MesloLGS NF", { weight = "Regular", stretch = "Normal" }),
	font_size = 14,

	-- IME settings
	use_ime = true,

	-- tmux-like keybindings
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

-- Plugin: Tabline configuration
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup()
tabline.apply_to_config(config)

return config
