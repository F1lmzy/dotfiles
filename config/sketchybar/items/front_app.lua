local colors = require("colors")
local settings = require("settings")

-- Add chevron item
sbar.add("item", "chevron", {
  position = "left",
  icon = {
    string = "􀆓",
    color = colors.grey,
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
  label = { drawing = false },
  padding_left = 5,
  padding_right = 5,
})

-- Front app item
local front_app = sbar.add("item", "front_app", {
  position = "left",
  icon = { drawing = false },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Bold"],
      size = 14.0,
    },
    color = colors.white,
  },
  updates = true,
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
end)

-- Click to open Mission Control
front_app:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Mission Control'")
end)
