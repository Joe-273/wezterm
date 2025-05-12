local wezterm = require("wezterm")

local M = {}

function M.get_cur_paltform()
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		return "win"
	elseif wezterm.target_triple == "aarch64-apple-darwin" then
		return "mac"
	else
		return "linux"
	end
end

function M.is_mac()
	return M.get_cur_paltform() == "mac"
end

function M.is_win()
	return M.get_cur_paltform() == "win"
end

function M.is_linux()
	return M.get_cur_paltform() == "linux"
end

return M
