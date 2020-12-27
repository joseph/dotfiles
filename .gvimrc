" Remove all GUI options (except right scrollbar)
set guioptions=r

" have a small-ish yet readable font:
"set guifont=*fixed*medium*semicondensed*120*iso8859-1*
set guifont=Operator_Mono_Book:h14

" have error messages red on white
highlight ErrorMsg guibg=White guifg=Red

" Show hidden characters
:set list
":set listchars=tab:▸\ ,eol:¬,trail:•,nbsp:␣
:set listchars=tab:▸\ ,trail:•,nbsp:␣

set autochdir

" WinManager
let g:winManagerWidth=40
WMToggle
set nu!

" window size:
set lines=86
set columns=154
