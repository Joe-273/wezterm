local wezterm = require("wezterm")

-- Configs for Windows only
local win_conf = {
	-- Shell
	default_prog = { "pwsh" },

	-- UI
	win32_system_backdrop = "Acrylic",

	-- Font
	font_size = 10,
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
		"微软雅黑",
	}),
}

return win_conf
