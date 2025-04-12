local wezterm = require("wezterm")

local act = wezterm.action
local ui = require("ui-config")

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
	if ui.color_style == "dark" then
		ui.color_style = "light"
	else
		ui.color_style = "dark"
	end
end)
