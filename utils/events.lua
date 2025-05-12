local wezterm = require("wezterm")
local gui_window = wezterm.gui.gui_window()

local M = {}

-- 创建自定义事件
function M.create_event(event_name, callback)
	wezterm.on(event_name, function(window, pane)
		callback(window, pane)
	end)

	-- 返回触发函数
	return function()
		wezterm.emit(event_name, wezterm.gui.gui_window())
	end
end

return M
