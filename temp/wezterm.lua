local wezterm = require("wezterm")
local utils = require("utils")

local font_config = require("font-config")
local diff_config = require("diff-config")

local config = {
	-- 窗口
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "INTEGRATED_BUTTONS | RESIZE",
	window_close_confirmation = "NeverPrompt",
	warn_about_missing_glyphs = false,
	window_background_opacity = 0.9,
	front_end = "OpenGL",
	-- 字体
	font_size = 14,
	-- Keymap
	leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 2000 },
	keys = require("keys-config"),
	-- 主题
	color_scheme = "One Light (Gogh)",
}

-- 合并配置
utils.merge_config(config, font_config, diff_config)

-- Tab
require("tab-config")

return config
