local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')
local naughty = require('naughty')

return function(color, space)    

    widget = awful.widget.keyboardlayout()
    
    local function on_click()
        widget.next_layout()
    end

    widget:connect_signal("button::press", on_click)

    return wibox.widget {
        {
            {
                {
                    widget,
                    layout = wibox.layout.fixed.horizontal
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = color,
            fg = '#282A36',
            widget = wibox.container.background
        },
        top = dpi(5),
        bottom = dpi(5),
        right = dpi(space),
        widget = wibox.container.margin
    }
end
