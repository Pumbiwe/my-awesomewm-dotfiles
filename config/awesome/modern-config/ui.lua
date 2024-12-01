local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local helpers       = require("modern-config.helpers")
local dpi           = beautiful.xresources.apply_dpi

local wallpaper = require("gears.filesystem").get_xdg_config_home() .. "/../wallpaper/win.jpg"
gears.wallpaper.maximized(wallpaper, s)


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


function push_notification() 

    require("naughty").notify({
        title="Title",
        text="DEBUG"
    })

end

--push_notification()


awful.screen.connect_for_each_screen(function(s)


    awful.popup {
        widget = {
            {
                {
                    widget = wibox.widget.imagebox,
                    image  = beautiful.awesome_icon,
                    forced_height = dpi(28),
                    forced_width = dpi(28),
                },
                awful.widget.taglist {
                    screen  = s,
                    filter  = awful.widget.taglist.filter.all,
                    buttons = taglist_buttons,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            margins = 10,
            forced_width = dpi(202),
            widget  = wibox.container.margin
        },
        border_color = beautiful.accent,
        border_width = 2,
        placement    = awful.placement.top_left,
        shape        = gears.shape.rounded_rect,
        visible      = true,
    }

    awful.popup {
        widget = {
            {
                {
                    widget = wibox.widget.textbox,
                    text = awful.client.focus.title,
                    align  = 'center',
                    valign = 'center',
                    visible = true,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            margins = 10,
            forced_width = dpi((awful.client.focus.title or 0) * 9.5),
            widget  = wibox.container.margin
        },
        border_color = beautiful.accent,
        border_width = 2,
        placement    = awful.placement.top,
        shape        = gears.shape.rounded_rect,
        visible      = awful.client.focus.title ~= nil,
    }

    local layoutbox = awful.widget.layoutbox(s)
    layoutbox:buttons(
        gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )

    )

    local sound_btn = wibox.widget {
        image  = beautiful.sound_icon,
        forced_height = dpi(28),
        forced_width = dpi(28),
        widget = wibox.widget.imagebox
    }

    sound_btn:connect_signal("button::press", function(self, lx, ly, button, mods, metadata)
        awful.spawn.with_shell("bash -c \"if [[ \"$(ps aux | grep volumeControl | wc -l)\" == \"3\" ]]; then volumeControl; else killall volumeControl; fi\"")
    end)
    

    awful.popup {
        widget = {
            {   
                sound_btn,
                layoutbox,
                awful.widget.keyboardlayout(),
                {             
                    widget = wibox.widget.textclock,
                    format="%H:%M"
                },
                forced_width = dpi(32),
                layout = wibox.layout.fixed.horizontal,
            },
            margins = 10,
            forced_width = dpi(200),
            widget  = wibox.container.margin
        },
        border_color = beautiful.accent,
        border_width = 2,
        placement    = awful.placement.top_right,
        shape        = gears.shape.rounded_rect,
        visible      = true,
    }

    AwesomeMenu = {
        --{ "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "manual", terminal .. " -e man awesome" },
        { "restart", awesome.restart },
        { "quit", function() awesome.quit() end },
     }
    MainMenu = awful.menu({ items = { 
	    { "awesome", AwesomeMenu, beautiful.awesome_icon },
	    { "open terminal", terminal },
	    { "power off", "shutdown -h now" },
    }})
    Launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                          menu = MainMenu })

     --[[

    local Clock = wibox.widget{
        {
            widget = wibox.widget.textclock,
            format = " | %H:%M",
            font = beautiful.font_var,
            valign = "center",
            align = "center"
        },
        layout = wibox.layout.fixed.horizontal
    }

    KeyboardLayout = awful.widget.keyboardlayout()



    s.TagList = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    Separator = wibox.widget.separator({visible = false})


    s.Wibox = awful.wibar({ 
        position = "bottom",
        screen = s,
        visible = true,
        type = "dock",
        width = awful.screen.focused().geometry.width,
        height = awful.screen.focused().geometry.height / 16,
        bg          =  beautiful.bg_color,
    })


    local test =wibox.widget {
        image  = beautiful.awesome_icon,
        resize = false,
        widget = wibox.widget.imagebox  
    }

    s.Wibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            test,
            s.TagList,
        },
        Separator,
        {
            layout = wibox.layout.fixed.horizontal,
            KeyboardLayout,
            Clock,
        },
    }
    --]]


end)
