-- after/nvlime.lua
require('cmp').setup.filetype({ 'lisp' }, {
    sources = {
        { name = 'nvlime' },
        { name = 'buffer' },
        { name = 'path' },
    }
})

vim.g.nvlime_mappings = vim.tbl_deep_extend("force", vim.g.nvlime_mappings or {}, {
    global = {
        normal = {
            scroll_up = "<C-u>",   -- Change this to avoid conflict with your existing mappings
            scroll_down = "<C-d>", -- Change this to avoid conflict with your existing mappings
            -- Add other global mappings you care about
            close_current_window = "q",
            keymaps_help = { "<F1>", "<LocalLeader>?" },
            close_nvlime_windows = "<LocalLeader>ww",
            close_floating_window = "<Esc>",
            split_left = "<C-b>h",
            split_right = "<C-b>l",
            split_above = "<C-b>k",
            split_below = "<C-b>j"
        }
    }
})
