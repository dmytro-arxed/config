vim.o.background = "dark"
vim.o.shell = "/opt/homebrew/bin/fish"
vim.g.shiftwidth = 2
vim.g.encoding = 'UTF-8'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_banner = 0
vim.wo.wrap = false
vim.g.rooter_patterns = {
  '.git',
  'Makefile',
  '*.sln',
  'build/env.sh',
}

-- Set Neotree as the default file explorer
vim.g.explorer_open_file_with = 'neotree'
vim.g.neotree_show_hidden = 1

vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_scroll_animation_length = 0

vim.opt.termguicolors = true

local function set_custom_highlights()
  vim.api.nvim_set_hl(0, 'Todo', { fg = '#FFFF00', bold = true })
  vim.api.nvim_set_hl(0, 'FixMe', { fg = '#FF0000', bold = true })
  vim.api.nvim_set_hl(0, 'Note', { fg = '#00FFFF', bold = false })
  vim.api.nvim_set_hl(0, 'Warning', { fg = '#FFA500', bold = true })
end

local customHighlightsGroup = vim.api.nvim_create_augroup('CustomHighlightOverrides', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  group = customHighlightsGroup,
  pattern = '*',
  callback = set_custom_highlights,
  desc = 'Apply custom highlight overrides after colorscheme loads',
})

-- Optional: Uncomment the line below to apply immediately on startup too
-- set_custom_highlights()

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.termguicolors = true
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "norcalli/nvim-colorizer.lua",
    config = function ()
      require 'colorizer'.setup()
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
  {
		"trunk-io/neovim-trunk",
		lazy = false,
		config = {
		},
		main = "trunk",
		dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
	},
  -- NOTE: First, some plugins that don't require any configuration
  'ryanoasis/vim-devicons',
  'ThePrimeagen/harpoon',
  -- Git related plugins
  'airblade/vim-rooter',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function ()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  'mhinz/vim-startify',
  'mbbill/undotree',
  'tribela/vim-transparent',
  'ray-x/lsp_signature.nvim',
  {
    "mfussenegger/nvim-jdtls",
  },
  {
    "microsoft/java-debug",
  },
  {
    "microsoft/vscode-java-test",
  },
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "hrsh7th/cmp-vsnip"
  },
  {
    "hrsh7th/vim-vsnip"
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "onsails/lspkind.nvim"
  },
  {
    'sainnhe/everforest',
    config = function ()
      vim.cmd "colorscheme everforest"
    end
  },
  {
		"trunk-io/neovim-trunk",
		lazy = false,
		-- optionally pin the version
		-- tag = "v0.1.1",
		-- these are optional config arguments (defaults shown)
		config = {
			-- trunkPath = "trunk",
			-- lspArgs = {},
			-- formatOnSave = true,
                        -- formatOnSaveTimeout = 10, -- seconds
			-- logLevel = "info"
		},
		main = "trunk",
		dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  },

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
  { -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip'
  },
  },

  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
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
  },
},
{
  'iamcco/markdown-preview.nvim',
  config = function ()
    vim.fn["mkdp#util#install"]()
  end
},
{ -- Set lualine as statusline
'nvim-lualine/lualine.nvim',
-- See `:help lualine.txt`
opts = {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  },

  {
    'Pocco81/auto-save.nvim',
  },
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require'window-picker'.setup()
    end,
  }


  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
}, {})

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "tsx", "go", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
        },
        update_in_insert = true,
    }
)

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

vim.wo.relativenumber = true
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.opt.clipboard = "unnamedplus"

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {"*.tsx", "*.ts", ".js", ".jsx"},
  callback = function ()
    vim.cmd 'EslintFixAll'
  end
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = true,
        ['<C-d>'] = true,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(
require('telescope').load_extension,
'fzf',
'live_grep_args'
)


vim.keymap.set('n', '<C-l>', '<C-W>l', { desc='move right' })
vim.keymap.set('n', '<C-h>', '<C-W>h', { desc='move left' })
vim.keymap.set('n', '<C-j>', '<C-W>j', { desc='move down' })
vim.keymap.set('n', '<C-k>', '<C-W>k', { desc='move up' })

vim.keymap.set('n', '<leader>=', 'ggvG=', { desc='indente all file' })
vim.keymap.set('n', '<leader>v', ':vsplit<CR><C-W>l', { desc = 'split [V]ertically' })

vim.keymap.set('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', { desc='[H]arpoon [A]dd' })
vim.keymap.set('n', '<leader>hd', ':lua require("harpoon.mark").rm_file()<CR>', { desc='[H]arpoon [D]elete' })
vim.keymap.set('n', '<leader>hm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc='[H]arpoon [M]enu' })

vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>l', ':noh<CR>', { desc = 'remove high[L]ight', silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree position=float reveal=true<CR>', { desc = '[E]xplorer here' })
vim.keymap.set('n', '<leader>fe', ':vsplit<CR><C-w>l<C-\\><C-n><C-W>h:Neotree position=current reveal=true<CR>', { desc = '[E]xplorer here' })
vim.keymap.set('n', '<leader>.e', ':Neotree position=current reveal=true<CR>', { desc = '[E]xplorer here' })


-- begin Terminal
vim.keymap.set('t', '<leader>q', '<C-\\><C-n>:q<CR>', { desc = 'Quit insert mode in terminal' })

vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-W>l', { desc='move right' })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-W>h', { desc='move left' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-W>j', { desc='move down' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-W>k', { desc='move up' })

vim.keymap.set('n', '<leader>tv', ':vsplit<CR><C-W>l:terminal<CR>i', { desc = '[T]erminal [V]ertical' })
vim.keymap.set('n', '<leader>th', ':split<CR><C-W>j:terminal<CR>i', { desc = '[T]erminal [H]orizontal' })
vim.keymap.set('n', '<leader>tt', ':tabnew<CR>:terminal<CR>i', { desc = '[T]erminal [T]ab' })
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { desc = "toggle [U]ndotree" })
-- end Terminal

vim.keymap.set('n', '<leader>td', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = '[T]rouble [D]ocument' })

vim.keymap.set('n', '<leader>bn', ':tabNext<CR>', { desc = '[B]uffer [N]ext' })
vim.keymap.set('n', '<leader>bp', ':tabprevious<CR>', { desc = '[B]uffer [P]revious' })
vim.keymap.set('n', '<leader>bx', ':tabclose<CR>', { desc = '[B]uffer [X]close' })
vim.keymap.set('n', '<leader>bc', ':tabnew<CR>', { desc = '[B]uffer [C]reate' })

-- See `:help telescope.builtin`
--
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = '[S]earch [R]ecent files' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[S]earch [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostic' })
vim.keymap.set('n', '<leader>sv', require('telescope.builtin').lsp_document_symbols, { desc = '[S]earch [V]ariables' })

vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('ga', vim.diagnostic.open_float, 'Open Diagnostics')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  lua_ls = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        }
      },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local lspconfig = require('lspconfig')

require("mason").setup()
require("mason-lspconfig").setup {
    automatic_enable = {
        "lua_ls",
        "vimls",
        "typescript-language-server", 
        "ts_ls",
        "jsonls"
    }
}


lspconfig.ts_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- ... other servers
lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            buildFlags = { "-tags=wireinject" },
            gofumpt = true,
            codelenses = {
                gc_references = true,
                generate = true,
                test = true,
            },
            hints = {
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                assignVariableTypes = true,
            },
            analyses = {
                fieldalignment = true,
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
                usesgenerics = true,
            },
            usePlaceholders = true,
            staticcheck = true,
            directoryFilters = {"-vendor"},
        },
    },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

local lspkind = require 'lspkind'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      before = function (_, vim_item)
        return vim_item
      end
    })
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' }
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

