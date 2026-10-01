local colors = require("config.colors")
local settings = require("config.settings")

local front_app = sbar.add("item", "front_app", {
  position = "left",
  icon = { drawing = false },
  label = {
    font = {
      family = settings.fonts.text,
      style = settings.fonts.styles.bold,
      size = 14.0,
    },
    color = colors.white,
  },
  updates = true,
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
end)

front_app:subscribe("mouse.clicked", function(env)
  sbar.exec("open -a 'Mission Control'")
end)
