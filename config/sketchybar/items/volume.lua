local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Add volume_change event
sbar.add("event", "volume_change")

local volume = sbar.add("item", "volume", {
	position = "right",
	icon = {
		string = icons.volume._100,
		color = colors.white,
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
		padding_left = 2,
		padding_right = 2,
	},
	label = {
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Semibold"],
			size = 14.0,
		},
		color = colors.white,
		padding_right = 0,
	},
	padding_left = 5,
	padding_right = 5,
})

volume:subscribe("volume_change", function(env)
	local volume_level = tonumber(env.INFO)
	local icon = icons.volume._0

	if volume_level > 60 then
		icon = icons.volume._100
	elseif volume_level > 30 then
		icon = icons.volume._66
	elseif volume_level > 10 then
		icon = icons.volume._33
	elseif volume_level > 0 then
		icon = icons.volume._10
	end

	volume:set({
		icon = { string = icon },
		label = volume_level .. "%",
	})
end)

-- Click to open Sound preferences
volume:subscribe("mouse.clicked", function(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
	else
		sbar.exec("open -a 'System Settings' x-apple.systempreferences:com.apple.Sound-Settings.extension")
	end
end)

-- Scroll to change volume
volume:subscribe("mouse.scrolled", function(env)
	local delta = env.INFO.delta
	sbar.exec(
		'osascript -e "set volume output volume (output volume of (get volume settings) + ' .. (delta * 5) .. ')"'
	)
end)
