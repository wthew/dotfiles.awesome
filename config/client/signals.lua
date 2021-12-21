local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local naughty = require('naughty')

client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then

        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    c.maximized = false
    c.maximized_horizontal = false
    c.maximized_vertical = false
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {
        raise = false
    })
end)

client.connect_signal("property::maximized", function(c)
    if c.maximized then
          c.shape = function(cr, w, h)
            return gears.shape.rectangle(cr, w, h)
        end
    else
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 10)
        end
    end
end)