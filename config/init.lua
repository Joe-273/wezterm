local u_core = require("utils.core")

local theme = "Tokyo Night"
local fonts = require("config.fonts") -- 只读代理
local icons = require("config.icons") -- 只读代理
local keys = require("config.keys") -- 克隆对象

local M = {}

M.get_cur_theme = function()
	return theme
end

M.icons = {
	-- 获取应用程序图标
	get_exec_icons = function()
		return icons.tab_icons.exec_map
	end,
	-- 获取标签上标集合
	get_tab_sup_index = function()
		return icons.tab_icons.tab_sup_index
	end,
	-- 获取电池图标集合
	get_battery_icons = function()
		return icons.right_status.battery
	end,
	-- 获取充电电池图标
	get_battery_charging_icons = function()
		return icons.right_status.battery_charging
	end,
	-- 获取时钟图标
	get_clock_icon = function()
		return icons.right_status.clock
	end,
	-- 获取日期图标
	get_week_icon = function()
		return icons.right_status.week
	end,
}

M.fonts = {
	get_main_font = function()
		return fonts.main_font
	end,
	get_comment_font = function()
		return fonts.comment_font
	end,
	-- 获取回退字体集
	get_fallbacks = function()
		return fonts.fallbacks
	end,
}

M.keys = {
	get_keys = function()
		return u_core.deep_copy(keys)
	end,
}

return M
