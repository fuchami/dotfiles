-- Pull in the wezterm API
local wezterm = require("wezterm") ---@type Wezterm

-- This will hold the configuration.
local config = wezterm.config_builder() ---@type Config
config.automatically_reload_config = true
config.use_ime = true
config.term = "wezterm"

-- color theme
config.color_scheme = "Kanagawa (Gogh)"

-- Window
config.initial_cols = 160
config.initial_rows = 50

config.macos_window_background_blur = 5
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "TITLE"

wezterm.on("toggle-opacity", function(window, _)
	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.9
		-- overrides.text_background_opacity = 0.8
	else
		overrides.window_background_opacity = nil
		overrides.text_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

-- Font settings
config.font_size = 16
config.font = wezterm.font_with_fallback({
	"HackGen35 Console NF",
	"Menlo",
	"Monaco",
})

-- buffer
config.scrollback_lines = 100000

-- Enable hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- keybinds
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
require("keybinds").apply_to_config(config)

-- plugins
require("plugins.tabline").apply_to_config(config)
require("plugins.smart_splits").apply_to_config(config)

return config
