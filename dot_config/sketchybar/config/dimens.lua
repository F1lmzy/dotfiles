local padding <const> = {
  background = 4,
  icon = 4,
  label = 4,
  bar = 0,
  left = 8,
  right = 8,
  item = 8,
  popup = 4,
}

local graphics <const> = {
  bar = {
    height = 36,
    offset = 0,
  },
  background = {
    height = 24,
    corner_radius = 0,
  },
  slider = {
    height = 20,
  },
  popup = {
    width = 200,
    large_width = 300,
  },
  blur_radius = 30,
}

local text <const> = {
  icon = 16.0,
  label = 14.0,
}

return {
  padding = padding,
  graphics = graphics,
  text = text,
}
