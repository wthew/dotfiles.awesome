local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')
local naughty = require('naughty')

local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

return function(color, space)
    return wibox.widget {
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    ram_widget
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = color,
            fg = '#ff0000',
            widget = wibox.container.background
        },
        top = dpi(5),
        bottom = dpi(5),
        right = dpi(space),
        widget = wibox.container.margin
    }
end
