local awful = require('awful')

local start_app = function(cmd)
    awful.spawn.with_shell(cmd)
end

start_app('systemctl --user start docker-desktop.service')
