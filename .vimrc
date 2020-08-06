"============================================================================
" Hey! This is how I happen to like my Vim. Don't give me no hassle!
" - JP
"----------------------------------------------------------------------------

set nocompatible " We're running Vim, not Vi!
syntax on " Enable syntax highlighting
filetype indent plugin on " Enable filetype-specific indenting and plugins

" Let's fire an early volley in the religious war over whitespace.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set autoindent
set nofoldenable
set nowrap

" Basics of good behaviour.
set ruler
set noshowcmd " don't display incomplete commands
set showmatch
set showmode
set matchtime=1
set history=1000
set backspace=2 " Allow backspacing over autoindent, line breaks, etc
set noeb " disable the goddam error bell
set vb " awright, lets have a visual bell
set incsearch " search incrementally
set ignorecase " ignore case by default when searching
set nostartofline " don't jump to the start of line when scrolling
set background=dark

set textwidth=80
if exists("&colorcolumn")
  set colorcolumn=+1,+2,+3
endif

" UTF-8 support
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8 bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif


" ----------------------------------------------------------------------------
" Pathogen
" ----------------------------------------------------------------------------

" Load pathogen early, before we start configuring plugins.
if !empty(globpath(&rtp, 'autoload/pathogen.vim'))
  call pathogen#infect()
endif


" ----------------------------------------------------------------------------
" Backups
" ----------------------------------------------------------------------------

set nobackup " do not keep backups after close
set nowritebackup " do not keep a backup while working
set noswapfile " don't keep swp files either
set backupdir=$HOME/.vim/backup " store backups under ~/.vim/backup
set backupcopy=yes " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,. " keep swp files under ~/.vim/swap


" ----------------------------------------------------------------------------
" Functions
" ----------------------------------------------------------------------------

" Jump to the last known cursor position, unless position is invalid or
" inside an event handler (such as happens when dropping a file on gvim).
"
function! JumpToLastCursorPosition()
  if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction


" Remove trailing whitespace from files (other than markdown files).
"
function! StripTrailingWhitespace()
  if !(bufname("%") =~ '.*\.m\(ar\)\?k\?d\(own\)\?$')
    keepjumps %s/\s\+$//e
  endif
endfunction


" Open a buffer by number.
"
function! OpenBufferByNumber(n)
  exe 'silent! buffer' . a:n
endfunction


" ----------------------------------------------------------------------------
" Commands
" ----------------------------------------------------------------------------

" :SW -- sudo save the current file and tell vim to reload it
command SW exec 'w !sudo tee % >/dev/null' | e! %


command -nargs=1 B call OpenBufferByNumber(<f-args>)


" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

let mapleader = ","

" Disable some annoying mappings.
nmap <F1> <nop>
nmap K <nop>

" Leader-n -- toggle line numbers
nmap <leader>n :set nu!<CR>

" Leader-h -- toggle search highlights
nmap <leader>h :let &hlsearch=!&hlsearch<CR>

" Leader-s -- remove all trailing whitespace in file.
nmap <leader>s :call StripTrailingWhitespace()<CR>

" Leader-p -- paste the last yank (not delete)
nmap <leader>p "0p

" ----------------------------------------------------------------------------
" Auto-Commands (only processed if Vim compiled with support for autocmd).
" ----------------------------------------------------------------------------

if has("autocmd")
  " Open each file to its last known cursor position, if any.
  au BufReadPost * call JumpToLastCursorPosition()

  " Automatically remove trailing whitespace from files when saving.
  au BufWritePre * call StripTrailingWhitespace()

  " Sensible word-wrapping and up/down between lines for .txt files.
  au BufRead *\.txt setlocal syntax=off
  au BufRead *\.txt setlocal foldcolumn=2
  au BufRead *\.txt setlocal formatoptions=l
  au BufRead *\.txt setlocal lbr
  au BufRead *\.txt setlocal noai
  au BufRead *\.txt setlocal nonu
  au BufRead *\.txt setlocal display=lastline
  au BufRead *\.txt map j gj
  au BufRead *\.txt map k gk
  au BufRead *\.txt map 0 g^
  au BufRead *\.txt map ^ g^
  au BufRead *\.txt map $ g$

  " Swift is verbose, so avoid forced-wrapping
  au BufRead *\.swift setlocal textwidth=400

  " Use YAML for odstrings
  autocmd BufNewFile,BufRead *.odstrings set syntax=yaml

  " Empty indentexpr for xml-style files.
  " autocmd BufEnter *.html setlocal indentexpr=
  " autocmd BufEnter *.rhtml setlocal indentexpr=
  " autocmd BufEnter *.erb setlocal indentexpr=
  " autocmd BufEnter *.htm setlocal indentexpr=
  " autocmd BufEnter *.xml setlocal indentexpr=
  " autocmd BufEnter *.xsd setlocal indentexpr=

  " Extension-specific settings
  au BufEnter *.html,*.HTM set ai sw=2 ts=2 syntax=html
  au BufEnter *.screenplay set ai sw=2 ts=2 syntax=ruby
  au BufEnter Gemfile,Capfile,Rakefile set ai sw=2 ts=2 syntax=ruby

endif


" ----------------------------------------------------------------------------
" Colours
" ----------------------------------------------------------------------------

silent! colorscheme vividchalk
hi VertSplit guifg=#222222 guibg=#222222
hi StatusLine guifg=#666666 guibg=#222222
hi StatusLineNC guifg=#666666 guibg=#222222
hi NonText guibg=black guifg=black
hi LineNr guifg=#666666 guibg=#111111
hi Comment guifg=Magenta ctermfg=Magenta

" Show spaces at the end of lines
hi RedundantSpaces ctermbg=DarkGrey guibg=#222222
match RedundantSpaces /\s\+$/


" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------

" WinManager config

let g:winManagerWidth = 30

" Leader-w -- toggle WinManager on or off.
nmap <C-w><C-t> :WMToggle<CR>

" Jump through windows with F5, Shift-w or ww.
nmap <F5> <C-w><C-w>
nmap <leader>w <C-w><C-w>

" Jump to an explorer window with Leader-1 or Leader-2.
nmap <leader>1 :FirstExplorerWindow<CR>
nmap <leader>2 :BottomExplorerWindow<CR>
