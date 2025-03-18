" Install all plugins
call plug#begin('~/.vim/plugged')

" Appearance --- {{{

" Used for a nice status line: https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" Used for a nice colour scheme
Plug 'sainnhe/sonokai'

" }}}

" Git --- {{{

" Call any git command with this plugin: https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

" View git modifications
Plug 'airblade/vim-gitgutter'

" }}}

" Miscellaneous -- {{{

" Trouble, for a nice error panel
Plug 'folke/trouble.nvim'

" Copy from/to clipboard made easy
Plug 'ojroques/nvim-osc52'

" }}}

" LSPs --- {{{
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" }}}


" Rust --- {{{
Plug 'rust-lang/rust.vim'
" }}}

" TODO: JS/TS/TSX/JSX
" TODO: GraphQL
" TODO: Plugin for Q sytax highlight
" Plug 'katusk/vim-qkdb-syntax'

" File System Interaction --- {{{
" File explorer
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" To be able to create files and directories
Plug 'Mohammed-Taher/AdvancedNewFile.nvim'

" Browse through directories: https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Power Search: https://github.com/mileszs/ack.vim
Plug 'mileszs/ack.vim'
" }}}

call plug#end()

" Indentation Rules
set tabstop=4
set expandtab
set shiftwidth=2
set autoindent
set smartindent
set cindent

" To be able to perform commands in the directory you have file open
set autochdir

" Color Scheme
colorscheme sonokai

" Display relative line numbers
set number
set relativenumber

" FS Interaction
nnoremap <C-q> :<C-u>:NvimTreeToggle<CR>
nnoremap <Leader>q :<C-u>:GFiles<CR>
nnoremap <Leader>Q :<C-u>:Files<CR>
nnoremap <C-n> :<C-u>:AdvancedNewFile<CR>

" let $FZF_DEFAULT_COMMAND = 'rg --files'
" Do not sort the search results
let $FZF_DEFAULT_OPTS = "--no-sort --tac --exact -i"

" TODO nvim-lsp: Don't pass messages to |ins-completion-menu|
" set shortmess+=c

" Configurations for ack.vim --- {{{
" https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/
"
" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --pcre2 --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>

" }}}

lua << EOF
-- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- TODO (nvim-osc52 is not required anymore?): Clipboard mappings for osc52
local osc52 = require('osc52')
vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gl', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>ci', vim.lsp.buf.incoming_calls, bufopts)
  vim.keymap.set('n', '<space>co', vim.lsp.buf.outgoing_calls, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
  vim.keymap.set('n', 'gr', function()
    vim.lsp.buf.code_action({ filter = function() return a.isPreferred end, apply = true})
  end, bufopts)
end

-- Configuration for the code completion engine
-- Taken from https://github.com/hrsh7th/nvim-cmp
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
   { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
-- Pyright setup
lspconfig.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  lsp_flags = lsp_flags,
  root_dir = function(fname)
    return require('lspconfig.util').find_git_ancestor(fname) or
           require('lspconfig.util').path.dirname(fname)
  end,
}
-- TS Server
lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Bash Server
lspconfig.bashls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)",
      includeAllWorkspaceSymbols = true,
    }
  }
}
-- Rust Analyzer
lspconfig.rust_analyzer.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Clangd
lspconfig.clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Trouble Setup
-- 
-- settings without a patched font or icons
require("trouble").setup{
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

-- nvim-tree setup
require("nvim-web-devicons").setup()
require("nvim-tree").setup{
  hijack_cursor = true,
  disable_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
  renderer = {
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = true,
          color = false,
        },
      },
    },
  },
  filters = {
    enable = false,
  }
}
EOF

