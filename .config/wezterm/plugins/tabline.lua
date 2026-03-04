local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local module = {}

local function leader(window)
	local icon
	if window:leader_is_active() then
		icon = wezterm.nerdfonts.md_alpha_w_circle_outline
	else
		icon = wezterm.nerdfonts.md_alpha_w_circle
	end

	return " " .. icon .. " "
end

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

function module.apply_to_config(config)
	local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]

	tabline.setup({
		options = {
			icons_enabled = true,
			theme = config.color_scheme,
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
				leader,
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
				{ "index", padding = 1 },
				pane_info,
				{
					"process",
					icons_only = true,
					padding = 0,
				},
				-- { "parent", max_length = 15, padding = 0 },
				-- "/",
				{ "cwd", max_length = 20, padding = { left = 0, right = 1 } },
			},
			tab_inactive = {
				"index",
				{
					"process",
					icons_only = true,
					padding = 0,
				},
				{ "cwd", max_length = 20, padding = { left = 0, right = 1 } },
			},
			tabline_x = { "ram", "cpu" },
			tabline_y = {},
			tabline_z = { "domain" },
		},
		extensions = {},
	})
	tabline.apply_to_config(config)
end

return module
