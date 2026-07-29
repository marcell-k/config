vim.diagnostic.config({
    virtual_text = false, -- Hide inline error messages
    signs = false, -- Hide gutter signs
    underline = true,
    update_in_insert = false,
})

-- Strip inactive overloads from signature help — only show the active one
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
        local orig = vim.lsp.handlers["textDocument/signatureHelp"]
        if not orig then
            return
        end
        vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
            if result and result.signatures and #result.signatures > 1 then
                local active = (result.activeSignature or 0) + 1
                result.signatures = { result.signatures[active] }
                result.activeSignature = 0
            end
            orig(err, result, ctx, config)
        end
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        if not vim.g._autosource_venv_pending then
            return
        end
        vim.g._autosource_venv_pending = false

        local venv = vim.fn.getcwd() .. "/.venv/bin/activate"
        if vim.uv.fs_stat(venv) then
            vim.api.nvim_chan_send(vim.b.terminal_job_id, "source .venv/bin/activate\n")
        end
    end,
})
