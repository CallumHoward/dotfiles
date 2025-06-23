vim.cmd.runtime({ "ftplugin/c.lua", bang = true })
vim.opt_local.foldnestmax = 2
vim.env.CPPFLAGS = "-std=c++1y -Wall -Wextra -pedantic -Wno-unused-parameter -Wno-c++98-compat -g"