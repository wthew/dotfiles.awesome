local colors = require('themes.dracula.colors')
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}

theme.useless_gap   = 4
theme.border_width  = 3
theme.border_normal = colors.background
theme.border_focus  = colors.purple
theme.border_marked = colors.orange

theme.bg_normal = colors.comment
theme.bg_systray = colors.comment
theme.systray_icon_spacing = 4

theme.font = "Monocraft Nerd Font"

return theme
