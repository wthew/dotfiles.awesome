local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widget.clickable-container')
local colors = require('themes.dracula.colors')
local theme = require('themes.dracula.theme')

local height = dpi(32)

local bar = function(s)

    s.panel = awful.wibox({
        ontop = true,
        screen = s,
        type = 'dock',
        height = height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        stretch = false,
        visible = true,
        bg = 'transparent',
        fg = '#000000',
        font = theme.font..' 8'
    })

    s.panel:struts{
        top = height - 8
    }

    function bar_toggle()
        if s.panel.visible == false then
            awful.screen.connect_for_each_screen(function(s)
                s.panel.visible = true
            end)
            awesome.emit_signal("bar:true")
        elseif s.panel.visible == true then
            awful.screen.connect_for_each_screen(function(s)
                s.panel.visible = false
            end)
            awesome.emit_signal("bar:false")
        end
    end

    local function fullscreen_bar_toggle(c)
        if c.screen and c.screen.index == 1 and c == client.focus then
            if c.fullscreen then
                awful.screen.focused().panel.visible = false
            else
                awful.screen.focused().panel.visible = true
            end
        end
    end

    for _, signal in pairs({"property::fullscreen", "focus"}) do
        client.connect_signal(signal, fullscreen_bar_toggle)
    end

    s.end_session = require('widget.bar.end-session')(colors.comment, 7)
    s.clock = require('widget.bar.clock')(colors.cyan, 7)
    s.keyboard = require('widget.bar.keyboard')(colors.cyan, 7)
    s.calendar = require('widget.bar.calendar')(colors.cyan, 7)
    s.ram = require('widget.bar.ram')(colors.purple, 7)
    s.brightness = require('widget.bar.brightness')(colors.comment, 7)
    s.notificationCenterBar = require('widget.bar.notifications-bar')(colors.pink, 7)
    s.menu = require('widget.bar.menu')(colors.comment, 7)
    s.volume = require('widget.bar.volume')(colors.comment, 7)
    s.system = require('widget.bar.system')(colors.comment, 7)
    s.docker = require('widget.bar.docker')(colors.cyan, 7)

    local tags = require('widget.bar.tags')(s, colors.purple, colors.cyan, 3)

    s.panel:setup{
        layout = wibox.layout.align.horizontal,
        expand = 'none',
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(4),
            s.menu,
            s.focused,
            tags,
            s.docker
        },
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(4),
            s.clock,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(4),
            s.calendar,
            s.volume,
            s.system,
            s.notificationCenterBar,
            s.end_session
        },
    }

    return s.panel
end

awesome.connect_signal("bar:toggle", function()
    bar_toggle()
end)

return bar
