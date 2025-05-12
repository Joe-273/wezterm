local function reactive(initial_data)
	local raw = initial_data or {}
	local watchers = {}
	local proxies = setmetatable({}, { __mode = "v" }) -- 弱表缓存代理对象

	local function make_reactive(target)
		if type(target) ~= "table" then
			return target
		end
		if proxies[target] then
			return proxies[target]
		end

		local proxy = setmetatable({}, {
			__index = function(_, key)
				return make_reactive(target[key])
			end,
			__newindex = function(_, key, new_val)
				local old_val = target[key]
				new_val = make_reactive(new_val) -- 新值转为响应式

				-- 仅当新旧值不同时触发更新
				if old_val ~= new_val then
					target[key] = new_val -- 更新值
					local operation = old_val == nil and "added" or "updated"
					for _, cb in ipairs(watchers) do
						cb(key, old_val, new_val, operation)
					end
				end
			end,
		})

		proxies[target] = proxy
		return proxy
	end

	local proxy = make_reactive(raw)

	if type(proxy) ~= "table" then
		return proxy
	end

	function proxy:watch(callback)
		table.insert(watchers, callback)
		return function()
			for i, cb in ipairs(watchers) do
				if cb == callback then
					table.remove(watchers, i)
					break
				end
			end
		end
	end

	return proxy
end

return reactive
