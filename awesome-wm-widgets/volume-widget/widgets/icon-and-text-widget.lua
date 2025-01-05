local wibox = require("wibox")
local beautiful = require('beautiful')

local widget = {}

local ICON_DIR = os.getenv("HOME") .. '/.config/awesome/awesome-wm-widgets/volume-widget/icons/'
local theme = require("themes.dracula.colors")

function widget.get_widget(widgets_args)
    local args = widgets_args or {}

    local font = args.font or beautiful.font
    local icon_dir = args.icon_dir or ICON_DIR

    return wibox.widget {
        {
            id = "icon",
            font = font,
            widget = wibox.widget.textbox,
        },
        {
            id = 'txt',
            font = font,
            widget = wibox.widget.textbox,
            fg = theme.cyan
        },
        layout = wibox.layout.fixed.horizontal,
        set_volume_level = function(self, new_value)

            local volume_icon
            if self.is_muted then
                volume_icon = ''
            else
                local new_value_num = tonumber(new_value)
                if (new_value_num >= 0 and new_value_num < 50) then
                    volume_icon = ""
                else
                    volume_icon = ""
                end
            end
            self:get_children_by_id('txt')[1]:set_text(new_value .. '%')
            self:get_children_by_id('icon')[1]:set_text(volume_icon)

        end,
        mute = function(self)
            self.is_muted = true
            self:get_children_by_id('icon')[1]:set_text('')
        end,
        unmute = function(self)
            self.is_muted = false
        end
    }

end

return widget
