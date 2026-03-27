local settings = require("settings")

-- Equivalent to the --default domain
sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 17.0,
		},
		color = 0xffffffff,
		padding_left = 4,
		padding_right = 4,
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		color = 0xffffffff,
		padding_left = 4,
		padding_right = 4,
	},
	padding_left = 5,
	padding_right = 5,
})
