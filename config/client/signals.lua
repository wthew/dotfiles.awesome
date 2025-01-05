local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local naughty = require('naughty')

local function set_shape(c)
    if not c.maximized and not c.fullscreen then
        c.border_width = beautiful.border_width
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 16)
        end
    else
        c.border_width = 0
        c.shape = function(cr, w, h)
            return gears.shape.rectangle(cr, w, h)
        end
    end
end

client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then

        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    c.maximized = false
    c.maximized_horizontal = false
    c.maximized_vertical = false

    set_shape(c)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {
        raise = false
    })
end)

client.connect_signal("property::maximized", function(c)
    set_shape(c)
end)

client.connect_signal("property::fullscreen", function(c)
    set_shape(c)
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
