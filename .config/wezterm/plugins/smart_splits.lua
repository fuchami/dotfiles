local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local module = {}

function module.apply_to_config(config)
	smart_splits.apply_to_config(config, {
		-- directional keys to use in order of: left, down, up, right
		direction_keys = { "h", "j", "k", "l" },
		modifiers = {
			move = "CTRL",
			resize = "META|CTRL",
		},
	})
end

return module
