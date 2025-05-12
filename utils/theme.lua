local wezterm = require("wezterm")
local u_color = require("utils.color")

local M = {}

-- 生成主题调色盘
function M.general_theme_palette(theme_name)
	-- 获取内置主题颜色
	local colors = wezterm.get_builtin_color_schemes()[theme_name]
	-- 基本色
	local r = {
		bg = colors.background,
		fg = colors.foreground,
	}
	-- 动态计算衍生颜色
	local meta = u_color.detect_theme_type(r.bg, r.fg)
	if meta.is_dark then
		r.dark_bg = u_color.lighten(r.bg, 0.85, r.fg)
		r.light_fg = u_color.darken(r.fg, 0.65, r.bg)
	else
		r.dark_bg = u_color.darken(r.bg, 0.85, r.fg)
		r.light_fg = u_color.lighten(r.fg, 0.85, r.bg)
	end
	return r
end

return M
