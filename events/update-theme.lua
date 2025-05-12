local wezterm = require("wezterm")
local colors_adapter = require("adapter.colors")

local M = {}

function M.setup_update_theme()
	wezterm.on("update-theme", function(window)
		-- 更新 UI 颜色
		window:set_config_overrides(colors_adapter.general_colors_config())
		-- 触发 right-status 事件, 更新右侧状态栏颜色
		wezterm.emit("update-right-status", window)
	end)
end

return M
