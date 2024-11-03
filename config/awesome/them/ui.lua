
local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local helpers       = require("them.helpers")
local dpi           = beautiful.xresources.apply_dpi

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
                                if client.focus then
                                    client.focus:move_to_tag(t)
                                end
                            end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
                                if client.focus then
                                    client.focus:toggle_tag(t)
                                end
                            end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function isNumber(n)
    return #n > 0 and n:match("[^%d]") == nil
end



awful.screen.connect_for_each_screen(function(s)

    AwesomeMenu = {
        { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "manual", terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awesome.conffile },
        { "restart", awesome.restart },
        { "quit", function() awesome.quit() end },
     }


    local Clock = wibox.widget{
        {
            widget = wibox.widget.textclock,
            format = "%I:%M",
            font = beautiful.font_var .. "Bold 12",
            valign = "center",
            align = "center"
        },
        layout = wibox.layout.fixed.horizontal
    }
    KeyboardLayout = awful.widget.keyboardlayout()

     gears.wallpaper.maximized(gears.filesystem.get_xdg_config_home() .. "/../wallpaper/bg.png", s)
     MainMenu = awful.menu({ items = { { "awesome", AwesomeMenu, beautiful.awesome_icon },
                                         { "open terminal", terminal },
                                         { "power off", "shutdown -h now" },
     }})
     Launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                          menu = MainMenu })
    s.Prompt = awful.widget.prompt()
    s.LayoutBox = awful.widget.layoutbox(s)
    s.LayoutBox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    s.TagList = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    Separator = wibox.widget.separator({visible = false})

    s.VolumeText = wibox.widget{
    	align  = 'center',
    	valign = 'center',
    	widget = wibox.widget.textbox
    }
    pcall(
    awful.spawn.easy_async("pactl get-sink-volume @DEFAULT_SINK@", function(stdout, stderr, reason, exit_code)
	    s.VolumeText.text = string.match(stdout, "  (%d+)") .. "%"
    end))

    s.VolumeText:connect_signal("button::press", function (self, lx, ly, button, mods, metadata)
        if button == 1 then
            awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        elseif button == 3 then
            awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end
        
        awful.spawn.easy_async("pactl get-sink-volume @DEFAULT_SINK@", function(stdout, stderr, reason, exit_code)
	    if string.match(stdout, "  (%d+)") ~= nil then
            	s.VolumeText.text = string.match(stdout, "  (%d+)") .. "%"
	    end
        end)
    end)

    s.Wibox = awful.wibar({ 
        position = "top",
        screen = s,
        visible = true,
        type = "dock",
        width = 1360 - beautiful.useless_gap * 4,
        height = dpi(48),
        shape       = helpers.rrect(beautiful.rounded - 5),
        bg          =  beautiful.bg_color,
    })

    s.Wibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            Launcher,
            s.TagList,
            s.Prompt,
        },
        Separator,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	    s.VolumeText,
            KeyboardLayout,
            --wibox.widget.systray(),
            Clock,
            --s.LayoutBox,
        },
    }


end)
