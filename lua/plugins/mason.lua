return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        event = "VimEnter",
        config = true
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local lsp_attach = require("commons.lsp")
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        on_attach = lsp_attach.lsp_attach
                    }
                end,
                ["lua_ls"] = function()
                    require("lspconfig")["lua_ls"].setup({
                        on_attach = lsp_attach.lsp_attach,
                        before_init = require("neodev.lsp").before_init,
                        settings = {
                            Lua = {
                                hint = {
                                    arrayIndex = "Auto",
                                    await = true,
                                    enable = true,
                                    paramType = true
                                },
                                completion = {
                                    callSnippet = "Replace"
                                },
                            }
                        }
                    })
                end,
            }
        end

    },
    {
        "neovim/nvim-lspconfig",
    }
}
