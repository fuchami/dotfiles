-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- theme
config.color_scheme = "iceberg-dark"

-- Window
config.initial_cols = 160
config.initial_rows = 50

config.text_background_opacity = 0.75
config.window_background_opacity = 0.65
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "TITLE"
config.macos_window_background_blur = 5

-- Font settings
config.font = wezterm.font_with_fallback({
	"HackGen35 Console NF",
	"Menlo",
	"Monaco",
})

config.font_size = 16

-- IME settings
config.use_ime = true

-- buffer
config.scrollback_lines = 5000000

-- Enable hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- tmux-like keybindings
local act = wezterm.action
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
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
}

-- Plugin: Tabline configuration
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
	options = {
		theme = "catppuccin-mocha",
		section_separators = {
			left = wezterm.nerdfonts.ple_upper_left_triangle,
			right = wezterm.nerdfonts.ple_upper_right_triangle,
		},
		component_separators = {
			left = wezterm.nerdfonts.ple_forwardslash_separator,
			right = wezterm.nerdfonts.ple_forwardslash_separator,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_lower_left_triangle,
			right = wezterm.nerdfonts.ple_lower_right_triangle,
		},
	},
	sections = {
		tabline_a = { " 󰰮 " },
		tabline_b = { "mode" },
		tabline_c = {},
		tab_active = {
			{ "index", padding = 0 },
			{
				"process",
				icons_only = true,
				padding = { left = 1, right = 0 },
			},
			{ "parent", max_length = 15, padding = { left = 0, right = 0 } },
			"/",
			{ "cwd", max_length = 30, padding = { left = 0, right = 2 } },
		},
		tab_inactive = {
			{ "index", padding = 0 },
			{
				"process",
				icons_only = true,
				padding = { left = 1, right = 1 },
			},
			{ "parent", max_length = 10, padding = { left = 0, right = 0 } },
			"/",
			{ "cwd", max_length = 50, padding = { left = 0, right = 1 } },
		},
	},
	extensions = {
		"resurrect",
	},
})
tabline.apply_to_config(config)

return config
