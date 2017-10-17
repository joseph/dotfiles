" Remove all GUI options (except right scrollbar)
set guioptions=r

" have a small-ish yet readable font:
"set guifont=*fixed*medium*semicondensed*120*iso8859-1*
set guifont=Operator_Mono:h14

" have error messages red on white
highlight ErrorMsg guibg=White guifg=Red

set autochdir

" WinManager
let g:winManagerWidth=32
WMToggle
set nu!

" window size:
set lines=85
set columns=108
