local wezterm = require("wezterm")

local function pane_info(tab)
	local mux_tab = wezterm.mux.get_tab(tab.tab_id)
	local panes = mux_tab:panes()
	local active_pane = mux_tab:active_pane()
	local total_panes = #panes

	if total_panes == 1 then
		return " "
	end

	local active_index = 1
	for i, pane in ipairs(panes) do
		if pane:pane_id() == active_pane:pane_id() then
			active_index = i
			break
		end
	end

	return string.format("[%d/%d] ", active_index, total_panes)
end

local M = {}

function M.create_config(color_scheme)
	local scheme = wezterm.color.get_builtin_schemes()[color_scheme]

	return {
		options = {
			icons_enabled = true,
			theme = color_scheme,
			theme_overrides = {
				tab = {
					active = { fg = scheme.ansi[1], bg = scheme.ansi[6] },
				},
				resize_mode = {
					a = { fg = scheme.ansi[1], bg = scheme.ansi[7] },
					b = { fg = scheme.foreground, bg = scheme.background },
					c = { fg = scheme.foreground, bg = scheme.background },
				},
			},
			section_separators = {
				left = wezterm.nerdfonts.ple_upper_left_triangle,
				right = wezterm.nerdfonts.ple_upper_right_triangle,
			},
			component_separators = {
				left = wezterm.nerdfonts.pl_left_soft_divider,
				right = wezterm.nerdfonts.pl_left_soft_divider,
			},
			tab_separators = {
				left = wezterm.nerdfonts.ple_upper_left_triangle,
				right = wezterm.nerdfonts.ple_lower_right_triangle,
			},
		},
		sections = {
			tabline_a = {
				" " .. wezterm.nerdfonts.md_alpha_w_circle .. " ",
				{
					"mode",
					icons_enabled = true,
					fmt = function(mode, window)
						if window:leader_is_active() then
							return "LEADER"
						end

						if mode == "COPY" then
							return " COPY "
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
				pane_info,
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
			tabline_z = { "domain" },
		},
		extensions = {},
	}
end

return M
