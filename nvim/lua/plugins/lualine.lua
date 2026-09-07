return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local lualine = require("lualine")
            local theme = require("kanagawa.colors").setup().theme

            local colors = {
                bg = theme.ui.bg_m3,
                fg = theme.ui.fg,
                yellow = theme.diag.warning,
                cyan = theme.diag.info,
                darkblue = theme.ui.bg_p1, -- The lighter background for the mode pill
                green = theme.diag.ok,
                orange = theme.syn.number,
                violet = theme.syn.keyword,
                magenta = theme.syn.statement,
                blue = theme.syn.fun,
                red = theme.diag.error,
                transparent = theme.ui.bg,
            }

            local conditions = {
                buffer_not_empty = function()
                    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
                end,
                hide_in_width = function()
                    return vim.fn.winwidth(0) > 80
                end,
            }

            local config = {
                options = {
                    component_separators = "",
                    section_separators = "",
                    theme = {
                        normal = { c = { fg = colors.fg, bg = colors.bg } },
                        inactive = { c = { fg = colors.fg, bg = colors.bg } },
                    },
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {},
                    lualine_x = {},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_y = {},
                    lualine_z = {},
                    lualine_c = {},
                    lualine_x = {},
                },
            }

            local function ins_left(component)
                table.insert(config.sections.lualine_c, component)
            end
            local function ins_right(component)
                table.insert(config.sections.lualine_x, component)
            end

            local mode_names = {
                n = "N",
                i = "I",
                v = "V",
                [""] = "V",
                V = "V",
                c = "C",
                no = "N",
                s = "S",
                S = "S",
                [""] = "S",
                ic = "I",
                R = "R",
                Rv = "R",
                cv = "EX",
                ce = "EX",
                r = "R",
                rm = "M",
                ["r?"] = "?",
                ["!"] = "!",
                t = "T",
            }

            local mode_color = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [""] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [""] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.red,
                t = colors.red,
            }

            -- ==========================================
            -- LEFT SIDE COMPONENTS
            -- ==========================================

            ins_left({
                function()
                    return " "
                end,
                color = { bg = colors.transparent },
                padding = 0,
            })

            -- 1. Left Rounded Edge (Outer transparent -> Inner Pill color)
            ins_left({
                function()
                    return ""
                end,
                color = { fg = colors.darkblue, bg = colors.transparent },
                padding = 0,
            })

            -- 2. The Demon Mode Pill (Icon + Letter)
            ins_left({
                function()
                    return " " .. (mode_names[vim.fn.mode()] or "N")
                end,
                color = function()
                    return { fg = mode_color[vim.fn.mode()] or colors.red, bg = colors.darkblue, gui = "bold" }
                end,
                padding = { left = 0, right = 0 },
            })

            -- 3. Right Rounded Edge (Inner Pill color -> Main Bar background)
            ins_left({
                function()
                    return ""
                end,
                color = { fg = colors.darkblue, bg = colors.bg },
                padding = { left = 0, right = 1 },
            })

            -- Dimmed Directory Path
            ins_left({
                function()
                    local dir = vim.fn.expand("%:~:.:h")
                    if dir == "" or dir == "." then
                        return " "
                    end
                    return " " .. dir .. "/"
                end,
                cond = conditions.buffer_not_empty,
                color = { fg = theme.ui.fg_dim },
                padding = { left = 1, right = 0 },
            })

            ins_left({ "filetype", icon_only = true, colored = true, padding = { left = 1, right = 0 } })

            ins_left({
                "filename",
                path = 0,
                symbols = { modified = "", readonly = "", unnamed = "" }, -- This removes the [+]
                cond = conditions.buffer_not_empty,
                color = { fg = colors.fg, gui = "bold" },
                padding = { left = 0, right = 1 },
            })

            -- Diagnostics
            ins_left({
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " " },
                diagnostics_color = {
                    error = { fg = colors.red },
                    warn = { fg = colors.yellow },
                    info = { fg = colors.cyan },
                },
                padding = { left = 0, right = 1 },
            })

            -- The spacer that pushes everything else to the right
            ins_left({
                function()
                    return "%="
                end,
            })

            -- ==========================================
            -- RIGHT SIDE COMPONENTS
            -- ==========================================

            ins_right({
                "branch",
                icon = "",
                color = { fg = colors.orange, gui = "bold" },
            })

            ins_right({
                function()
                    return ""
                end,
                color = { fg = colors.bg, bg = colors.transparent },
                padding = 0,
            })
            ins_right({
                function()
                    return " "
                end,
                color = { bg = colors.transparent },
                padding = 0,
            })

            lualine.setup(config)
        end,
    },
}
