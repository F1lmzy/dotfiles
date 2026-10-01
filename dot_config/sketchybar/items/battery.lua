local colors = require("config.colors")
local icons = require("config.icons")
local settings = require("config.settings")

sbar.add("event", "power_source_change")

local battery = sbar.add("item", "battery", {
	position = "right",
	icon = {
		string = icons.battery._100,
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
	update_freq = 30,
	padding_left = 8,
	padding_right = 8,
})

local function update_battery()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = icons.battery._0
		local label = "?"
		local icon_color = colors.white

		local found, _, percentage = batt_info:find("(%d+)%%")
		if found then
			percentage = tonumber(percentage)
			label = percentage .. "%"

			local charging = batt_info:find("AC Power")

			if charging then
				icon = icons.battery.charging
				icon_color = colors.green
				sbar.exec(os.getenv("HOME") .. "/.config/sketchybar/plugins/wattage.sh", function(watts)
					local w = watts:match("(%d+)W")
					if w and tonumber(w) > 0 and watts ~= "FULL" then
						label = percentage .. "% " .. w .. "W"
					else
						label = percentage .. "%"
					end
					battery:set({
						icon = { string = icon, color = icon_color },
						label = { string = label },
					})
				end)
				return
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
			label = { string = label },
		})
	end)
end

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	update_battery()
end)

battery:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'System Settings' x-apple.systempreferences:com.apple.Battery-Settings.extension")
end)

update_battery()
