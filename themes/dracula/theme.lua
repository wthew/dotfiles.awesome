local colors = require('themes.dracula.colors')

local theme = {}

theme.useless_gap   = 5
theme.border_width  = 0
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

theme.hotkeys_bg = colors.selection
theme.hotkeys_fg = colors.white
theme.hotkeys_modifiers_fg = colors.magenta
theme.hotkeys_border_color = colors.green
theme.hotkeys_group_margin = 10

return theme
