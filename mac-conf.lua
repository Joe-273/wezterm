-- [[ Configs for OSX only ]]

local wezterm = require("wezterm")

local mac_conf = {
	-- UI
	macos_window_background_blur = 30,

	-- Window size
	initial_rows = 55,
	initial_cols = 150,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Font
	font_size = 14,
	-- Primary font
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
		{ family = "黑体-简" },
	}),
	font_rules = {
		-- Bold-but-not-italic
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", weight = "ExtraBold" },
				{ family = "黑体-简" },
			}),
		},

		-- Bold-and-italic
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", weight = "ExtraBold", italic = true },
				{ family = "黑体-简" },
			}),
		},

		-- normal-intensity-and-italic
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", weight = "DemiBold", italic = true },
				{ family = "黑体-简" },
			}),
		},

		-- half-intensity-and-italic
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", italic = true },
				{ family = "黑体-简" },
			}),
		},

		-- half-intensity-and-not-italic
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font" },
				{ family = "黑体-简" },
			}),
		},
	},
}

return mac_conf
