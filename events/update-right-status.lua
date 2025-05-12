local wezterm = require("wezterm")
local config_manager = require("config")
local store = require("store")

local battery_icons = config_manager.icons.get_battery_icons()
local battery_charging_icon = config_manager.icons.get_battery_charging_icons()
local week_icon = config_manager.icons.get_week_icon()
local clock_icon = config_manager.icons.get_clock_icon()

local function cur_battery_icon(battery_state)
	local index = nil
	if battery_state.state == "Charging" then
		return battery_charging_icon
	else
		for i = 1, 10, 1 do
			if tonumber(battery_state.state_of_charge) >= (i / 10) then
				index = i
			else
				break
			end
		end
	end
	return battery_icons[index]
end

local function cur_format_battery(battery_state)
	return cur_battery_icon(battery_state) .. " " .. string.format("%.0f%%", battery_state.state_of_charge * 100)
end

local function cur_format_date()
	return wezterm.strftime(week_icon .. "  %b %-d - %a    " .. clock_icon .. "  %H:%M  ")
end

local M = {}

function M.setup_right_status()
	wezterm.on("update-right-status", function(window)
		local battery_state = wezterm.battery_info()[1]
		local bat = cur_format_battery(battery_state)
		local date = cur_format_date()

		window:set_right_status(wezterm.format({
			{ Foreground = { Color = store.colors.value.fg } },
			{ Background = { Color = store.colors.value.dark_bg } },
			{ Text = "    " .. bat .. "    " .. date .. "    " },
		}))
	end)
end

return M
