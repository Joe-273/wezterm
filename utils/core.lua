local M = {}

-- 深度克隆
M.deep_copy = function(table)
	local cache = setmetatable({}, { __mode = "k" }) -- 弱引用缓存表

	local function copy(obj)
		if type(obj) ~= "table" then
			return obj
		end
		-- 如果已经拷贝过则直接返回
		if cache[obj] then
			return cache[obj]
		end
		-- 创建新表并存入缓存
		local new_table = {}
		cache[obj] = new_table -- 先存入缓存再递归处理
		-- 递归拷贝所有字段（包括key和value）
		for k, v in pairs(obj) do
			new_table[copy(k)] = copy(v)
		end
		-- 处理元表
		local mt = getmetatable(obj)
		if mt then
			setmetatable(new_table, copy(mt)) -- 递归拷贝元表
		end
		return new_table
	end

	return copy(table)
end

-- 合并配置方法 (深度合并)
local function deep_merge(target, source)
	for k, v in pairs(source) do
		if type(v) == "table" and type(target[k]) == "table" then
			M.deep_merge(target[k], v)
		else
			target[k] = v
		end
	end
	return target
end

-- 合并配置方法（多参数）
M.merge_config = function(wc, ...)
	local extra_config = { ... }
	-- 遍历所有额外配置
	for _, config in ipairs(extra_config) do
		-- 对每个配置表执行深度合并
		deep_merge(wc, config or {})
	end
	return wc
end

return M
