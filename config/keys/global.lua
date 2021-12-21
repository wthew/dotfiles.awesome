local awful = require('awful')
local naughty = require('naughty')

local modkey = require('config.keys.mod').modKey
local altkey = require('config.keys.mod').altKey

local apps = require('config.apps')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local hotkeys_popup_customh = require('module.hotkeys-popup')
local hotkeys_popup_custom_2 = require('module.hotkeys-popup-2')

require('awful.autofocus')

local globalKeys = awful.util.table.join(
  awful.key(
    {modkey},
    "h",
    hotkeys_popup_custom_2.show_help,
    {description="show help", group="Awesome"}
  ),

  awful.key(
		{"Mod1", "Control"},
		"Left",
		awful.tag.viewprev,
    {description = "view previous", group = "Tag"}
  ),

  awful.key(
		{"Mod1", "Control"},
		"Right",
		awful.tag.viewnext,
    {description = "view next", group = "Tag"}
  ),

  awful.key(
		{modkey},
		"Escape",
		awful.tag.history.restore,
    {description = "go back", group = "Tag"}
  ),

  awful.key(
		{modkey, "Shift"},
		"Right",
    function ()
        awful.client.focus.byidx( 1)
    end,
    {description = "focus next by index", group = "Tiling"}
  ),

  awful.key(
		{modkey, "Shift"},
		"Left",
    function ()
        awful.client.focus.byidx(-1)
    end,
    {description = "focus previous by index", group = "Tiling"}
  ),

  -- Layout manipulation
  awful.key(
		{modkey, "Shift"},
		"j",
		function ()
			awful.client.swap.byidx(  1)
		end,
		{description = "swap with next client by index", group = "Tiling"}
	),

  awful.key(
		{modkey, "Shift"},
		"k",
		function ()
			awful.client.swap.byidx( -1)
		end,
		{description = "swap with previous client by index", group = "Tiling"}
	),

	awful.key(
		{modkey, "Shift"},
		"s",
		function() awful.spawn.with_shell('flameshot gui') end,
		{description = "Screenshot selection", group = "Tiling"}
	),

  awful.key(
		{modkey, "Control"},
		"j",
		function ()
			awful.screen.focus_relative( 1)
		end,
		{description = "focus the next screen", group = "Screen"}
	),

  awful.key(
		{modkey, "Control"},
		"k",
		function ()
			awful.screen.focus_relative(-1)
		end,
		{description = "focus the previous screen", group = "Screen"}
	),

  awful.key(
		{modkey},
		"u",
		awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "Tiling"}
	),

  awful.key(
		{modkey},
		"Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {description = "go back", group = "Tiling"}
	),


  -- Default programs
  awful.key(
  	{modkey},
  	"Return",
  	function ()
  		awful.spawn(apps.default.terminal)
    end,
		{description = "Open Terminal", group = "Default programs"}
	),

  awful.key(
  	{modkey},
  	"e",
  	function ()
  		awful.spawn(apps.default.editor)
    end,
		{description = "Open Atom", group = "Default programs"}
	),

  awful.key(
  	{modkey},
  	"f",
  	function ()
  		awful.spawn(apps.default.browser)
    end,
		{description = "Open Firefox", group = "Default programs"}
	),

  awful.key(
  	{modkey},
  	"t",
  	function ()
  		awful.spawn(apps.default.email)
    end,
		{description = "Open Thunderbird", group = "Default programs"}
	),

  awful.key(
  	{modkey},
  	"d",
  	function ()
  		awful.spawn(apps.default.chat)
    end,
		{description = "Open Discord", group = "Default programs"}
	),

  awful.key(
  	{modkey},
  	"n",
  	function ()
  		awful.spawn(apps.default.file_manager)
    end,
		{description = "Open Nemo", group = "Default programs"}
	),

	-- awful.key({modkey}, "r", function () run_shell.launch() end, {description = "Run Shell", group = "Default programs"}),

  awful.key(
		{modkey, "Control"},
		"r",
		awesome.restart,
		{description = "reload awesome", group = "Awesome"}
	),

  awful.key(
		{modkey, "Shift"},
		"q",
		awesome.quit,
		{description = "quit awesome", group = "Awesome"}
	),

  awful.key(
		{modkey},
		"Up",
		function ()
			awful.tag.incmwfact(0.05)
		end,
		{description = "increase master width factor", group = "Layout"}
	),

  awful.key(
		{modkey},
		"Down",
		function ()
			awful.tag.incmwfact(-0.05)
		end,
		{description = "decrease master width factor", group = "Layout"}
	),

  awful.key(
		{modkey, "Shift"},
		"Up",
		function ()
			awful.tag.incnmaster( 1, nil, true)
		end,
		{description = "increase the number of master clients", group = "Layout"}
	),

  awful.key(
		{modkey, "Shift"},
		"Down",
		function ()
			awful.tag.incnmaster(-1, nil, true)
		end,
		{description = "decrease the number of master clients", group = "Layout"}
	),

  awful.key(
		{modkey, "Control"},
		"Up",
		function ()
			awful.tag.incncol( 1, nil, true)
		end,
		{description = "increase the number of columns", group = "Layout"}
	),

  awful.key(
		{modkey, "Control"},
		"Down",
		function ()
			awful.tag.incncol(-1, nil, true)
		end,
		{description = "decrease the number of columns", group = "Layout"}
	),

  awful.key(
		{modkey, "Shift"},
		"space",
		function ()
			awful.layout.inc(-1)
      naughty.notify({
        preset = naughty.config.presets.low,
        title = "Switched Layouts",
        text = awful.layout.getname(awful.layout.get(awful.screen.focused())),
      })
    end,
		{description = "select previous layout", group = "Layout"}
	),

	awful.key(
		{modkey},
		"space",
		function ()
			awful.spawn("/home/well/.config/rofi/bin/launcher_misc")
    end,
		{description = "See Apps", group = "Layout"}
	),


  awful.key(
		{modkey, "Control"},
		"n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", {raise = true}
        )
      end
    end,
		{description = "restore minimized", group = "Tiling"}
	),

	awful.key(
		{},
		"XF86MonBrightnessUp",
		function () 
			awful.spawn("light -A 10")
		end,
		{description = "Increase brightness", group = "Awesome"}
	),

	awful.key(
		{},
		"XF86MonBrightnessDown",
		function () 
			awful.spawn("light -U 10")
		end,
		{description = "Decrease brightness", group = "Awesome"}
	)

  -- awful.key(
  --   {modkey},
  --   "k",
	-- 	function()
	-- 		awesome.emit_signal("cc:toggle")
	-- 	end,
	-- 	{description = 'toggle control center', group = 'Awesome'}
	-- ),
)

for i = 1, 9 do
  globalKeys = awful.util.table.join(globalKeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      {description = "view tag #"..i, group = "Tag"}),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      {description = "toggle tag #" .. i, group = "Tag"}),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      {description = "move focused client to tag #"..i, group = "Tag"}),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      {description = "toggle focused client on tag #" .. i, group = "Tag"})
  )
end

return globalKeys
