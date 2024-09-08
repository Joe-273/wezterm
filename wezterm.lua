local wezterm = require("wezterm")

--====== THEME ======--
-- change here to change the theme
local theme = wezterm.color.get_builtin_schemes()["Tokyo Night Storm"]

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

--====== ICON FONT ======--
local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)

local CMD_ICON = utf8.char(0xe62a)
local NU_ICON = utf8.char(0xe7a8)
local PS_ICON = utf8.char(0xe70f)
local ELV_ICON = utf8.char(0xfc6f)
local WSL_ICON = utf8.char(0xf83c)
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)

local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON = utf8.char(0xf9df)

local PYTHON_ICON = utf8.char(0xf820)
local NODE_ICON = utf8.char(0xe74e)
local DENO_ICON = utf8.char(0xe628)
local LAMBDA_ICON = utf8.char(0xfb26)


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
	"¹¹",
	"¹²",
	"¹³",
	"¹⁴",
	"¹⁵",
	"¹⁶",
	"¹⁷",
	"¹⁸",
	"¹⁹",
	"²⁰",
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
	"₁₁",
	"₁₂",
	"₁₃",
	"₁₄",
	"₁₅",
	"₁₆",
	"₁₇",
	"₁₈",
	"₁₉",
	"₂₀",
}

--======= TAB =======--
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = theme.tab_bar.background          -- tab gap background
	local background = theme.tab_bar.inactive_tab.bg_color    -- inactive tab background
	local foreground = theme.tab_bar.inactive_tab.fg_color    -- inactive tab font color
	local dim_foreground = theme.tab_bar.inactive_tab.fg_color -- tab upper right corner tips color

	if tab.is_active then
		-- active tab color
		background = theme.tab_bar.active_tab.bg_color
		foreground = theme.tab_bar.active_tab.fg_color
		dim_foreground = theme.tab_bar.active_tab.fg_color
	elseif hover then
		-- hover tab color (without active tab)
		background = theme.tab_bar.inactive_tab_hover.bg_color
		foreground = theme.tab_bar.inactive_tab_hover.fg_color
	end

	local edge_foreground = background
	local process_name = tab.active_pane.foreground_process_name
	local pane_title = tab.active_pane.title
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon

	if exec_name == "nu" then
		title_with_icon = NU_ICON .. " NuShell"
	elseif exec_name == "pwsh" then
		title_with_icon = PS_ICON .. " PS"
	elseif exec_name == "cmd" then
		title_with_icon = CMD_ICON .. " CMD"
	elseif exec_name == "elvish" then
		title_with_icon = ELV_ICON .. " Elvish"
	elseif exec_name == "wsl" or exec_name == "wslhost" then
		title_with_icon = WSL_ICON .. " WSL"
	elseif exec_name == "nyagos" then
		title_with_icon = NYA_ICON .. " " .. pane_title:gsub(".*: (.+) %- .+", "%1")
	elseif exec_name == "yori" then
		title_with_icon = YORI_ICON .. " " .. pane_title:gsub(" %- Yori", "")
	elseif exec_name == "nvim" then
		title_with_icon = VIM_ICON .. " NVIM"
	elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
		title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
	elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
		title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
	elseif exec_name == "btm" or exec_name == "ntop" then
		title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
	elseif exec_name == "python" or exec_name == "hiss" then
		title_with_icon = PYTHON_ICON .. " " .. exec_name
	elseif exec_name == "node" then
		title_with_icon = NODE_ICON .. " " .. exec_name:upper()
	elseif exec_name == "deno" then
		title_with_icon = DENO_ICON .. " " .. exec_name:upper()
	elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
		title_with_icon = LAMBDA_ICON .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
	else
		title_with_icon = HOURGLASS_ICON .. " " .. exec_name
	end
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
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_arrow },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = id },
		{ Text = title },
		{ Foreground = { Color = dim_foreground } },
		{ Text = pid },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
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
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	default_cursor_style = "BlinkingBar",
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 0.95,
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
	font_size = 11,
	freetype_load_target = "Normal",
	font = wezterm.font_with_fallback({
		"JetBrainsMonoNL Nerd Font Mono",
	}),
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
			background = theme.tab_bar.background,
			new_tab = {
				bg_color = theme.tab_bar.background,
				fg_color = theme.tab_bar.new_tab.fg_color,
				intensity = "Bold",
			},
			new_tab_hover = {
				bg_color = theme.tab_bar.background,
				fg_color = theme.tab_bar.active_tab.bg_color,
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
	-- disable_default_key_bindings = true,
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
		{ key = "h",   mods = "LEADER|SHIFT",                   action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "l",   mods = "LEADER|SHIFT",                   action = wezterm.action.ActivateTabRelative(1) },

		-- 切换全屏模式
		{ key = "F11", action = wezterm.action.ToggleFullScreen },
	},
}
