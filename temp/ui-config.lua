local M = {}

M.tab_icon_map = {
	nvim = "",
	fzf = "",
	python = "",
	node = "",
	default = "󰨊",
}

M.tab_sup_index = { "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹" }

M.color_theme_map = {
	dark = {
		active = {
			bg = "#222",
			fg = "#eee",
			accent = "#bbb",
		},
		inactive = {
			bg = "#444",
			fg = "#888",
			accent = "#666",
		},
	},
	light = {
		active = {
			bg = "#fff",
			fg = "#333",
			accent = "#555",
		},
		inactive = {
			bg = "#ddd",
			fg = "#666",
			accent = "#888",
		},
	},
}

M.color_style = "light"

return M
