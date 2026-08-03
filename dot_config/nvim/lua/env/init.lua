local has = vim.fn.has
local is_win = has "win16" == 1 or has "win32" == 1 or has "win64" == 1
local is_mac = has "mac" == 1 or has "macunix" == 1

if is_win then
    require "env.win"
elseif is_mac then
    require "env.mac"
else
    require "env.linuxos"
end
