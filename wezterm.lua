local wezterm = require("wezterm")

--====== THEME ======--
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
	"¹⁰",
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
	"₁₀",
}

-- 映射表，包含进程名和对应的图标
local process_icon_map = {
	nu = " ",
	pwsh = "󰨊 ",
	cmd = " ",
	wsl = " ",
	wslhost = " ",
	nvim = " ",
	bat = "󰯂 ",
	less = "󰯂 ",
	moar = "󰯂 ",
	fzf = " ",
	hs = " ",
	peco = " ",
	btm = "󰓠 ",
	ntop = "󰓠 ",
	python = " ",
	hiss = " ",
	node = " ",
	deno = " ",
}

-- 用于保存当前的图标
local current_icon = HOURGLASS_ICON

--======= TAB =======--
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
	local exec_name = basename(process_name):gsub("%.exe$", "")
	-- 如果找到对应的图标，就更新 current_icon
	if process_icon_map[exec_name] then
		current_icon = process_icon_map[exec_name]
	end
	local title_with_icon = current_icon
	-- 如果是管理员窗口，添加管理员图标
	if tab.active_pane.title:match("^Administrator: ") then
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
		{ Attribute = { Intensity = "Normal" } },
	}
end)

return {
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
	window_background_opacity = 0.93,
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
	default_prog = { "pwsh.exe" }, -- default shell
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
		},
	},

	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},

	--====== KEY BINDING ======--
	disable_default_key_bindings = true,
	-- leader : <space>
	leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 2000 },
	keys = {
		--- ====== 窗格 ====== ---
		-- 分割窗格
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		-- 关闭窗格
		{
			key = "c",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},
		-- 调整窗格大小
		{ key = "h", mods = "ALT|SHIFT",   action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", mods = "ALT|SHIFT",   action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "k", mods = "ALT|SHIFT",   action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "j", mods = "ALT|SHIFT",   action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		-- 切换窗格
		{ key = "h", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Down") },

		--- ====== 标签页 ====== ---
		-- 新增 tab
		{ key = "t", mods = "LEADER",      action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		-- 关闭 tab
		{
			key = "w",
			mods = "LEADER",
			action = wezterm.action.CloseCurrentPane({ confirm = false }),
		},
		-- 切换 tab
		{ key = "h", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "l", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
		-- 移动标签页
		{
			key = "LeftArrow",
			mods = "ALT|SHIFT",
			action = wezterm.action.MoveTabRelative(-1),
		},
		{
			key = "RightArrow",
			mods = "ALT|SHIFT",
			action = wezterm.action.MoveTabRelative(1),
		},

		--- ====== 窗口 ====== ---

		-- 调整字体大小
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },

		-- 最大化和恢复窗口
		{
			key = "F11",
			mods = "",
			action = wezterm.action_callback(function(window, _)
				local overrides = window:get_config_overrides() or {}
				local isMaximized = overrides.isMaximized or false

				if isMaximized then
					window:restore()
					overrides.isMaximized = false
				else
					window:maximize()
					overrides.isMaximized = true
				end

				window:set_config_overrides(overrides)
			end),
		},

		--- ====== Terminal Actions ====== ---
		{ key = "F", mods = "CTRL", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
		{ key = "X", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
		{ key = "Q", mods = "CTRL", action = wezterm.action.QuickSelect },
	},
}
