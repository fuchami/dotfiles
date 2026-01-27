local wezterm = require("wezterm")

return {
	options = {
		icons_enabled = true,
		theme = "catppuccin-mocha",
		theme_overrides = {
			tab = {
				active = { fg = "#111111", bg = "#c4a000" },
			},
			resize_mode = {
				a = { fg = "#181825", bg = "#fab387" },
				b = { fg = "#cba6f7", bg = "#313244" },
				c = { fg = "#cdd6f4", bg = "#181825" },
			},
		},
		section_separators = {
			-- left = wezterm.nerdfonts.ple_upper_left_triangle,
			-- right = wezterm.nerdfonts.ple_upper_right_triangle,
			left = "",
			right = "",
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_left_soft_divider,
		},
		tab_separators = {
			-- left = wezterm.nerdfonts.ple_lower_left_triangle,
			-- right = wezterm.nerdfonts.ple_lower_right_triangle,
			left = "",
			right = "",
		},
	},
	sections = {
		tabline_a = {
			" 󰰮 ",
			{
				"mode",
				icons_enabled = true,
				fmt = function(mode, window)
					if window:leader_is_active() then
						return "LEADER"
					end

					local name = window:active_key_table()
					if name then
						return name:gsub("_mode", ""):upper()
					end

					return mode
				end,
			},
		},
		tabline_b = {},
		tabline_c = {},
		tab_active = {
			{ "index",  padding = 1 },
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
