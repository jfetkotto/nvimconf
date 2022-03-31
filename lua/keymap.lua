local map = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }

vim.g.mapleader = ' '
map('n', '<Space>', '<NOP>', {noremap = true, silent = true})


-- Hardmode
map('n', '<Up>', '<NOP>', {noremap = true})
map('n', '<Down>', '<NOP>', {noremap = true})
map('n', '<Left>', '<NOP>', {noremap = true})
map('n', '<Right>', '<NOP>', {noremap = true})

map('i', '<Up>', '<NOP>', {noremap = true})
map('i', '<Down>', '<NOP>', {noremap = true})
map('i', '<Left>', '<NOP>', {noremap = true})
map('i', '<Right>', '<NOP>', {noremap = true})


map('n', '<PageDown>', '<NOP>', {noremap = true})
map('n', '<PageUp>', '<NOP>', {noremap = true})
map('i', '<PageUp >', '<NOP>', {noremap = true})
map('i', '<PageDown>', '<NOP>',{noremap = true})

map('n', '<leader>w', ':bn<CR>', {noremap = true})
map('n', '<leader>q', ':bdelete<CR>', {noremap = true})

map('n', '<C-f>', ':NERDTreeToggle<CR>', {noremap = true})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end
