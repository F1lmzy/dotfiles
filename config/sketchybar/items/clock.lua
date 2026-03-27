local colors = require("colors")
local settings = require("settings")

local clock = sbar.add("item", "clock", {
	position = "right",
	icon = {
		string = "􀐫",
		color = colors.white,
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
		padding_left = 2,
		padding_right = 4,
	},
	label = {
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Semibold"],
			size = 14.0,
		},
		color = colors.white,
		padding_right = 8,
	},
	update_freq = 10,
	padding_left = 5,
	padding_right = 5,
})

clock:subscribe({ "routine", "forced", "system_woke" }, function(env)
	clock:set({ label = os.date("%d/%m %H:%M") })
end)

-- Click to open Calendar
clock:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Calendar'")
end)
