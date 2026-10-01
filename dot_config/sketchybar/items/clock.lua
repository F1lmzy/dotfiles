local colors = require("config.colors")
local settings = require("config.settings")

local clock = sbar.add("item", "clock", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "00:00",
		font = {
			family = "SF Mono",
			style = "Bold",
			size = 14.0,
		},
		color = colors.white,
		padding_left = 0,
		padding_right = 0,
	},
	update_freq = 10,
	padding_left = 8,
	padding_right = 8,
})

clock:subscribe({ "routine", "forced", "system_woke" }, function(env)
	clock:set({ label = { string = os.date("%H:%M") } })
end)

clock:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Calendar'")
end)
