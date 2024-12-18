local wezterm = require("wezterm")

local keys = {
	-- [[ Copy/Paste ]]
	-- Windows
	{ key = "C", mods = "CTRL", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "Insert", mods = "", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
	-- Mac
	{ key = "C", mods = "CMD", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "V", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "Insert", mods = "", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- [[ Pane ]]
	-- Split pane
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Close pane
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- Adjust pane size
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
	-- Switch pane
	{ key = "h", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Down") },

	-- [[ Tab ]]
	-- Add tab
	{ key = "t", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	-- Close tab
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- Switch tab
	{ key = "h", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	-- Move tab
	{
		key = "LeftArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action.MoveTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "ALT|SHIFT",
		action = wezterm.action.MoveTabRelative(1),
	},

	-- [[ Window ]]
	-- Adjust font size
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },

	-- Maximize or Minimize window
	{
		key = "F11",
		mods = "",
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			local isMaximized = overrides.isMaximized or false

			if isMaximized then
				window:restore()
				overrides.isMaximized = false
			else
				window:maximize()
				overrides.isMaximized = true
			end

			window:set_config_overrides(overrides)
		end),
	},

	-- [[ Terminal Actions ]]
	{ key = "F", mods = "CTRL", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
	{ key = "X", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
	{ key = "Q", mods = "CTRL", action = wezterm.action.QuickSelect },
}

-- Dynamically generate [LEADER + 1] to [LEADER + 9] key bindings
for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return keys
