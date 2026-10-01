local colors = require("config.colors")
local settings = require("config.settings")

sbar.add("event", "media_change")

local media = sbar.add("item", "media", {
	position = "right",
	icon = { drawing = false },
	label = {
		string = "",
		font = {
			family = "SF Mono",
			style = "Bold",
			size = 14.0,
		},
		color = colors.white,
		padding_left = 0,
		padding_right = 0,
	},
	updates = true,
	padding_left = 8,
	padding_right = 8,
})

local function update_media()
	sbar.exec("nowplaying-cli get title artist", function(output)
		local title = ""
		local artist = ""
		
		for line in output:gmatch("[^\r\n]+") do
			if not title and line ~= "null" then
				title = line
			elseif line ~= "null" then
				artist = line
			end
		end
		
		if title and title ~= "null" and title ~= "" then
			local text = title
			if artist and artist ~= "null" and artist ~= "" then
				text = artist .. " - " .. title
			end
			media:set({ label = { string = text } })
		else
			media:set({ label = { string = "" } })
		end
	end)
end

media:subscribe({ "media_change", "routine" }, function()
	update_media()
end)

update_media()
