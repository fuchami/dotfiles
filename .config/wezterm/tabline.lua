local wezterm = require("wezterm")

return {
	options = {
		icons_enabled = true,
		theme = "catppuccin-mocha",
		theme_overrides = {
			tab = {
				-- active = { fg = "#181818", bg = "#9F7AEA" },
			},
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
			{ "index", padding = 1 },
			{
				"process",
				icons_only = true,
				padding = 0,
			},
			{ "parent", max_length = 15, padding = 0 },
			"/",
			{ "cwd", max_length = 30, padding = { left = 0, right = 1 } },
		},
		tab_inactive = {
			"index",
			{
				"process",
				icons_only = true,
				padding = 0,
			},
			{ "cwd", max_length = 30, padding = { left = 0, right = 1 } },
		},
		tabline_x = { "ram", "cpu" },
		tabline_y = {},
	},
	extensions = {
		"resurrect",
	},
}
