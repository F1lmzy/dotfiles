local colors = require("colors")
local settings = require("settings")

-- Add the aerospace event
sbar.add("event", "aerospace_workspace_change")

local spaces = {}

for i = 1, 5, 1 do
	local space = sbar.add("item", "space." .. i, {
		position = "left",
		icon = {
			string = i,
			padding_left = 10,
			padding_right = 10,
			color = colors.grey,
			highlight_color = colors.white,
			font = {
				family = settings.font.numbers,
				style = settings.font.style_map["Bold"],
				size = 14.0,
			},
		},
		label = { drawing = false },
		background = {
			color = colors.bg2,
			border_width = 1,
			height = 24,
			border_color = colors.black,
			corner_radius = 5,
			drawing = false,
		},
		padding_left = 2,
		padding_right = 2,
	})

	spaces[i] = space

	-- Handle aerospace workspace changes
	space:subscribe("aerospace_workspace_change", function(env)
		local focused_workspace = env.FOCUSED_WORKSPACE
		local is_focused = (tostring(i) == focused_workspace)

		space:set({
			background = {
				drawing = is_focused and "on" or "off",
			},
			icon = {
				color = is_focused and colors.white or colors.grey,
			},
		})
	end)

	-- Click to switch workspace
	space:subscribe("mouse.clicked", function(env)
		sbar.exec("aerospace workspace " .. i)
	end)
end
