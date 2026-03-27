local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Add battery events
sbar.add("event", "power_source_change")

local battery = sbar.add("item", "battery", {
	position = "right",
	icon = {
		string = icons.battery._100,
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
	update_freq = 120,
	padding_left = 5,
	padding_right = 5,
})

local function update_battery()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = icons.battery._0
		local label = "?"
		local icon_color = colors.white

		-- Parse percentage
		local found, _, percentage = batt_info:find("(%d+)%%")
		if found then
			percentage = tonumber(percentage)
			label = percentage .. "%"

			-- Determine icon based on percentage
			local charging = batt_info:find("AC Power")

			if charging then
				icon = icons.battery.charging
				icon_color = colors.green
			else
				if percentage > 80 then
					icon = icons.battery._100
					icon_color = colors.green
				elseif percentage > 60 then
					icon = icons.battery._75
					icon_color = colors.white
				elseif percentage > 40 then
					icon = icons.battery._50
					icon_color = colors.white
				elseif percentage > 20 then
					icon = icons.battery._25
					icon_color = colors.orange
				else
					icon = icons.battery._0
					icon_color = colors.red
				end
			end
		end

		battery:set({
			icon = { string = icon, color = icon_color },
			label = label,
		})
	end)
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	update_battery()
end)

-- Click to open Battery preferences
battery:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'System Settings' x-apple.systempreferences:com.apple.Battery-Settings.extension")
end)

-- Initial update
update_battery()
