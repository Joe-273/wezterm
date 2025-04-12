local wezterm = require("wezterm")

local mac_conf = {
	-- UI
	macos_window_background_blur = 30,
	-- Window size
	initial_rows = 48,
	initial_cols = 148,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}

local win_conf = {
	-- shell
	default_prog = { "pwsh" },
	-- UI
	win32_system_backdrop = "Acrylic",
	-- Window size
	initial_rows = 55,
	initial_cols = 110,
	window_padding = {
		left = 0,
		right = 0,
		top = 2,
		bottom = 0,
	},
}

local diff_conf = nil

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	diff_conf = win_conf
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	diff_conf = mac_conf
end

return diff_conf
