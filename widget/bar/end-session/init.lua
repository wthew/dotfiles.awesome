-- DEPENDENCIES
-- i3lock-fancy
local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')

local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")

return function(color, space)
    local widget_button = wibox.widget {
        {
            {
                {
                    {
                        image = icons.power,
                        widget = wibox.widget.imagebox
                    },
                    top = dpi(4),
                    bottom = dpi(4),
                    left = dpi(12),
                    right = dpi(12),
                    widget = wibox.container.margin
                },
                shape = gears.shape.rounded_bar,
                bg = color,
                widget = wibox.container.background
            },
            forced_width = icon_size,
            forced_height = icon_size,
            widget = clickable_container
        },
        top = dpi(5),
        bottom = dpi(5),
        right = dpi(space),
        widget = wibox.container.margin
    }

    widget_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
        logout_popup.launch({
            bg_color = "#282A3633",
            label_color = "#4DC76E",
            accent_color = "#282A3666",
            phrases = {""},
            text_color = '#BD93F9',
            icon_size = 32,
            icon_margin = 16
        })
    end)))

    return widget_button
end
