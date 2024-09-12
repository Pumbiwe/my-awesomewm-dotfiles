
local awful = require("awful")
local beautiful = require("beautiful")
local keybindings = require("config.keybindings")
-- Rules
awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = CLIENTKEYS,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    { rule_any = {
        instance = {
          "DTA",  
          "copyq", 
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  
          "Sxiv",
          "Tor Browser",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},
        name = {
          "Event Tester",  
        },
        role = {
          "AlarmWindow", 
          "ConfigManager", 
          "pop-up",      
        }
      }, properties = { floating = true }},

    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false, border_color = "#4169e1", opacity = 0.95 }
    },

    { rule = {class="Firefox"},
    	properties = {screen=2}
    }
}
