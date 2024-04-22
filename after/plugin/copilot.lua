local function disable()
    vim.cmd("Copilot disable")
end
local function enable()
    vim.cmd("Copilot enable")
end
vim.keymap.set("n", "<leader>cd", disable, { description = "Disable Copilot" })
vim.keymap.set("n", "<leader>ce", enable, { description = "Enable Copilot" })
