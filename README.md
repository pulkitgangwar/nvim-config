I have been using vim motions with vscode for about a year now. Recently I switched to Neovim for my editor. This is my configuration for Neovim. I also use Tmux with Neovim but I will cover it in another blog.

This is what Neovim looks like without configuration.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1673863492212/5d0f727c-d2b2-4bd1-9d52-bb6f9c026bf7.png)

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039874616/3a923c2f-9574-4010-85b7-7d71dfeb7728.gif)

We will convert it to this.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1673863533545/246048ac-1a34-44aa-a480-91565749a89a.png)

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039896133/d6931d07-364d-402a-b029-9c07bafaa649.gif)

> Configuration is available on my GitHub repository. ([Link](https://github.com/pulkitgangwar/nvim-config))

Let's first install Neovim on our system. We will be using Lua for configuration.

```bash
brew install neovim
```

> Brew installation only works for mac devices. If you have any other device you can refer to Neovim documentation. ([Link](https://github.com/neovim/neovim/wiki/Installing-Neovim))

Now we have to create a `nvim` directory inside `.config` directory. The path will be `~/.config/nvim` . When Neovim executes, it will find configuration files in this folder. Neovim will search for `init.lua` file.

> For Windows users, the configuration location will be `C:\User\username\AppData\Local\nvim` .

The file structure will be -

```plaintext
.
└── .config/
    └── nvim/
        ├── init.lua
        └── lua/
            └── pulkitgangwar/
                ├── core/
                │   ├── options.lua
                │   ├── remap.lua
                │   └── colorscheme.lua
                ├── plugins/
                │   └── //all-plugins-setup-files
                └── plugins-setup.lua
```

Let's start with adding remaps and options for Neovim.

`/lua/pulkitgangwar/core/options.lua`

```javascript
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
```

`/lua/pulkitgangwar/core/remap.lua`

```javascript
vim.g.mapleader = " "

vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("x", "<leader>p", [["_dP]])


vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
```

After adding options and remaps we have to import these files in our `init.lua` file.

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039654478/f53dc53f-111e-4ad9-b142-8da90242a811.gif  )

The first configuration we will do is for the plugin manager. We will use packer as our plugin manager.

`/lua/pulkitgangwar/plugins-setup.lua` (Packer installation)

```javascript
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

end)
```

Save the file with `:w` and reopen `plugins-setup.lua` file. Execute `:PackerSync` to sync all the packages inside the startup function.

The following script will install some plugins for different use cases.

```javascript
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

     -- file explorer
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- color scheme
    use 'folke/tokyonight.nvim'

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync =    true })
        end,
    })

    -- movement between splits
    use "christoomey/vim-tmux-navigator"

    -- buffer line support
    use "akinsho/bufferline.nvim"
    
    -- auto pairs
    use "windwp/nvim-autopairs"

    -- bottom informative line
    use 'nvim-lualine/lualine.nvim'

end)
```

`nvim-tree` : It is a file explorer. Neovim has `netrw` but we will remove it to use `nvim-tree`

`nvim-web-devicons` : This plugin will show different icons. Remember to have patched fonts installed for your terminal.

`telescope` : This plugin helps with fuzzy findings.

`tokyonight` : This is the colour scheme for our editor.

`treesitter` : It helps in syntax highlighting.

`vim-tmux-navigator` : It helps in moving between splits.

`bufferline` : It helps to show all the current opened buffers.

`nvim-autopairs` : It helps in auto-closing brackets, quotations etc.

`lualine` : It helps to show the bottom activity bar, like vs code.

Now we have to set up these plugins. To set up plugins, we will follow some steps. The first step is to install the plugin. After that, we have to create a file for that plugin.

`/lua/pulkitgangwar/plugins/nvim-tree.lua` (nvim-tree setup)

```javascript
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
    git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
```

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
require("pulkitgangwar.plugins.nvim-tree")
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039687685/364b88b4-2805-4c3f-ab82-1f3c07b4f876.gif  )

`/lua/pulkitgangwar/core/colorscheme.lua`

```javascript
vim.o.background = "dark" 

vim.cmd([[colorscheme tokyonight]])
```

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
require("pulkitgangwar.core.colorscheme")
require("pulkitgangwar.plugins.nvim-tree")
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039716422/b211dd8d-fa04-4730-a218-49742d11554e.gif  )

`/lua/pulkitgangwar/plugins/telescope`

```javascript
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n','<leader>gd', builtin.diagnostics, {})
```

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
require("pulkitgangwar.core.colorscheme")
require("pulkitgangwar.plugins.nvim-tree")
require("pulkitgangwar.plugins.telescope")
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039747838/9253ad21-63d8-44ab-ae38-b41c01a93a82.gif  )

`/lua/pulkitgangwar/plugins/nvim-treesitter.lua`

```javascript
local treesitter_status,treesitter = pcall(require,"nvim-treesitter.config")

if not treesitter_status then print("treesitter not found") return end

treesitter.setup({
  ensure_installed = { "help", "javascript", "typescript", "c", "lua", "rust" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
```

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
require("pulkitgangwar.core.colorscheme")
require("pulkitgangwar.plugins.nvim-tree")
require("pulkitgangwar.plugins.telescope")
require("pulkitgangwar.plugins.nvim-treesitter")
```

`/lua/pulkitgangwar/plugins/bufferline.lua`

```javascript
require('bufferline').setup({
  options = {
    offsets = {
        {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true 
        },
    }
  }
})

-- move between buffers or tabs
vim.keymap.set("n","<S-l>",vim.cmd.bnext)
vim.keymap.set("n","<S-h>",vim.cmd.bprev)
```

`/lua/pulkitgangwar/plugins/nvim-autopairs.lua`

```javascript
require("nvim-autopairs").setup()
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039776312/47af102c-3ef1-4b1d-974c-ec4c03100c36.gif  )

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
require("pulkitgangwar.core.colorscheme")
require("pulkitgangwar.plugins.nvim-tree")
require("pulkitgangwar.plugins.telescope")
require("pulkitgangwar.plugins.nvim-treesitter")
require("pulkitgangwar.plugins.nvim-autopairs")
```

`/lua/pulkitgangwar/plugins/lualine.lua`

```javascript
require("lualine").setup({
    options = {
        theme = "tokyonight",
    },
})
```

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
require("pulkitgangwar.core.colorscheme")
require("pulkitgangwar.plugins.nvim-tree")
require("pulkitgangwar.plugins.telescope")
require("pulkitgangwar.plugins.nvim-treesitter")
require("pulkitgangwar.plugins.nvim-autopairs")
require("pulkitgangwar.plugins.lualine")
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039806859/38f61a3f-0d7b-4c06-9886-01e02f9454eb.gif  )

Now we will work on LSP and suggestions. It was very difficult for me to set up LSP so I used a great plugin that abstracts most things. The name of the plugin is `lsp-zero` .

`/lua/pulkitgangwar/plugin-setup.lua`

```javascript
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

     -- file explorer
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    -- fuzzy finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- color scheme
    use 'folke/tokyonight.nvim'

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync =    true })
        end,
    })

    -- movement between splits
    use "christoomey/vim-tmux-navigator"

    -- buffer line support
    use "akinsho/bufferline.nvim"
    
    -- auto pairs
    use "windwp/nvim-autopairs"

    -- bottom informative line
    use 'nvim-lualine/lualine.nvim'


    -- lsp, snippets, autocomplete
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
end)
```

`/lua/pulkitgangwar/plugins/lsp.lua`

```javascript
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd.LspStop('eslint')
      return
  end

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
```

`~/.config/nvim/init.lua`

```javascript
require("pulkitgangwar.core.options")
require("pulkitgangwar.core.remap")
require("pulkitgangwar.core.colorscheme")
require("pulkitgangwar.plugins.nvim-tree")
require("pulkitgangwar.plugins.telescope")
require("pulkitgangwar.plugins.nvim-treesitter")
require("pulkitgangwar.plugins.nvim-autopairs")
require("pulkitgangwar.plugins.lualine")
require("pulkitgangwar.plugins.lsp")
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1674039824482/3071aa46-01c8-4973-9665-e203d55a3bca.gif  )

> You can read more about every plugin from their repositories.
> 
> [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua), [telescope](https://github.com/nvim-telescope/telescope.nvim), [tokyonight](https://github.com/folke/tokyonight.nvim), [treesitter](https://github.com/nvim-treesitter/nvim-treesitter), [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator), [bufferline](https://github.com/akinsho/bufferline.nvim), [nvim-autopairs](https://github.com/windwp/nvim-autopairs), [lualine](https://github.com/nvim-lualine/lualine.nvim)
