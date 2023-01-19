

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
    git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
