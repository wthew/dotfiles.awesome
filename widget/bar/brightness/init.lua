local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')
local naughty = require('naughty')

local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

return function(color, space)
    return wibox.widget {
        {
            {
                {
                    brightness_widget(),
                    volume_widget{
                        widget_type = 'arc'
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                top = dpi(3),
                bottom = dpi(3),
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = color,
            fg = '#E6D80B',
            widget = wibox.container.background
        },
        top = dpi(5),
        bottom = dpi(5),
        right = dpi(space),
        widget = wibox.container.margin
    }
end
