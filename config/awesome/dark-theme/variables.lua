local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local awful = require("awful")

return {
	font                = "Roboto Medium " .. tostring(dpi(12, awful.screen.focused())),
	titlebar_position   = "bottom",
	gaps                = 10,
	border_width        = 0,
	round_corners       = 15,
	bar_size            = 54,
	color_scheme        = "dark",
}
