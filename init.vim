" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

call plug#begin()

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'EdenEast/nightfox.nvim'

"competitest
Plug 'MunifTanjim/nui.nvim'        " it's a dependency
Plug 'xeluxee/competitest.nvim'
Plug 'ryanoasis/vim-devicons'

" Plugin para autocompletar
Plug 'hrsh7th/nvim-cmp'               " Núcleo do nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'           " Integração com LSP
Plug 'hrsh7th/cmp-buffer'             " Sugestões do buffer atual
Plug 'hrsh7th/cmp-path'               " Completar caminhos de arquivos

" Plugin para gerenciar LSP
Plug 'neovim/nvim-lspconfig'          " Configuração do LSP

Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'

Plug 'tpope/vim-fugitive'

call plug#end()

lua << END
require('lualine').setup()
END

lua << EOF
require('competitest').setup {
  runner_ui = {
    interface = "split",
  },
  split_ui = {
    position = "right",
    relative_to_editor = true,
    total_width = 0.3,
    total_height = 0.4,
    horizontal_layout = {
      { 2, "tc" },
      { 3, { { 1, "so" }, { 1, "si" } } },
      { 3, { { 1, "eo" }, { 1, "se" } } },
    },
    vertical_layout = {
      { 1, "tc" },
      { 1, { { 1, "so" }, { 1, "eo" } } },
      { 1, { { 1, "si" }, { 1, "se" } } },
    },
  },
}
EOF

" Turn F4 into a keymap to compile and run certain files.
autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

" Mapear Ctrl+PageUp para o próximo buffer
nnoremap <C-PageUp> :bnext<CR>

" Mapear Ctrl+PageDown para o buffer anterior
nnoremap <C-PageDown> :bprev<CR>

lua << EOF
-- Configurar LSP
local lspconfig = require('lspconfig')

-- Configuração para clangd (C++)
lspconfig.clangd.setup{}

-- Configuração do nvim-cmp
local cmp = require'cmp'

cmp.setup({
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }
})
EOF

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * if exists(':NERDTree') | NERDTree | endif

" Enable line number
:set number

"theme
colorscheme nordfox

set encoding=utf-8
