local wezterm = require("wezterm") ---@type Wezterm
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez") ---@type TablineWez
local module = {}

function module.apply_to_config(config)
	local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]

	tabline.setup({
		options = {
			icons_enabled = true,
			theme = config.color_scheme,
			theme_overrides = {
				normal_mode = {
					a = { fg = scheme.ansi[1], bg = scheme.ansi[6] },
					b = { fg = scheme.foreground, bg = scheme.background },
					c = { fg = scheme.foreground, bg = scheme.background },
					x = { fg = scheme.foreground, bg = scheme.background },
					y = { fg = scheme.ansi[6], bg = scheme.ansi[0] },
					z = { fg = scheme.ansi[1], bg = scheme.ansi[6] },
				},
			},
			section_separators = {
				left = wezterm.nerdfonts.ple_upper_left_triangle,
				right = wezterm.nerdfonts.ple_upper_right_triangle,
			},
		},
		sections = {
			tabline_a = {
				" " .. wezterm.nerdfonts.md_alpha_w_circle .. " ",
				{
					"mode",
				},
			},
			tabline_b = { "workspace" },
			tabline_c = { "" },
			tab_active = {},
			tab_inactive = {},
			tabline_x = { "ram", "cpu" },
			tabline_y = { "datetime", "battery" },
			tabline_z = { "domain" },
		},
		extensions = {},
	})
	tabline.apply_to_config(config)
end

return module
