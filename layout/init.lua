local awful = require("awful")
require('startup.screen')

awful.layout.layouts = {
    awful.layout.suit.tile,
}

awful.screen.connect_for_each_screen(
  function(s)
    awful.tag({ "1", "2", "3", "4", "5"  }, s, awful.layout.layouts[1])
  end
)
