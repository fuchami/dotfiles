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

config.text_background_opacity = 0.8
config.window_background_opacity = 0.8
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_decorations = "TITLE"
config.macos_window_background_blur = 10

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

-- keybinds
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

-- tabline
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local tabline_config = require("tabline")
tabline.setup(tabline_config)
tabline.apply_to_config(config)

return config
