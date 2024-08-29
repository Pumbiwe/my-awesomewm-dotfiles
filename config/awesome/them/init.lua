
local xresources  = require("beautiful.xresources")
local dpi         = xresources.apply_dpi
local gears       = require("gears")
local gfs         = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local ui_vars     = require("them.ui_vars")
local helpers = require("them.helpers.init")
local colors = require("them.dark")


local theme = {}

theme.bg_color         = colors.bg_color
theme.bg_2             = colors.bg_2
theme.bg_3             = colors.bg_3
theme.fg_color      = colors.foreground
theme.red_color     = colors.red
theme.red_2         = colors.red_2
theme.red_3         = colors.red_3
theme.green_color   = colors.green
theme.green_2       = colors.green_2
theme.green_3       = colors.green_3
theme.black_color = "#000000"
theme.ext_white_bg = colors.ext_white_bg
theme.ext_light_bg = colors.ext_light_bg or nil
theme.ext_light_bg_2 = colors.ext_light_bg_2 or nil
theme.ext_light_fg = colors.ext_light_fg or nil
theme.ext_light_bg_3 = colors.ext_light_bg_3 or nil
theme.accent                = colors.accent
theme.accent_2              = colors.accent_2
theme.accent_3              = colors.accent_3
theme.font_var      = ui_vars.font .. " "
theme.icon_var      = "Material Icons Round "
theme.icon_alt_var  = "Material Icons Outlined "
theme.title_pos     = ui_vars.titlebar_position
theme.bar_size      = dpi(ui_vars.bar_size)
theme.rounded       = dpi(ui_vars.round_corners)
theme.rounded_wids  = dpi(ui_vars.round_corners - 2)
theme.font = theme.font_var .. "12"
theme.bg_normal     = theme.bg_color
theme.bg_focus      = theme.bg_2
theme.bg_urgent     = theme.red_2
theme.bg_minimize   = theme.bg_2
theme.bg_systray    = theme.bg_c2
theme.fg_normal     = theme.fg_color
theme.fg_focus      = theme.fg_color
theme.fg_urgent     = theme.bg_color
theme.fg_minimize   = theme.bg_2
theme.useless_gap           = dpi(ui_vars.gaps) or 7
theme.border_width          = dpi(ui_vars.border_width)
theme.border_color_normal   = theme.bg_color
theme.border_color_active   = theme.bg_color

theme.notification_font             = theme.font_var .. "12"
theme.notification_spacing          = dpi(theme.useless_gap * 2.2)
theme.notification_border_radius    = dpi(theme.rounded)
theme.notification_shape            = helpers.rrect(theme.rounded)
theme.notification_border_width     = dpi(0)

theme.titlebar_bg_normal    = theme.bg_color
theme.titlebar_bg_focus     = theme.bg_color
theme.titlebars_enabled     = true


theme.menu_font = theme.font_var
theme.menu_border_color = theme.border_color_normal
theme.menu_border_width = dpi(2)
--[[

theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_dwindle    = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw   = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne   = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw   = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse   = themes_path.."default/layouts/cornersew.png"
theme.layout_tiletop    = themes_path.."default/layouts/tiletopw.png"
theme.layout_magnifier  = themes_path.."default/layouts/magnifierw.png"
theme.layout_max        = themes_path.."default/layouts/maxw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"

--]]

theme.task_preview_widget_border_radius     = 4
theme.task_preview_widget_bg                = theme.bg_normal
theme.task_preview_widget_bg                = theme.bg_normal
theme.task_preview_widget_font              = theme.font_var .. "2"
theme.task_preview_widget_border_color      = theme.accent
theme.task_preview_widget_border_width      = 0
theme.task_preview_widget_margin            = dpi(20)

theme.tasklist_bg_normal                    = theme.bg_normal
theme.tasklist_bg_image_minimize                    = "#000"
theme.tasklist_disable_icon                 = true
theme.tasklist_font                         = theme.font_var
theme.tasklist_fg_normal                    = theme.fg_normal
theme.tasklist_fg_focus                     = "#ffffff"
theme.tasklist_fg_urgent                    = theme.fg_urgent
theme.tasklist_align                        = "center"

theme.tag_preview_client_bg                 = theme.bg_2
theme.tag_preview_client_border_color       = theme.bg_3
theme.tag_preview_client_border_radius      = theme.rounded / 1.6
theme.tag_preview_widget_border_radius      = theme.rounded
theme.tag_preview_client_border_width       = 2
theme.tag_preview_widget_bg                 = theme.bg_color
theme.tag_preview_widget_border_color       = theme.bg_2
theme.tag_preview_widget_border_width       = 0
theme.tag_preview_widget_margin             = dpi(5)
theme.menu_font             = theme.font_var .. "9"
theme.menu_bg_focus         = theme.bg_2
theme.menu_fg_focus         = theme.fg_normal
theme.menu_height           = dpi(30)
theme.menu_border_radius    = 200
theme.menu_width            = dpi(200)
theme.snap_bg       = theme.bg_2
theme.tasklist_bg_minimize      = theme.accent_2
theme.tasklist_font             = theme.font_var .. "11"
theme.tasklist_bg_focus         = theme.accent
theme.tasklist_bg_normal        = theme.fg_color .. "33"
theme.tasklist_plain_task_name = true
theme.hotkeys_shape             = helpers.rrect(theme.rounded)
theme.hotkeys_border_width      = 0
theme.hotkeys_font              = "JetBrainsMono Nerd Font 11"
theme.hotkeys_group_margin 	    = 30
theme.hotkeys_label_bg          = theme.accent
theme.hotkeys_label_fg          = theme.bg_color
theme.hotkeys_description_font  = "JetBrainsMono Nerd Font 8"
theme.hotkeys_modifiers_fg      = theme.fg_color .. "33"
theme.hotkeys_bg                = theme.bg_color
theme.tooltip_bg                = theme.bg_color
theme.tooltip_fg                = theme.fg_color
theme.tooltip_border_width      = 0
theme.tooltip_align             = "top"
theme.tooltip_margin            = "top"
theme.taglist_bg = theme.bg_color
theme.taglist_bg_focus = theme.bg_3
theme.taglist_fg_focus = theme.accent
theme.taglist_bg_urgent = theme.red_color
theme.taglist_fg_urgent = theme.red_2
theme.taglist_bg_occupied = theme.bg_color
theme.taglist_fg_occupied = theme.fg_color
theme.taglist_bg_empty = theme.bg_color
theme.taglist_fg_empty = theme.fg_color .. "66"
theme.taglist_disable_icon = true
theme.awesome_dock_size = 80
theme.awesome_dock_color_active = theme.accent
theme.awesome_dock_color_inactive = theme.fg_color .. "66"
theme.awesome_dock_color_minimized = theme.accent .. "33"
theme.awesome_dock_color_hover = theme.fg_color .. "33"
theme.awesome_dock_color_bg = theme.bg_color
theme.awesome_dock_disabled = false
theme.awesome_dock_spacing = 10
theme.awesome_dock_timeout = 1.2
require("beautiful").init(theme)
require("them.ui")