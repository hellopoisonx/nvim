local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {{import = "plugins"}},
    default = {lazy = false, version = true},
    install = {colorscheme = {"tokyonight"}},
    checker = {enabled = false}, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor",
                "zipPlugin"
            }
        }
    }
})
