local wezterm = require("wezterm")
local act = wezterm.action

-- local func = require("functions")

return {
	-- tmux-like keybindings
	keys = {
		{ key = "w", mods = "LEADER", action = act.ShowTabNavigator },

		{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
		{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
		{ key = "q", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

		-- Pane作成
		{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- MovePane (ctrl + hjkl)
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },

		-- Pane Zoom
		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

		-- CopyMode
		{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },

		-- Active resize keytable
		{ key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_mode", one_shot = false }) },
	},
	key_tables = {
		resize_mode = {
			{ key = "h",      action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "l",      action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "k",      action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "j",      action = act.AdjustPaneSize({ "Down", 1 }) },

			{ key = "Enter",  action = "PopKeyTable" },
			{ key = "Escape", action = "PopKeyTable" },
		},
	},
}
