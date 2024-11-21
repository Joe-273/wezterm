-- [[ Configs for Windows only ]]

local wezterm = require("wezterm")

local win_conf = {
	-- shell
	default_prog = { "pwsh" },

	-- Window size
	initial_rows = 55,
	initial_cols = 110,
	window_padding = {
		left = 0,
		right = 0,
		top = 2,
		bottom = 0,
	},

	-- Ui
	win32_system_backdrop = "Acrylic",

	-- Font
	font_size = 12,
	-- Primary font
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
		{ family = "黑体" },
	}),
	font_rules = {
		-- Bold-but-not-italic
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", weight = "ExtraBold" },
				{ family = "黑体" },
			}),
		},

		-- Bold-and-italic
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", weight = "ExtraBold", italic = true },
				{ family = "黑体" },
			}),
		},

		-- normal-intensity-and-italic
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", weight = "DemiBold", italic = true },
				{ family = "黑体" },
			}),
		},

		-- half-intensity-and-italic
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font", italic = true },
				{ family = "黑体" },
			}),
		},

		-- half-intensity-and-not-italic
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font_with_fallback({
				{ family = "JetBrainsMono Nerd Font" },
				{ family = "黑体" },
			}),
		},
	},
}

return win_conf
