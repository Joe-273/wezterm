local wezterm = require("wezterm")
local common = require("common")

local function rgb(color)
	color = string.lower(color)
	return { tonumber(color:sub(2, 3), 16), tonumber(color:sub(4, 5), 16), tonumber(color:sub(6, 7), 16) }
end

local function blend(foreground, alpha, background)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg, fg = rgb(background), rgb(foreground)
	local function blendChannel(i)
		return math.floor(math.min(math.max(0, alpha * fg[i] + (1 - alpha) * bg[i]), 255) + 0.5)
	end
	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(color, amount, bg)
	return blend(color, amount, bg or "#000000")
end

local function lighten(color, amount, fg)
	return blend(color, amount, fg or "#FFFFFF")
end

local M = {}

-- 合并配置
M.merge_config = function(base, ...)
	local extra_config = { ... }
	for _, additionalConfig in ipairs(extra_config) do
		for key, value in pairs(additionalConfig) do
			base[key] = value
		end
	end
end

-- 获取颜色
M.get_theme_color = function(is_active)
	local style = common.color_style
	if is_active then
		return common.color_theme_map[style].active
	else
		return common.color_theme_map[style].inactive
	end
end

-- 获取标签icon
M.get_tab_icon = function(exec_name)
	for key, icon in pairs(common.tab_icon_map) do
		if key ~= "_default" and string.find(exec_name:lower(), key:lower()) then
			return icon
		end
	end
	return common.tab_icon_map.default
end

-- 获取标签序号
M.get_tab_sup_index = function(index)
	return common.tab_sup_index[index]
end

-- 获取主题
M.get_theme_name = function()
	return common.color_theme
end

-- 获取主题配色
M.get_theme_palette = function(theme_name)
	return wezterm.get_builtin_color_schemes()[theme_name]
end

-- 混合颜色
M.darken = darken
M.lighten = lighten

return M
