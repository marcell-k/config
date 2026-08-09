local FALLBACK_PYTHON = vim.fn.expand("~/.local/share/nvim-venv/bin/python")

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = { enabled = false },

                basedpyright = {
                    -- 1. Nest configurations properly under the 'settings' table
                    settings = {
                        basedpyright = {
                            analysis = {
                                pythonVersion = "3.14",
                                typeCheckingMode = "standard",
                                diagnosticMode = "openFilesOnly",
                                watchFiles = false, -- Crucial: Stops the LSP from choking on .venv file watching
                                exclude = {
                                    ".venv",
                                    ".git",
                                    "__pycache__",
                                    ".env",
                                    ".ruff_cache",
                                    ".cache",
                                    "cache",
                                    "data",
                                    "pytest_cache",
                                    "dist",
                                },
                            },
                        },
                    },

                    -- 2. Directly target .venv in the root directory
                    before_init = function(_, config)
                        local root = config.root_dir or vim.uv.cwd()
                        local candidate = root .. "/.venv/bin/python"

                        -- If .venv exists, use it. Otherwise, use your fallback.
                        local python_path = vim.uv.fs_stat(candidate) and candidate or FALLBACK_PYTHON

                        -- Safely inject the path into the initial configurations
                        config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                            python = { pythonPath = python_path },
                        })
                    end,
                },
                gopls = {},
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            check = { command = "clippy" },
                        },
                    },
                },
            },
        },
    },
}
