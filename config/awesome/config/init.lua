pcall(require, "luarocks.loader")

require("awful.autofocus")
require("config.autostart")
require("awful.hotkeys_popup.keys")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")

-- beautiful.init("/home/pumbiwe/.config/awesome/theme/theming.lua")
require("config.windowrules")
require("config.keybindings")

-- Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

terminal = "alacritty"
editor = "nvim"
browser = "firefox"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
awful.layout.layouts = {
    awful.layout.suit.corner.nw,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
}

-- Menu
menubar.utils.terminal = terminal

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
                            if c == client.focus then
                                c.minimized = true
                            else
                                c:emit_signal(
                                    "request::activate",
                                    "tasklist",
                                    {raise = true}
                                )
                            end
                        end),
    awful.button({ }, 3, function()
                            awful.menu.client_list({ theme = { width = 250 } })
                        end),
    awful.button({ }, 4, function ()
                            awful.client.focus.byidx(1)
                        end),
    awful.button({ }, 5, function ()
                            awful.client.focus.byidx(-1)
                        end
))

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

--screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
    --set_wallpaper(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)

-- Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () MainMenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


-- Signals
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)
client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("manage", function (c)
    c.shape = gears.shape.rounded_rect,
    c:struts({
	    top = 35,
	    left = 10,
	    right = 10,
	    bottom = 10
    })
end)
-- client.connect_signal("focus", function(c) c.border_color = "#4169e1" end)
-- client.connect_signal("unfocus", function(c) c.border_color = beautiful.bg_focus end)
