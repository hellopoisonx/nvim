local vim = vim
return {
    lsp_attach = function(_, buf)
        local opts = { buffer = buf }
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<cr>", opts)
        vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<cr>", opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        vim.keymap.set("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
        vim.keymap.set("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
        vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<cr>", opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", "<cmd>Lspsaga code_action<cr>", opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>fm", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end
}
