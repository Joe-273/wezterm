local readonly = require("core.readonly")

return readonly({
	tab_icons = {
		exec_map = {
			default = "󰨊",
			python = "",
			nvim = "",
			node = "",
			fzf = "",
		},
		tab_sup_index = {
			"¹",
			"²",
			"³",
			"⁴",
			"⁵",
			"⁶",
			"⁷",
			"⁸",
			"⁹",
		},
	},
	right_status = {
		clock = " ",
		week = " ",
		battery_charging = "󰂄",
		battery = {
			"󰁺",
			"󰁻",
			"󰁼",
			"󰁽",
			"󰁾",
			"󰁿",
			"󰂀",
			"󰂁",
			"󰂂",
			"󰁹",
		},
	},
})
