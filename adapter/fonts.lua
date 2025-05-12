local wezterm = require("wezterm")
local u_helper = require("utils.helper")
local u_core = require("utils.core")
local fonts_manager = require("config").fonts

-- 当前平台字体
local fonts = {
	main = fonts_manager.get_main_font(),
	comment = fonts_manager.get_comment_font(),
	fallback = fonts_manager.get_fallbacks()[u_helper.get_cur_paltform()],
}

local default_font = wezterm.font_with_fallback({
	{ family = fonts.main, weight = "DemiBold" },
	{ family = fonts.fallback },
})

local font_rules = {
	-- Bold-but-not-italic
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font_with_fallback({
			{ family = fonts.main, weight = "ExtraBold" },
			{ family = fonts.fallback },
		}),
	},

	-- Bold-and-italic
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = fonts.main, weight = "ExtraBold", italic = true },
			{ family = fonts.fallback },
		}),
	},

	-- normal-intensity-and-italic
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = fonts.comment, weight = "Regular", italic = true },
			{ family = fonts.main, weight = "ExtraBold", italic = true },
			{ family = fonts.fallback },
		}),
	},

	-- half-intensity-and-italic
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = fonts.main, italic = true },
			{ family = fonts.fallback },
		}),
	},

	-- half-intensity-and-not-italic
	{
		intensity = "Half",
		italic = false,
		font = wezterm.font_with_fallback({
			{ family = fonts.main },
			{ family = fonts.fallback },
		}),
	},
}

local M = {}

-- 获取当前字体集
function M.get_fonts()
	return u_core.deep_copy(fonts)
end

-- 生成字体基本配置
function M.get_font_config()
	return {
		font = u_core.deep_copy(default_font),
		font_rules = u_core.deep_copy(font_rules),
	}
end

return M
