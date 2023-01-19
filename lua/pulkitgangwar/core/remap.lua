vim.g.mapleader = " "

vim.keymap.set("i", "kj", "<Esc>")


-- move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- moves copied items into main system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])


-- when selecting and pasting something it will not add deleted item in memory
vim.keymap.set("x", "<leader>p", [["_dP]])


vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
