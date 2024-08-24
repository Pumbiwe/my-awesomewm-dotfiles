local awful = require("awful")


awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
awful.spawn.with_shell(browser)
awful.spawn("setxkbmap -layout 'us,ru' -option 'grp:alt_shift_toggle'")
