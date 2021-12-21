local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

local return_button = function(color, space)
    return wibox.widget {
        {
            {

                {
                    layout = wibox.layout.fixed.horizontal,
                    text = 'test'
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = color,
            fg = '#DDDDDD',
            widget = wibox.container.background
        },
        top = dpi(5),
        bottom = dpi(5),
        right = dpi(space),
        widget = wibox.container.margin
    }
end

return return_button
