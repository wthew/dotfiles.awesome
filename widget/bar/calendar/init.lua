local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')
local naughty = require('naughty')

local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

local cw = calendar_widget({
    theme = 'nord',
    placement = 'top_right',
    start_sunday = true,
    radius = 8,
    -- with customized next/previous (see table above)
    previous_month_button = 1,
    next_month_button = 3
})

return function(color, space)
    local calendar = wibox.widget {
        format = ' %a %b %d',
        refresh = 1,
        widget = wibox.widget.textclock
    }

    calendar:connect_signal("button::press", function(_, _, _, button)
        if button == 1 then
            cw.toggle()
        end
    end)

    return wibox.widget {
        {
            {
                {
                    calendar,
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
