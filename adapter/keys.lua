local keys_manager = require("config").keys

local M = {}

local function gen_key_item(list)
	local keys = { "key", "mods", "action" }
	local r = {}
	for index, value in ipairs(list) do
		r[keys[index]] = value
	end
	return r
end

function M.get_keys_config()
	local keys = {}
	for _, value in ipairs(keys_manager.get_keys()) do
		table.insert(keys, gen_key_item(value))
	end

	return { keys = keys }
end

return M
