local wezterm = require("wezterm")
local keybindings = require("keymapping")

--====== THEME ======--
-- change the theme here
local theme = wezterm.color.get_builtin_schemes()["Google (dark) (terminal.sexy)"]

-- Equivalent to POSIX basename(3)
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

--====== ICON FONT ======--
local utf8 = require("utf8")

local SOLID_LEFT_ARROW = utf8.char(0xe0b6)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b4)

local HOURGLASS_ICON = utf8.char(0xf252)

local ADMIN_ICON = utf8.char(0xf49c)

local SUP_IDX = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
}
local SUB_IDX = {
	"₁",
	"₂",
	"₃",
	"₄",
	"₅",
	"₆",
	"₇",
	"₈",
	"₉",
}

-- 映射表，包含进程名和对应的图标
local process_icon_map = {
	nu = " ",
	pwsh = "󰨊 ",
	cmd = " ",
	wsl = " ",
	nvim = " ",
	bat = "󰯂 ",
	fzf = " ",
	btm = "󰓠 ",
	python = " ",
	node = " ",
	deno = " ",
}

--======= TAB =======--
local tab_icons = {} -- 缓存每个 tab 的 icon
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = theme.background
	local background = theme.background
	local foreground = theme.foreground

	if tab.is_active then
		background = theme.selection_bg
		foreground = theme.selection_fg
	elseif hover then
		background = theme.cursor_bg
		foreground = theme.cursor_fg
	end

	local edge_foreground = background
	local process_name = tab.active_pane.foreground_process_name
	local pane_title = tab.active_pane.title
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon

	if exec_name == "nu" then
		title_with_icon = process_icon_map.nu
	elseif exec_name == "pwsh" then
		title_with_icon = process_icon_map.pwsh
	elseif exec_name == "cmd" then
		title_with_icon = process_icon_map.cmd
	elseif exec_name == "wsl" or exec_name == "wslhost" then
		title_with_icon = process_icon_map.wsl
	elseif exec_name == "nvim" then
		title_with_icon = process_icon_map.nvim
	elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
		title_with_icon = process_icon_map.bat
	elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
		title_with_icon = process_icon_map.fzf
	elseif exec_name == "btm" or exec_name == "ntop" then
		title_with_icon = process_icon_map.btm
	elseif exec_name == "python" or exec_name == "hiss" then
		title_with_icon = process_icon_map.python
	elseif exec_name == "node" then
		title_with_icon = process_icon_map.node
	elseif exec_name == "deno" then
		title_with_icon = process_icon_map.deno
	else
		if tab_icons[tab.tab_id] == nil then
			title_with_icon = HOURGLASS_ICON
		else
			title_with_icon = tab_icons[tab.tab_id]
		end
	end

	-- 运行到这里，进程的 icon 已经存在
	-- 将 icon 保存
	tab_icons[tab.tab_id] = title_with_icon

	if pane_title:match("^Administrator: ") then
		title_with_icon = title_with_icon .. " " .. ADMIN_ICON
	end

	local left_arrow = SOLID_LEFT_ARROW
	if tab.tab_index == 0 then
		left_arrow = SOLID_LEFT_MOST
	end

	local id = SUB_IDX[tab.tab_index + 1]
	local pid = SUP_IDX[tab.active_pane.pane_index + 1]
	local title = " " .. wezterm.truncate_right(title_with_icon, max_width - 6) .. " "

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Attribute = { Italic = false } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_arrow },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = id },
		{ Text = title },
		{ Foreground = { Color = foreground } },
		{ Text = pid },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW .. " " },
	}
end)

local weztermConfig = {
	color_schemes = {
		["THEME"] = theme,
	},
	color_scheme = "THEME",
	initial_rows = 40,
	initial_cols = 120,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	default_cursor_style = "BlinkingBar",
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 0.92,
	adjust_window_size_when_changing_font_size = false,
	inactive_pane_hsb = {
		saturation = 1,
		brightness = 0.6,
	},
	-- animation_fps
	animation_fps = 60,
	cursor_blink_ease_in = "EaseIn",
	cursor_blink_ease_out = "EaseOut",

	font_dirs = { "fonts" },
	freetype_load_target = "Normal",
	font_size = 11,
	font = wezterm.font_with_fallback({
		"JetBrainsMonoNL Nerd Font", -- 正常字体
		"微软雅黑", -- 保留中文字体
	}),
	font_rules = {
		{
			-- 斜体时使用 Italic 字体
			italic = true,
			font = wezterm.font_with_fallback({
				"Monaspace Radon", -- 斜体字体
				"微软雅黑", -- 保留中文字体
				"JetBrainsMono Nerd Font", -- 保留图标字体
			}, { italic = true }),
		},
	},
	tab_max_width = 60,
	use_fancy_tab_bar = false,
	default_prog = { "nu.exe" }, -- default shell
	set_environment_variables = {
		LANG = "en_US.UTF-8",
		PATH = wezterm.executable_dir .. ";" .. os.getenv("PATH"),
	},

	-- tab bar background color (without exiting tabs)
	colors = {
		tab_bar = {
			background = theme.background,
			new_tab = {
				bg_color = theme.background,
				fg_color = theme.foreground,
				intensity = "Bold",
			},
			new_tab_hover = {
				bg_color = theme.background,
				fg_color = theme.cursor_bg,
				intensity = "Bold",
			},
			inactive_tab_hover = {
				bg_color = theme.background,
				fg_color = theme.cursor_bg,
				italic = false,
			},
		},
	},

	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},

	-- keymap config --
	disable_default_key_bindings = true,
	-- leader : <space>
	leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 2000 },
	keys = keybindings,
}

return weztermConfig
