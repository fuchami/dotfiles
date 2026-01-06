local wezterm = require("wezterm")

return {
	options = {
		theme = "catppuccin-mocha",
		theme_overrides = {
			tab = {},
		},
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
			{ "cwd", max_length = 50, padding = { left = 0, right = 1 } },
		},
	},
	extensions = {
		"resurrect",
	},
}
