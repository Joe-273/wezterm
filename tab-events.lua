---@diagnostic disable: unused-local

local wezterm = require("wezterm")

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function get_icon(exec_name)
	if string.find(exec_name, "nvim") then
		return ""
	elseif string.find(exec_name, "fzf") then
		return ""
	elseif string.find(exec_name, "python") then
		return ""
	elseif string.find(exec_name, "node") then
		return ""
	else
		return "󰨊"
	end
end

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

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#333333"
	local foreground = "#999999"

	if tab.is_active then
		background = "#555555"
		foreground = "#eeeeee"
	end

	local process_name = tab.active_pane.foreground_process_name

	local exec_name = basename(process_name)
	if exec_name:match("%.%w+$") then
		exec_name = exec_name:match("^(.-)%.%w+$")
	end

	local title_name = exec_name:sub(1, 1):upper() .. exec_name:sub(2)
	local title_icon = get_icon(exec_name)

	local title = title_icon .. "   " .. title_name .. " " .. SUP_IDX[tab.tab_index + 1]

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)
