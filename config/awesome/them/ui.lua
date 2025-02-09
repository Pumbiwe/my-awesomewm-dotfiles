
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


local function updateVolume(s, value)
    pcall(
    		awful.spawn.easy_async("bash -c \"pactl set-sink-volume @DEFAULT_SINK@ " .. value .. "; pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \\([0-9][0-9]*\\)%.*,\\1,'\"", function(stdout, stderr, reason, exit_code)
	s.VolumeText.text = stdout:gsub("\n", "") .. "%"
    end))
    return s.VolumeText.text
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
            format = " | %I:%M",
            font = beautiful.font_var .. "Bold 12",
            valign = "center",
            align = "center"
        },
        layout = wibox.layout.fixed.horizontal
    }
    KeyboardLayout = awful.widget.keyboardlayout()

     gears.wallpaper.maximized(gears.filesystem.get_xdg_config_home() .. "/../wallpaper/bg.jpg", s)
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

    updateVolume(s, "+0%")

    s.VolumeText:connect_signal("button::press", function (self, lx, ly, button, mods, metadata)
        if button == 1 then
            updateVolume(s, "-5%")
        elseif button == 3 then
            updateVolume(s, "+5%")
        end
    end)

    s.Wibox = awful.wibar({ 
        position = "top",
        screen = s,
        visible = true,
        type = "dock",
        width = awful.screen.focused().geometry.width - beautiful.useless_gap * 4,
        height = awful.screen.focused().geometry.height / 16,
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
	    s.LayoutBox,
            --wibox.widget.systray(),
            Clock,
            --s.LayoutBox,
        },
    }


end)
