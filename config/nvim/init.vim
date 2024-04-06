" Install all plugins
call plug#begin('~/.vim/plugged')

" Appearance --- {{{

" Used for a nice status line: https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" Used for a nice colour scheme
Plug 'sainnhe/sonokai'


" }}}

" Search & Browse --- {{{

" Browse through directories: https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Power Search: https://github.com/mileszs/ack.vim
Plug 'mileszs/ack.vim'

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

" TODO: LSPs --- {{{
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
" }}}

" TODO: JS/TS/TSX/JSX
" TODO: GraphQL
" TODO: Plugin for Q sytax highlight
" Plug 'katusk/vim-qkdb-syntax'

call plug#end()


" Indentation Rules
set tabstop=4
set expandtab
set shiftwidth=2
set autoindent
set smartindent
set cindent

colorscheme sonokai

" Display relative line numbers
set number
set relativenumber

" Open FZF with Ctrl+P
nnoremap <C-p> :<C-u>:GFiles<CR>

" TODO CoC: TextEdit might fail if hiddent is not set
" set hidden

" TODO CoC: Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup

" TODO CoC: Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
" set updatetime=300

" TODO nvim-lsp: Don't pass messages to |ins-completion-menu|
" set shortmess+=c
"

" Configurations for ack.vim --- {{{
" https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/
"
" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" }}}

lua << EOF
-- Mappings
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- TODO (nvim-osc52 is not required anymore?): Clipboard mappings for osc52
local osc52 = require('osc52')
vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})
vim.keymap.set('v', '<leader>c', require('osc52').copy_visual)

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
EOF

