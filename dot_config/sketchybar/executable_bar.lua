local settings = require("config.settings")

sbar.bar({
  topmost = "window",
  height = settings.dimens.graphics.bar.height,
  color = settings.colors.bar.bg,
  padding_right = 0,
  padding_left = 0,
  margin = 0,
  corner_radius = 0,
  y_offset = settings.dimens.graphics.bar.offset,
  blur_radius = settings.dimens.graphics.blur_radius,
  border_width = 0,
})
