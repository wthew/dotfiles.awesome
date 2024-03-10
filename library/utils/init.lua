local naughty = require('naughty') 
local awful = require('awful')

local utils = {}

function utils.print(text) 
    naughty.notify { text = text }
end


function utils.run_cmd(cmd)
    awful.spawn.with_shell(cmd)
end

return utils