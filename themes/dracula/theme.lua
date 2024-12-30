local colors = require('themes.dracula.colors')
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}

theme.useless_gap   = 5
theme.border_width  = 10
theme.border_normal = colors.green
theme.border_focus  = colors.magenta
theme.border_marked = colors.cyan

theme.hotkeys_bg = colors.selection
theme.hotkeys_fg = colors.white
theme.hotkeys_modifiers_fg = colors.magenta
theme.hotkeys_border_color = colors.green
theme.hotkeys_group_margin = 10

return theme
