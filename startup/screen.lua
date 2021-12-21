local beautiful = require('beautiful')
local gears = require('gears')
local awful = require('awful')
local backgrounds = require('themes.backgrounds')

local function set_wallpaper(s)
  local wallpaper = backgrounds.archkraken
  gears.wallpaper.maximized(wallpaper, s, true)
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(
  function(s)
    set_wallpaper(s)
  end
)

awful.spawn.with_shell("picom --experimental-backends --backend glx --config .config/picom/picom.conf")
awful.spawn.with_shell("xinput set-prop \"ETPS/2 Elantech Touchpad\" \"libinput Tapping Enabled\" 1")
