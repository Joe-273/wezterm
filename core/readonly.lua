local function made_readonly(original, seen)
	if type(original) ~= "table" then
		return original
	end

	seen = seen or {}
	if seen[original] then
		return seen[original]
	end

	local proxy = {}
	seen[original] = proxy

	-- 复制字段前先设置元表，防止在复制过程中被修改
	setmetatable(proxy, {
		__newindex = function(_, key, value)
			error("Attempt to modify a readonly table", 2)
		end,
		__index = function(_, key)
			return made_readonly(original[key], seen)
		end,
		__metatable = false,
		__pairs = function()
			return function(t, k)
				local next_key, next_val = next(original, k)
				return next_key, made_readonly(next_val, seen)
			end,
				nil,
				nil
		end,
	})

	return proxy
end

return made_readonly
