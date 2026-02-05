-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.use_ime = true

-- theme
-- local color_scheme = "kanagawabones"
local color_scheme = "Kanagawa (Gogh)"
config.color_scheme = color_scheme

-- Window
config.initial_cols = 160
config.initial_rows = 50

config.macos_window_background_blur = 2
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "TITLE"

wezterm.on("toggle-opacity", function(window, _)
	local overrides = window:get_config_overrides() or {}

	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.75
		overrides.text_background_opacity = 0.7
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
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

-- tabline plugin
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local tabline_config = require("tabline")
tabline.setup(tabline_config.create_config(color_scheme))
tabline.apply_to_config(config)

-- smart-splits plugin
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	modifiers = {
		resize = "META|CTRL",
	},
})

return config
