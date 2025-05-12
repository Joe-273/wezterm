local wezterm = require("wezterm")
local store = require("store")

local M = {}

-- shell中使用以下命令进行动态更改主题：
-- printf "\033]1337;SetUserVar=%s=%s\007" "update-theme" `echo -n "主题名称" | base64`
function M.setup_user_var_changed()
	wezterm.on("user-var-changed", function(window, pane, name, value)
		if name == "update-theme" then
			store.cur_theme.value = value
		end
		-- 触发 update-theme 事件
		wezterm.emit("update-theme", window)
	end)
end

return M
