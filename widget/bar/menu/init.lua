--DEPENDENCIES
	--rofi

local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local clickable_container = require('widget.clickable-container')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('themes.icons')

local return_button = function(color, space)
	local widget_button = wibox.widget {
	     {
	       {
	         {
						 {
		          image = icons.ship_wheel,
		          widget = wibox.widget.imagebox
		        },
						top = dpi(3),
						bottom = dpi(3),
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
	    left = dpi(space),
	    widget = wibox.container.margin
  	}

		widget_button:buttons(
			gears.table.join( 
				awful.button(
					{},
					1,
					nil,
					function()
						awesome.emit_signal("cc:toggle")
					end
				)
			)
		)

	return widget_button
end

return return_button
