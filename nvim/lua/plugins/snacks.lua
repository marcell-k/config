return {
    {
        "folke/snacks.nvim",
        opts = {
            -- 1. Fixes the cursor issue by disabling word highlights in Insert Mode
            words = {
                modes = { "n", "c" },
            },
            -- 2. Completely removes all vertical indent lines and scope guides
            indent = {
                enabled = false,
            },
        },
    },
}
