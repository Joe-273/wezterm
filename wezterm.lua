local wezterm = require("wezterm")
local utils = require("utils")
local events = require("events")

local font_config = require("font")
local keys_config = require("keymaps")

local base_config = {
	-- 窗口
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "RESIZE | INTEGRATED_BUTTONS",
	window_close_confirmation = "NeverPrompt",
	warn_about_missing_glyphs = false,
	front_end = "OpenGL",

	-- 字体
	font_size = 14,
}

local config = {}
utils.merge_config(config, base_config, font_config, keys_config)
events.setup_theme(config)
return config
