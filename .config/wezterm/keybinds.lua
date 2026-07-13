local wezterm = require("wezterm") ---@type Wezterm
local act = wezterm.action

local module = {}

-- tmux-like keybindings
local keys = {
	-- { key = "w", mods = "LEADER", action = act.ShowTabNavigator },
	--
	-- { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	-- { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	-- { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	-- { key = "q", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	-- { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	-- Pane作成
	-- { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- MovePane (ctrl + hjkl)
	-- { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	-- { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	-- { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	-- { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },

	-- Pane Zoom
	-- { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- CopyMode
	-- { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

	-- Active resize keytable
	-- { key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_mode", one_shot = false }) },

	-- Toggle opacity
	-- { key = "o", mods = "LEADER", action = wezterm.action.EmitEvent("toggle-opacity") },

	-- QuickSelect
	{ key = " ", mods = "LEADER", action = act.QuickSelect },
}

-- local key_tables = {
-- 	resize_mode = {
-- 		{ key = "h",      action = act.AdjustPaneSize({ "Left", 2 }) },
-- 		{ key = "l",      action = act.AdjustPaneSize({ "Right", 2 }) },
-- 		{ key = "k",      action = act.AdjustPaneSize({ "Up", 2 }) },
-- 		{ key = "j",      action = act.AdjustPaneSize({ "Down", 2 }) },
--
-- 		{ key = "Enter",  action = "PopKeyTable" },
-- 		{ key = "Escape", action = "PopKeyTable" },
-- 	},
-- }

function module.apply_to_config(config)
	config.keys = keys
	-- config.key_tables = key_tables
end

return module
