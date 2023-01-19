require('bufferline').setup({
  options = {
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true -- use a "true" to enable the default, or set your own character
        },
    }
  }
})

-- move between buffers or tabs
vim.keymap.set("n","<S-l>",vim.cmd.bnext)
vim.keymap.set("n","<S-h>",vim.cmd.bprev)
vim.keymap.set("n","<leader>bx",vim.cmd.bdelete)


