local wezterm = require("wezterm")

local default_font = "JetBrainsMono Nerd Font"
local comment_font = "Maple Mono"
local mac_fallback = "黑体-简"
local win_fallback = "黑体"

local fallback_font = nil
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	fallback_font = win_fallback
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	fallback_font = mac_fallback
end

local font_conf = {
	-- Primary font
	font = wezterm.font_with_fallback({
		{ family = default_font, weight = "DemiBold" },
		{ family = fallback_font },
	}),
	font_rules = {
		-- Bold-but-not-italic
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font_with_fallback({
				{ family = default_font, weight = "ExtraBold" },
				{ family = fallback_font },
			}),
		},

		-- Bold-and-italic
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = default_font, weight = "ExtraBold", italic = true },
				{ family = fallback_font },
			}),
		},

		-- normal-intensity-and-italic
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = comment_font, weight = "Regular", italic = true },
				{ family = default_font, weight = "ExtraBold", italic = true },
				{ family = fallback_font },
			}),
		},

		-- half-intensity-and-italic
		{
			intensity = "Half",
			italic = true,
			font = wezterm.font_with_fallback({
				{ family = default_font, italic = true },
				{ family = fallback_font },
			}),
		},

		-- half-intensity-and-not-italic
		{
			intensity = "Half",
			italic = false,
			font = wezterm.font_with_fallback({
				{ family = default_font },
				{ family = fallback_font },
			}),
		},
	},
}

return font_conf
