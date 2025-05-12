local M = {}

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

function M.darken(color, amount, bg)
	return blend(color, amount, bg or "#000000")
end

function M.lighten(color, amount, fg)
	return blend(color, amount, fg or "#FFFFFF")
end

-- 通过主题前景色和背景色判断是否为深色主题
function M.detect_theme_type(bg_color, fg_color)
	-- 自动补全缩写格式（如#fff转#ffffff）
	local function complete_hex(hex)
		hex = hex:gsub("#", ""):lower()
		if #hex == 3 then
			hex = hex:gsub("(.)", "%1%1")
		end
		return "#" .. hex
	end

	-- 安全获取RGB值
	local function safe_rgb(color)
		local ok, result = pcall(rgb, complete_hex(color))
		return ok and result or { 0, 0, 0 } -- 失败返回黑色
	end

	-- 计算背景亮度
	local bg = safe_rgb(bg_color)
	local bg_lum = 0.2126 * bg[1] + 0.7152 * bg[2] + 0.0722 * bg[3]

	-- 计算前景亮度
	local fg = safe_rgb(fg_color or "#ffffff")
	local fg_lum = 0.2126 * fg[1] + 0.7152 * fg[2] + 0.0722 * fg[3]

	-- 综合判断（背景为主，前景为辅）
	return {
		is_dark = bg_lum < 128,
		contrast_ratio = (math.max(bg_lum, fg_lum) + 0.05) / (math.min(bg_lum, fg_lum) + 0.05),
		background_luminance = bg_lum,
		foreground_luminance = fg_lum,
	}
end

return M
