local readonly = require("core.readonly")

return readonly({
	main_font = "JetBrainsMono Nerd Font",
	comment_font = "Maple Mono",
	fallbacks = {
		mac = "黑体-简",
		win = "黑体",
		linux = nil,
	},
})
