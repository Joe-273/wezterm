local wezterm = require("wezterm")
local utils = require("utils")

local M = {}

-- 当前主题的颜色数据
M.theme_palette = nil

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function setup_tab()
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local process_name = tab.active_pane.foreground_process_name

		local exec_name = basename(process_name)
		if exec_name:match("%.%w+$") then
			exec_name = exec_name:match("^(.-)%.%w+$")
		end

		local title_name = exec_name:sub(1, 1):upper() .. exec_name:sub(2)
		local title_icon = utils.get_tab_icon(exec_name)
		local title_sup_index = utils.get_tab_sup_index(tab.tab_index + 1)

		return {
			{ Text = " " .. title_icon .. "  " },
			{ Text = title_name },
			{ Text = " " .. title_sup_index },
		}
	end)
end

local function build_theme_palette()
	if M.theme_palette == nil then
		return
	end
	local palette = M.theme_palette
	palette.darken_background = utils.darken(palette.background, 0.7)
	palette.darken_foreground = utils.darken(palette.foreground, 0.7)
end

M.setup_theme = function(config)
	M.theme_palette = utils.get_theme_palette(utils.get_theme_name())
	build_theme_palette()

	local function gen_config(bg_color, fg_color)
		return { bg_color = bg_color, fg_color = fg_color, intensity = "Bold" }
	end

	local palette = M.theme_palette
	local bg = palette.darken_background
	local active_bg = palette.background
	local fg = palette.darken_foreground
	local fg_darken = utils.darken(fg, 0.5, bg)

	-- 更新主题/颜色数据
	config.color_scheme = utils.get_theme_name()

	config.window_frame = {
		inactive_titlebar_bg = bg,
		active_titlebar_bg = bg,
	}

	config.colors = {
		tab_bar = {
			active_tab = gen_config(active_bg, fg),
			inactive_tab = gen_config(bg, fg_darken),
			inactive_tab_edge = fg,
			inactive_tab_hover = gen_config(active_bg, fg_darken),
			new_tab = gen_config(bg, fg),
			new_tab_hover = gen_config(bg, fg_darken),
		},
	}

	-- 配置 tab
	setup_tab()
end

return M
