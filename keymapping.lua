local wezterm = require("wezterm")

local keys = {
	--- ====== 窗格 ====== ---
	-- 分割窗格
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
	-- 关闭窗格
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- 调整窗格大小
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
	-- 切换窗格
	{ key = "h", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER|CTRL", action = wezterm.action.ActivatePaneDirection("Down") },

	--- ====== 标签页 ====== ---
	-- 新增 tab
	{ key = "t", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	-- 关闭 tab
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	-- 切换 tab
	{ key = "h", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "l", mods = "LEADER|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	-- 移动标签页
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

	--- ====== 窗口 ====== ---

	-- 调整字体大小
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },

	-- 最大化和恢复窗口
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

	--- ====== Terminal Actions ====== ---
	{ key = "F", mods = "CTRL", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
	{ key = "X", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
	{ key = "Q", mods = "CTRL", action = wezterm.action.QuickSelect },
}

-- 动态生成 LEADER + 1 到 LEADER + 9 的键绑定并插入到 keys 表中
for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return keys
