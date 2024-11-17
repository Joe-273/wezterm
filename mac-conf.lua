-- [[ Configs for OSX only ]]

local wezterm = require("wezterm")

local mac_conf = {
	-- UI
	macos_window_background_blur = 30,

	-- Font
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
				family = "JetBrainsMono NF",
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

return mac_conf
