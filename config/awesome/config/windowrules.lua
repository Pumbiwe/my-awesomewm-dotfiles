
local awful = require("awful")
local beautiful = require("beautiful")
local keybindings = require("config.keybindings")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require('gears')

awful.rules.rules = {
  {
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      keys = CLIENTKEYS,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_offscreen,
      floating = false,
      maximized = false,
      above = false,
      below = false,
      ontop = false,
      sticky = false,
      maximized_horizontal = false,
      maximized_vertical = false
    }
  },
  { 
    rule = { class = "volumeControl" },
    properties = { 
      floating = true,
      x =  dpi(900)
    } 
  }
}
