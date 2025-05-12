local format_tab_title = require("events.format-tab-title")
local right_status = require("events.update-right-status")
local update_theme = require("events.update-theme")
local user_var_changed = require("events.user-var-changed")

local events = {
	format_tab_title.setup_format_tab_title,
	right_status.setup_right_status,
	update_theme.setup_update_theme,
	user_var_changed.setup_user_var_changed,
}

local function start()
	for _, setup in ipairs(events) do
		setup()
	end
end

return { start = start }
