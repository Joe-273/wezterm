local wezterm = require("wezterm")
local config_manager = require("config")

local exec_icons = config_manager.icons.get_exec_icons()
local tab_sup_index = config_manager.icons.get_tab_sup_index()

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- 获取当前程序的图标
local function cur_exec_icon(exec_name)
	for key, icon in pairs(exec_icons) do
		if key ~= "_default" and string.find(exec_name:lower(), key:lower()) then
			return icon
		end
	end
	return exec_icons.default
end

-- 获取当前tab的上标
local function cur_tab_sup_index(index)
	return tab_sup_index[index]
end

local M = {}

function M.setup_format_tab_title()
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local process_name = tab.active_pane.foreground_process_name

		local exec_name = basename(process_name)
		if exec_name:match("%.%w+$") then
			exec_name = exec_name:match("^(.-)%.%w+$")
		end

		local title_name = exec_name:sub(1, 1):upper() .. exec_name:sub(2)
		local title_icon = cur_exec_icon(exec_name)
		local title_sup_index = cur_tab_sup_index(tab.tab_index + 1)

		return {
			{ Text = " " .. title_icon },
			{ Text = "   " .. title_name },
			{ Text = " " .. title_sup_index },
		}
	end)
end

return M
