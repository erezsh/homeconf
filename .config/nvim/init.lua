-- Requirements:
--  - ripgrep (for fzf)
--  - cmake   (for fzf)
--  - gcc / zig / ...
--  - nerdfonts

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- disable netrw at the very start of your init.lua
-- See https://github.com/nvim-tree/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

-- Setup plugins
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {'nvim-lua/plenary.nvim'},
  {'tpope/vim-repeat'},
  {'tpope/vim-surround'},
  {'echasnovski/mini.nvim', version = '*',
    config = function()
      -- require('mini.animate').setup()
      require('mini.ai').setup()
      require('mini.basics').setup()
      require('mini.bracketed').setup()
      require('mini.indentscope').setup {symbol = '·' }
      require('mini.move').setup()
      require('mini.splitjoin').setup()
      -- require('mini.surround').setup()
      require('mini.tabline').setup()
      require('mini.trailspace').setup()
    end
  },
  {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
			config = function()
				require("lualine").setup {}
			end,

  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional
      { 'j-hui/fidget.nvim', opts = {} },   -- optional progress
      'folke/neodev.nvim',  -- neovim dev completions

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  },
  { 'nvim-tree/nvim-web-devicons' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
  -- or                              , branch = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {'akinsho/toggleterm.nvim', version = "*", config = true,
    opts={
        open_mapping = [[<c-\>]]
    }},
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup {}
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cond = function() return true end,
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          end
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup { multi_windows = true, }
    end
  },
  {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Auto mkdir when saving
  'jghauser/mkdir.nvim',

  -- Open URLs
  "axieax/urlview.nvim",

  -- Smooth scrolling
  {'karb94/neoscroll.nvim',
    opts = {}
  },

  -- Searchable Cheatsheet
  {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      {'nvim-telescope/telescope.nvim'},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- Notify UI
  'rcarriga/nvim-notify',

  -- Window management improvement ?
  { "beauwilliams/focus.nvim", config = function() require("focus").setup() end },

  -- Vim sugar for UNIX shell commands
  "tpope/vim-eunuch",

  {'RRethy/vim-illuminate'},

  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
    config = function()
      require('toggle_lsp_diagnostics').init()
    end
  },
  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    },
    config = function()
      require('refactoring').setup({})
    end,
  },
  {
  'gelguy/wilder.nvim',
  config = function()
    require('wilder').setup({modes = {':', '/', '?'}})
  end,
  },
  {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  },
  {
    'tzachar/highlight-undo.nvim',
    config = function()
      require('highlight-undo').setup({})
    end
  },

  -- Color schemes
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim"
  },

  -- NOTE: Make sure barbecue loads after your colorscheme.
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
})

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- Setup bindings for cmp
local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<Right>'] = cmp.mapping.confirm({select = false}),
    ['<Enter>'] = cmp.mapping.confirm({select = false}),
  }
})


-- Preferences & Settings
vim.cmd.colorscheme("kanagawa-dragon")

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope.find_files, { desc = "Find files"})
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = "Find files"})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = "Live Grep"})
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = "Search Buffers"})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = "Search help tags"})
vim.keymap.set('n', '<leader>gf', telescope.git_files, { desc = 'Search [G]it [F]iles' })


vim.keymap.set('n', '<c-h>', "<cmd>lua require'hop'.hint_words()<cr>", {})


vim.keymap.set("n", "<leader>u", "<Cmd>UrlView<CR>", { desc = "View buffer URLs" })
vim.keymap.set("n", "<leader>U", "<Cmd>UrlView packer<CR>", { desc = "View Packer plugin URLs" })


-- Case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.magic = true
vim.opt.gdefault = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.scrolloff = 3

-- Options taken from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L66
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Add various shortcuts (https://www.reddit.com/r/neovim/comments/13y3thq/whats_a_very_simple_config_change_that_you_cant/)
vim.api.nvim_set_keymap("i", "<C-BS>", "<Esc>cvb", {silent=true, desc="Erase word backwards"})
vim.api.nvim_set_keymap("n", "<C-CR>", "ciw", {desc="Change current word"})
vim.api.nvim_set_keymap("n", "<CR>", "o<Esc>", {desc="New line"})
-- Use <Tab> to cycle through buffers in tab
-- vim.api.nvim_set_keymap('n', '<Tab>', '<C-W>w', {silent=true, desc="Next window"});
vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-W>W', {silent=true, desc="Prev window"});
vim.api.nvim_set_keymap("n", "<leader>;", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", {})


local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Incremental Rename" })

vim.cmd 'source ~/.config/nvim/keymaps.vim'

-- refactoring.nvim - Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap(
    "v",
    "<leader>rr",
    ":lua require('refactoring').select_refactor()<CR>",
    { noremap = true, silent = true, expr = false }
)
vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n>", {silent=true, desc="Close terminal into normal mode"})
