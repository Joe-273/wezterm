-- [[ Configs for Windows only ]]

local wezterm = require("wezterm")

local win_conf = {
	-- shell
	default_prog = { "pwsh" },

	-- Ui
	win32_system_backdrop = "Acrylic",

	-- Font
	font_size = 10,
	font_rules = {
		-- Bold-but-not-italic
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "JetBrainsMono NF ExtraBold",
			}),
		},

		-- Bold-and-italic
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "Monaspace Radon",
				italic = true,
				weight = "Bold",
			}),
		},

		-- normal-intensity-and-italic
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "JetBrainsMono NF SemiBold",
				italic = true,
			}),
		},

		-- half-intensity-and-italic
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font({
				family = "JetBrainsMono NF",
				italic = true,
			}),
		},

		-- half-intensity-and-not-italic
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font({
				family = "JetBrainsMono NF",
			}),
		},
	},
}

return win_conf
