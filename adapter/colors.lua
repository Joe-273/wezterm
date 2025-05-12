local store = require("store")

local function gen_config(bg, fg)
	return { bg_color = bg, fg_color = fg, intensity = "Bold" }
end

local M = {}

-- 生成主题颜色盘与配置对象
function M.general_colors_config()
	local colors = store.colors.value
	return {
		color_scheme = store.cur_theme.value,
		window_frame = {
			inactive_titlebar_bg = colors.dark_bg,
			active_titlebar_bg = colors.dark_bg,
		},
		colors = {
			tab_bar = {
				active_tab = gen_config(colors.bg, colors.fg),
				inactive_tab = gen_config(colors.dark_bg, colors.light_fg),
				inactive_tab_edge = colors.fg,
				inactive_tab_hover = gen_config(colors.bg, colors.light_fg),
				new_tab = gen_config(colors.dark_bg, colors.light_fg),
				new_tab_hover = gen_config(colors.dark_bg, colors.fg),
			},
		},
	}
end

return M
