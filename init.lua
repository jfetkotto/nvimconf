-- init.lua

-- {{{ Plugin
require "paq" {
        "savq/paq-nvim";
        "nvim-lualine/lualine.nvim";
        "neovim/nvim-lspconfig";
        "preservim/nerdtree";
        "jiangmiao/auto-pairs";
        "hrsh7th/nvim-cmp";
        "hrsh7th/cmp-nvim-lsp";
        "hrsh7th/cmp-buffer";
        "hrsh7th/cmp-path";
        "tpope/vim-fugitive";
        "saadparwaiz1/cmp_luasnip";
        "L3MON4D3/LuaSnip";
        "ntpeters/vim-better-whitespace";
        "lewis6991/gitsigns.nvim";
        "numToStr/Comment.nvim";
        "nvim-treesitter/nvim-treesitter";
        "nvim-lua/plenary.nvim";
        "folke/todo-comments.nvim";
        -- Colourschemes
        "catppuccin/nvim";
        "sainnhe/everforest";
        "junegunn/seoul256.vim";
        "NLKNguyen/papercolor-theme";
}
-- }}}

-- {{{ Settings
vim.wo.foldmethod = "marker"
vim.o.relativenumber = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = false
vim.o.smartcase = false
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.colorcolumn = "80"
vim.o.clipboard = "unnamedplus"
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.bo.softtabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.termguicolors = true
vim.g.rainbow_active = 1
vim.o.completeopt = 'menu,menuone,noselect'
vim.g.better_whitespace_enabled = 1
vim.wo.wrap = false
vim.api.nvim_set_hl(0, 'Comment', { italic=true })
-- }}}

-- {{{ Disable various builtin plugins in Vim that bog down speed
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1
-- }}}

-- Space as leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('n', '<leader><Tab>', ':bn<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':bdelete<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':NERDTreeToggle<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<CR>', ':noh<CR><CR>', {noremap = true})

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Oooops :W -> :w
vim.cmd "command! W noautocmd w"

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Remove whitespace on save
vim.cmd "autocmd BufWritePre * %s/\\s\\+$//e"

-- Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },

  on_attach = function(buffnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = buffnr
      vim.keymap.set(mode, l, r, opts)
    end

        -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- todo-comments
require("todo-comments").setup {
  signs = false,
  sign_priority = 8,
  keywords = {
    FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning" },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX"} },
  },
  gui_style = {
    fg = "NONE",
    bg = "BOLD",
  },
  merge_keywords = true,
    highlight = {
    multiline = true,
    multiline_pattern = "^.",
    multiline_context = 10,
    before = "",
    keyword = "wide",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*:]],
    comments_only = true,
    max_line_len = 400,
    exclude = {},
  },
  -- colors = {
  --   error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
  --   warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
  --   info = { "DiagnosticInfo", "#2563EB" },
  --   hint = { "DiagnosticHint", "#10B981" },
  --   default = { "Identifier", "#7C3AED" },
  --   test = { "Identifier", "#FF00FF" }
  -- },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}


-- {{{ Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "vim", "rust" },
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  highlight = {
    enable = true,

    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if (ok and stats and stats.size > max_filesize) or (lang == "verilog")  then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,
  },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
}
-- }}}

-- {{{ LSPs
local lspconfig = require 'lspconfig'
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'svls', 'clangd', 'rust_analyzer' }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
-- }}}

-- luasnip
local luasnip = require 'luasnip'

-- {{{ nvim-cmp
local cmp = require 'cmp'
require("luasnip/loaders/from_vscode").load({ paths = "./snippets" })

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})
-- }}}

-- -- Comment <gc> to comment
require('Comment').setup()

--  {{{ lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'filename'}
  },
  extensions = {}
}
-- }}}

-- {{{ Filetype specific settings
local utils = require('utils')
utils.create_augroup({
  {'FileType', '*', 'setlocal', 'shiftwidth=2', 'tabstop=2'},
  {'FileType', 'rust', 'setlocal', 'shiftwidth=4', 'tabstop=4'},
  {'FileType', 'lua', 'setlocal', 'shiftwidth=4', 'tabstop=4'},
  {'FileType', 'c', 'setlocal', 'shiftwidth=8', 'tabstop=8', 'noexpandtab'},
  {'Filetype', 'cpp', 'setlocal', 'shiftwidth=8', 'tabstop=8', 'noexpandtab'},
  {'FileType', 'python', 'setlocal', 'shiftwidth=4', 'tabstop=4'},
  {'FileType', 'make','setlocal', 'softtabstop=0'},
  {'FileType', 'make', 'setlocal', 'noexpandtab'}
}, 'Tab2')
-- }}}

vim.cmd[[colorscheme everforest]]
