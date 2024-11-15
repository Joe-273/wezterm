local wezterm = require("wezterm")

-- Configs for Windows only
local win_conf = {
	-- shell
	default_prog = { "pwsh" },

	-- Ui
	win32_system_backdrop = "Acrylic",

	-- Font
	font_size = 10,
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
		{ family = "微软雅黑" },
	}),
}

return win_conf
