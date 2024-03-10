local utils = require('library.utils')

local rofi = {}

function rofi:test() 
    utils.print('rodando rofi')
    utils.run_cmd('~/.config/rofi/launchers/type-7/launcher.sh')
end


return rofi