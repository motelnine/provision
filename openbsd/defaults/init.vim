" Load plugins with vim-plug
call plug#begin('~/.config/nvim/bundle')
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'VundleVim/Vundle.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'mxw/vim-jsx'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dense-analysis/ale'
Plug 'isRuslan/vim-es6'
Plug 'mfussenegger/nvim-lint'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

"Plug 'wfxr/minimap.vim'
call plug#end()

" Set colorscheme
colorscheme monokai-phoenix
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

"#!/bin/bash
"mkdir -p ~/.vim/autoload ~/.vim/bundle
"curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"git clone https://github.com/lightline-ale ~/.vim/bundle/lightline-ale
"git clone https://github.com/lightline.vim ~/.vim/bundle/lightline
"git clone https://github.com/nerdtree ~/.vim/bundle/nerdtree
"git clone https://github.com/Vundle.vim ~/.vim/bundle/
"git clone https://github.com/editorconfig-vim.git ~/.vim/bundle/
"git clone https://github.com/mxw/vim-jsx.git ~/.vim/bundle/vim-jsx
"git clone https://github.com/airblade/vim-gitgutter ~/.vim/bundle/vim-gitgutter
"git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
scriptencoding utf-8
set encoding=utf-8

" execute pathogen#infect()


set mouse=
set nowrap

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required

" Nerdtree
" Start Nerdtree if `vim` is used
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Start Nerdtree if `vim foldername` is used	
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Python tabs instead of spaces
autocmd FileType python setlocal noexpandtab
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4

" Close Vim if NERDTree is the only window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" JSX syntax highlighting on jsx files only
let g:jsx_ext_required = 1

" Move nerdtree to the right
let g:NERDTreeWinPos = "right"

" Colorscheme
colorscheme monokai-phoenix

" Nerdtree Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Note : use CTRL+W X to rotate windwos

" Ctrl+N Nerdtree toggle
nnoremap <C-N> :NERDTreeToggle<CR>

" Window resize
nnoremap <C-i> <C-w>>
nnoremap <C-u> <C-w><

" Map Ctrl+k to page up
nnoremap <C-k> <C-u>
inoremap <C-k> <C-o><C-u>

" Map Ctrl+j to page down
nnoremap <C-j> <C-d>
inoremap <C-j> <C-o><C-d>

" Close Nerdtree if only window
"autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

syntax on

" Disable background opacity
hi Normal guibg=NONE ctermbg=NONE

" Toggle `set list` with <F5> key
" set listchars=eol:,tab:.\ ,trail:~,extends:>,precedes:<
set listchars=eol:·,tab:»\ ,trail:¤,extends:>,precedes:<
noremap <F5> :set list! number!<CR>
inoremap <F5> <C-o>:set list! number!<CR>
cnoremap <F5> <C-c>:set list! number!<CR>

" Toggle vertical bar between 79/100/0
function! ToggleColorColumn()
    if &colorcolumn == ""
        set colorcolumn=79
    elseif &colorcolumn == "79"
        set colorcolumn=100
    else
        set colorcolumn=
    endif
endfunction

nnoremap <F7> :call ToggleColorColumn()<CR>
inoremap <F7> <C-o>:call ToggleColorColumn()<CR>
cnoremap <F7> <C-c>:call ToggleColorColumn()<CR>


" Toggle between tabs as four spaces and tabs as tab key
function! ToggleTabs()
    if &expandtab == 1
        set noexpandtab
        set softtabstop=0
        set shiftwidth=0
        set tabstop=4
        echo "Tabs enabled"
    else
        set expandtab
        set softtabstop=4
        set shiftwidth=4
        set tabstop=4
        echo "Tabs replaced with spaces (4 spaces)"
    endif
endfunction

" Map F8 to call ToggleTabs() function in normal mode
nnoremap <silent> <F8> :call ToggleTabs()<CR>
cnoremap <silent> <F8> :call ToggleTabs()<CR>
inoremap <silent> <F8> <C-o>:call ToggleTabs()<CR>

" Write mehlp message (must press <enter> afterwards)
function! WriteMessage()
    " Define the message
    let message = "<F5>:list <F6>:num <F7>:vr <F9>:cmnt Ctrl+i:+ Ctrl+u:-"

    " Save cursor position and enter command-line mode
    let save_cursor = getpos('.')
    call feedkeys(":")

    " Write the message
    call feedkeys("echo '".message."'")

    " Restore cursor position
    call setpos('.', save_cursor)
endfunction

" Map F12 key to call the function
nnoremap <F12> :call WriteMessage()<CR>
inoremap <F12> <Esc>:call WriteMessage()<CR>

" Tab width
set tabstop=4
set shiftwidth=4
set number
set scrolloff=10
set list

" Toggle line numbers
nnoremap <F6> :set nonumber!<CR>

" let g:ale_linters = {'javascript': ['eslint']}
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

"let g:ale_linters = {'javascript': ['eslint']}
"let g:ale_linters = {'python': ['flake8', 'pylint'], 'javascript': ['eslint']}
let g:ale_linters = {'python': ['pylint'], 'javascript': ['eslint']}


" Ale
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_virtualtext_cursor=0

"" Minimap
"let g:minimap_width = 10
"let g:minimap_auto_start = 1
"let g:minimap_auto_start_win_enter = 1

"Ctrl+y for copy to clipboard in visual mode
"If this isn't working you probably have vim-minimal installed
"Install gvim
vnoremap <C-y> "+y

"setlocal spell spelllang=en_us
function! ToggleSpell()
  if &spell
    setlocal nospell
  else
    setlocal spell spelllang=en_us
  endif
endfunction

nnoremap <F4> :call ToggleSpell()<CR>
inoremap <F4> <C-O>:call ToggleSpell()<CR>
