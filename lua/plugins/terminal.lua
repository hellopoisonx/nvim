return {
    {
        {
            'akinsho/toggleterm.nvim',
            enabled = false,
            version = "*",
            lazy = true,
            keys = {
                {"<leader>t", "ToggleTerm direction=float", desc="open a float terminal"}
            },
            config = true
        }
    }
}
