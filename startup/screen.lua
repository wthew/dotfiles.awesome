local beautiful = require('beautiful')
local gears = require('gears')
local awful = require('awful')
local backgrounds = require('themes.backgrounds')

local function set_wallpaper(s)
  local wallpaper = backgrounds.sea_of_stars
  gears.wallpaper.maximized(wallpaper, s, true)
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
  function(s)
    set_wallpaper(s)
  end
)

awful.spawn.with_shell("picom --backend glx --config .config/picom/picom.conf")
awful.spawn.with_shell('xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Tapping Enabled" 1')
-- awful.spawn.with_shell('xinput set-prop "$(xinput list --name-only | grep -i touch)" "libinput Natural Scrolling" true')
--awful.spawn.with_shell('xinput set-prop "$(xinput list | grep Touchpad | awk \'{print $6}\' | awk -F= \'{ print $2 }\')" "libinput Tapping Enabled" 1')
