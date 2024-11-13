local wezterm = require("wezterm")

-- Configs for Windows only
local win_conf = {
	default_prog = { "pwsh" },
	win32_system_backdrop = "Acrylic",

	font = wezterm.font_with_fallback({
		"JetBrainsMonoNL Nerd Font",
		"微软雅黑",
	}),
	font_rules = {
		{
			font = wezterm.font({
				family = "JetBrainsMonoNL Nerd Font",
				weight = "DemiBold",
			}),
		},
	},
}

return win_conf
