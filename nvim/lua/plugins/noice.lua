return {
    {
        "folke/noice.nvim",
        opts = {
            lsp = {
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true,
                        throttle = 50,
                    },
                    opts = { size = { max_height = 3 } },
                },
            },
            routes = {
                {
                    filter = {
                        event = "lsp",
                        kind = "progress",
                        any = {
                            { find = "basedpyright" },
                            { find = "pyright" },
                        },
                    },
                    opts = { skip = true },
                },
            },
        },
    },
}
