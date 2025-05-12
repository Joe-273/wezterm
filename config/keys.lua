local wezterm = require("wezterm")
local u_core = require("utils.core")

local keys = {
	-- 窗口分割
	{ "v", "LEADER", wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ "h", "LEADER", wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- 面板操作
	{ "c", "LEADER", wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ "h", "ALT|SHIFT", wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ "l", "ALT|SHIFT", wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ "k", "ALT|SHIFT", wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ "j", "ALT|SHIFT", wezterm.action.AdjustPaneSize({ "Down", 1 }) },
	-- 面板切换
	{ "h", "LEADER|CTRL", wezterm.action.ActivatePaneDirection("Left") },
	{ "l", "LEADER|CTRL", wezterm.action.ActivatePaneDirection("Right") },
	{ "k", "LEADER|CTRL", wezterm.action.ActivatePaneDirection("Up") },
	{ "j", "LEADER|CTRL", wezterm.action.ActivatePaneDirection("Down") },
	-- 标签页操作
	{ "t", "LEADER", wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ "w", "LEADER", wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ "h", "LEADER|SHIFT", wezterm.action.ActivateTabRelative(-1) },
	{ "l", "LEADER|SHIFT", wezterm.action.ActivateTabRelative(1) },
	{ "LeftArrow", "ALT|SHIFT", wezterm.action.MoveTabRelative(-1) },
	{ "RightArrow", "ALT|SHIFT", wezterm.action.MoveTabRelative(1) },
	-- 窗口操作
	{ "=", "CTRL", wezterm.action.IncreaseFontSize },
	{ "-", "CTRL", wezterm.action.DecreaseFontSize },
	-- 终端操作
	{ "F", "CTRL", wezterm.action.Search("CurrentSelectionOrEmptyString") },
	{ "X", "CTRL", wezterm.action.ActivateCopyMode },
	{ "Q", "CTRL", wezterm.action.QuickSelect },
}

return (function()
	-- 动态生成的标签切换 (LEADER+1~9)
	for i = 0, 8 do
		table.insert(keys, { tostring(i + 1), "LEADER", wezterm.action.ActivateTab(i) })
	end
	return u_core.deep_copy(keys)
end)()
