-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Resize windows without Ctrl+Arrow (macOS Mission Control captures those)
local map = vim.keymap.set
map("n", "<leader>w>", "<cmd>vertical resize +5<cr>", { desc = "Widen Window" })
map("n", "<leader>w<", "<cmd>vertical resize -5<cr>", { desc = "Narrow Window" })
map("n", "<leader>w+", "<cmd>resize +3<cr>", { desc = "Taller Window" })
map("n", "<leader>w-", "<cmd>resize -3<cr>", { desc = "Shorter Window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize Windows" })
