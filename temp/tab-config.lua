local wezterm = require("wezterm")
local ui = require("ui-config")

local function get_tab_icon(exec_name, icon_map)
	for key, icon in pairs(icon_map) do
		if key ~= "_default" and string.find(exec_name:lower(), key:lower()) then
			return icon
		end
	end
	return icon_map.default
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function get_theme_color(style, is_active, color_theme_map)
	if is_active then
		return color_theme_map[style].active
	else
		return color_theme_map[style].inactive
	end
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local colors = get_theme_color(ui.color_style, tab.is_active, ui.color_theme_map)

	local process_name = tab.active_pane.foreground_process_name

	local exec_name = basename(process_name)
	if exec_name:match("%.%w+$") then
		exec_name = exec_name:match("^(.-)%.%w+$")
	end

	local title_name = exec_name:sub(1, 1):upper() .. exec_name:sub(2)
	local title_icon = get_tab_icon(exec_name, ui.tab_icon_map)
	local title_sup_index = ui.tab_sup_index[tab.tab_index + 1]

	return {
		{ Background = { Color = colors.bg } },
		{ Foreground = { Color = colors.fg } },
		{ Text = " " .. title_icon .. "  " },
		{ Text = title_name },
		{ Foreground = { Color = colors.accent } },
		{ Text = " " .. title_sup_index },
	}
end)
