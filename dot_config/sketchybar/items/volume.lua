local colors = require("config.colors")
local icons = require("config.icons")
local settings = require("config.settings")

sbar.add("event", "volume_change")

local volume = sbar.add("item", "volume", {
	position = "right",
	icon = {
		string = icons.volume._100,
		color = colors.white,
		font = {
			family = "SF Mono",
			style = "Bold",
			size = 14.0,
		},
		padding_left = 0,
		padding_right = 0,
	},
	label = {
		string = "100%",
		font = {
			family = "SF Mono",
			style = "Bold",
			size = 14.0,
		},
		color = colors.white,
		padding_left = 4,
		padding_right = 0,
	},
	padding_left = 8,
	padding_right = 8,
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
		label = { string = volume_level .. "%" },
	})
end)

volume:subscribe("mouse.clicked", function(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
	else
		sbar.exec("open -a 'System Settings' x-apple.systempreferences:com.apple.Sound-Settings.extension")
	end
end)

volume:subscribe("mouse.scrolled", function(env)
	local delta = env.INFO.delta
	sbar.exec(
		'osascript -e "set volume output volume (output volume of (get volume settings) + ' .. (delta * 5) .. ')"'
	)
end)
