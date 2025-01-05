local awful = require('awful')

local modkey = require('config.keys.mod').modKey
local altkey = require('config.keys.mod').altKey
local cyclefocus = require('awesome-cyclefocus')

require('awful.autofocus')

local clientkeys = awful.util.table.join(
  awful.key(
		{modkey,"Shift"},
		"f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "toggle fullscreen", group = "Tiling"}
	),

  awful.key(
		{modkey,"Shift"},
		"c",
    function (c)
      c:kill()
    end,
    {description = "close", group = "Tiling"}
	),

  awful.key(
		{modkey,"Control"},
		"space",
    awful.client.floating.toggle,
    {description = "toggle floating", group = "Tiling"}
	),

  awful.key(
		{modkey,"Control" },
		"Return",
    function (c)
      c:swap(awful.client.getmaster())
    end,
    {description = "move to master", group = "Tiling"}
	),

  awful.key(
		{modkey},
		"o",
    function (c)
      c:move_to_screen()
    end,
    {description = "move to screen", group = "Tiling"}
	),

  awful.key(
		{modkey, 'Shift'},
		"t",
    function (c)
      c.ontop = not c.ontop
    end,
    {description = "toggle keep on top", group = "Tiling"}
	),

  awful.key(
		{modkey},
		"n",
    function (c)
        c.minimized = true
    end ,
    {description = "minimize", group = "Tiling"}
	),

  cyclefocus.key({ "Mod1", }, "Tab", {
    -- cycle_filters as a function callback:
    -- cycle_filters = { function (c, source_c) return c.screen == source_c.screen end },

    -- cycle_filters from the default filters:
    cycle_filters = { cyclefocus.filters.same_screen, cyclefocus.filters.common_tag },
    keys = {'Tab', 'ISO_Left_Tab'}  -- default, could be left out
  })
)

return clientkeys
