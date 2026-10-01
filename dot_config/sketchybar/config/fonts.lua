local dimens <const> = require("config.dimens")

return {
  text = "SF Pro",
  numbers = "SF Mono",
  icons = function(size)
    local font = "SF Pro"
    return size and font .. ":" .. size or font .. ":" .. dimens.text.icon
  end,
  styles = {
    regular = "Regular",
    bold = "Semibold",
  }
}
