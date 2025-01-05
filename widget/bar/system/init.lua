local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')
local naughty = require('naughty')
local theme = require('themes.dracula.theme')

local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

local opened_text = " <"
local closed_text = " >"

return function(color, space)
    local sys_visible = true
    
    local toggle_button = wibox.widget {
        text = opened_text,
        widget = wibox.widget.textbox,
        font = theme.font..' 12',
	fg = theme.white
    }

    local sys_tray = wibox.widget.systray {
        visible = sys_visible
    }

    sys_tray:set_base_size(24)

    widget_output = wibox.widget {
        {
            {
                {
                    layout = wibox.layout.fixed.horizontal,
		    fg = theme.white,
                    spacing = dpi(2),
                    toggle_button,
                    sys_tray
                },
                top = dpi(4),
		    fg = theme.white,
                bottom = dpi(4),
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = color,
	    fg = theme.white,
            widget = wibox.container.background
        },
        top = dpi(5),
		    fg = theme.white,
        bottom = dpi(5),
        right = dpi(space),
        widget = wibox.container.margin
    }


    toggle_button:connect_signal('button::press', function(_, __, button)
        sys_visible = not sys_visible
        
        toggle_button.text = sys_visible and opened_text or closed_text
        sys_tray.visible = sys_visible

        toggle_button:emit_signal('widget::redraw_needed')
        sys_tray:emit_signal('widget::redraw_needed')
    end)

    return widget_output
end
