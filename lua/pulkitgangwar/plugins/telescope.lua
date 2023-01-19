local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n','<leader>gd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fx', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)


require("telescope").load_extension("neoclip");
