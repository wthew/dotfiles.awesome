local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local theme = require("themes.dracula.colors")


local ramgraph_widget = {}


local function worker(user_args)
    local args = user_args or {}
    local timeout = args.timeout or 1
    local color_used = args.color_used or beautiful.bg_urgent
    local color_free = args.color_free or theme.comment
    local color_buf  = args.color_buf  or beautiful.border_color_active
    local widget_show_buf = args.widget_show_buf or false
    local font = beautiful.font

    --- Main ram widget shown on wibar
    ramgraph_widget = wibox.widget {
        border_width = 0,
        font = font,
        fg = theme.comment,
        widget = wibox.widget.textbox,
        text = 'teste'
    }

    --- Widget which is shown when user clicks on the ram widget
    local popup = awful.popup{
       ontop = true,
       visible = false,
       widget = {
          widget = wibox.widget.piechart,
          forced_height = 200,
          forced_width = 480,
       },
       shape = gears.shape.rounded_rect,
       border_width = 1,
       offset = { y = 5 },
    }

    --luacheck:ignore 231
    local total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap

    local function getPercentage(value)
        return math.floor(value / (total+total_swap) * 100 + 0.5) .. '%'
    end

    watch('bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"', timeout,
        function(widget, stdout)
            total, used, free, shared, buff_cache, available, total_swap, used_swap, free_swap =
                stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

            widget:get_widget().set_text('RAM:'..getPercentage(used)) 
            
            if widget_show_buf then
                widget.data = { used, free, buff_cache }
            else
                widget.data = { used, total-used }
            end

            if popup.visible then
               popup:get_widget().data_list = {
                  {'Used: ' .. getPercentage(used + used_swap), used + used_swap},
                  {'Free: ' .. getPercentage(free + free_swap), free + free_swap},
                  {'Buffer Cache: ' .. getPercentage(buff_cache), buff_cache}
                }
            end
        end,
        ramgraph_widget
    )

    ramgraph_widget:buttons(
        awful.util.table.join(
           awful.button({}, 1, function()
                 popup:get_widget().data_list = {
                    {'used ' .. getPercentage(used + used_swap), used + used_swap},
                    {'free ' .. getPercentage(free + free_swap), free + free_swap},
                    {'buff_cache ' .. getPercentage(buff_cache), buff_cache}
                }

                if popup.visible then
                   popup.visible = not popup.visible
                else
                   popup:move_next_to(mouse.current_widget_geometry)
                end
            end)
        )
    )

    return ramgraph_widget
end


return setmetatable(ramgraph_widget, { __call = function(_, ...)
    return worker(...)
end })
