local wezterm = require("wezterm")

-- Configs for OSX only
local mac_conf = {
	-- UI
	macos_window_background_blur = 30,

	-- Font
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
		{ family = "黑体" },
	}),
	font_rules = {},
}

return mac_conf
