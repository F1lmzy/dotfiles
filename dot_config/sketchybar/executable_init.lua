package.cpath = package.cpath .. ";" .. os.getenv("HOME") .. "/.local/share/sketchybar_lua/?.so"
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/sketchybar/?.lua"

sbar = require("sketchybar")

sbar.begin_config()
sbar.hotload(true)

require("constants")
require("bar")
require("default")
require("items")

sbar.end_config()
sbar.event_loop()
