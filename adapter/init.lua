local wezterm = require("wezterm")
local u_core = require("utils.core")

local fonts_adapter = require("adapter.fonts")
local keys_adapter = require("adapter.keys")
local colors_adapter = require("adapter.colors")

local wezterm_config = wezterm.config_builder()

-- 基础配置模板
local template = {
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "RESIZE | INTEGRATED_BUTTONS",
	window_close_confirmation = "NeverPrompt",
	warn_about_missing_glyphs = false,
	front_end = "OpenGL",
	font_size = 14,
	status_update_interval = 5000,
	leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 1500 },
}

-- 字体配置
local fonts_config = fonts_adapter.get_font_config()
-- 快捷键配置
local keys_config = keys_adapter.get_keys_config()
-- 颜色配置
local colors_config = colors_adapter.general_colors_config()

return u_core.merge_config(wezterm_config, template, fonts_config, keys_config, colors_config)
