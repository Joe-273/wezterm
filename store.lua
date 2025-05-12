local reactive = require("core.reactive")
local config_manager = require("config")
local u_theme = require("utils.theme")

-- 响应式数据仓库
local M = {}

-- 主题名称
M.cur_theme = reactive({ value = config_manager.get_cur_theme() })

-- 主题颜色 计算属性 依赖 M.cur_theme
M.colors = (function()
	-- 缓存
	local colors_cache = {}
	-- 获取主题调色盘
	local function get_theme_palette(theme_name)
		if not colors_cache[theme_name] then
			colors_cache[theme_name] = u_theme.general_theme_palette(theme_name)
		end
		return colors_cache[theme_name]
	end
	-- 更新调色盘
	M.cur_theme:watch(function(key, old_val, new_val, type)
		M.colors.value = get_theme_palette(new_val)
	end)

	-- 返回非响应式数据
	return { value = get_theme_palette(M.cur_theme.value) }
	-- return reactive({ value = get_theme_palette(M.cur_theme.value) })
end)()

return M
