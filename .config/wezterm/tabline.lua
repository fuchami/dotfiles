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
		tabline_a = { " 󰰮 ", "mode" },
		tabline_b = { "workspace" },
		tabline_c = {},
		tab_active = {
			"index",
			{
				"process",
				icons_only = true,
				padding = { left = 1, right = 0 },
			},
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			max_length = 15,
		},
		tab_inactive = {
			"index",
			{
				"process",
				icons_only = true,
				padding = 0,
			},
			{ "cwd", padding = { left = 0, right = 1 } },
			max_length = 10,
		},
	},
	extensions = {
		"resurrect",
	},
}
