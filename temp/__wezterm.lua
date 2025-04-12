local function merge_config(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
	return t1
end

local wezterm = require("wezterm")
local config = {
	-- Window
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "INTEGRATED_BUTTONS | RESIZE",
	window_close_confirmation = "NeverPrompt",
	warn_about_missing_glyphs = false,
	front_end = "OpenGL",

	-- Cursor
	colors = { cursor_fg = "#eeeeee", cursor_bg = "#888888" },
	default_cursor_style = "BlinkingBlock",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 700,

	-- Colorscheme
	color_scheme = "Horizon Dark (base16)",
	window_background_opacity = 0.5,

	-- Keymap config
	disable_default_key_bindings = true,
	-- leader : <space>
	leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 2000 },
	keys = require("keys-config"),
}

-- Separate configuration
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	local win_config = require("win-conf")
	config = merge_config(config, win_config)
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	local mac_config = require("mac-conf")
	config = merge_config(config, mac_config)
end

-- Config events
require("tab-events")

return config
