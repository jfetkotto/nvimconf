-- init.lua
-- samuel.mitchell@nordicsemi.no
-- Jan 2022

require ('base') -- Basic Vim settings
require ('keymap')
require ('filetypes')


require "paq" {
        "savq/paq-nvim";
        "nvim-lualine/lualine.nvim";
        "terryma/vim-multiple-cursors";
        "neovim/nvim-lspconfig";
        "preservim/nerdtree";
        "jiangmiao/auto-pairs";
        "airblade/vim-gitgutter";
        "hrsh7th/nvim-cmp";
        "hrsh7th/cmp-nvim-lsp";
        "hrsh7th/cmp-buffer";
        "hrsh7th/cmp-path";
        "hrsh7th/cmp-cmdline";
        "hrsh7th/cmp-vsnip";
        "hrsh7th/vim-vsnip";
        "ntpeters/vim-better-whitespace";
        -- Colourschemes
        "folke/tokyonight.nvim";
        "junegunn/seoul256.vim"
}
-- LSPs
local servers = { 'svls', 'rust_analyzer', 'clangd' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1

vim.g.rainbow_active = 1
-- Colors
--vim.g.tokyonight_style = "storm"
--vim.cmd[[colorscheme tokyonight]]
vim.cmd[[colorscheme seoul256]]

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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

