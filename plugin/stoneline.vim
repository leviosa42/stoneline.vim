" FileName: plugin/stoneline.vim
" Author:   leviosa42

let s:save_cpo = &cpoptions
set cpoptions&vim

if exists('g:loaded_stoneline') && g:loaded_stoneline
  finish
endif
let g:loaded_stoneline = 1


let g:stoneline = {}
let g:stoneline.feat_mode_hl_termansicolors = 0
let g:stoneline.mode_title = {
  \ 'n':      ['N', 'NORMAL'],
  \ 'v':      ['V', 'VISUAL'],
  \ 'V':      ['VL', 'V-LINE'],
  \ "\<C-v>": ['VB', 'V-BLOCK'],
  \ 's':      ['S', 'SELECT'],
  \ 'S':      ['SL', 'S-LINE'],
  \ "\<C-s>": ['SB', 'S-BLOCK'],
  \ 'i':      ['I', 'INSERT'],
  \ 'R':      ['R', 'REPLACE'],
  \ 'c':      ['C', 'COMMAND'],
  \ 't':      ['T', 'TERMINAL']
  \ }
let g:stoneline.mode_highlight = {
  \ 'normal':   [[0, 12-8], 'Constant'],
  \ 'insert':   [[0, 10-8], 'Identifier'],
  \ 'visual':   [[0, 13-8], 'Statement'],
  \ 'select':   [[0, 9-8], 'PreProc'],
  \ 'replace':  [[0, 11-8], 'Type'],
  \ 'command':  [[0, 12-8], 'Constant'],
  \ 'terminal': [[0, 14-8], 'Special'],
  \ 'inactive': [[0, 8], 'Comment'],
  \ 'ignore':   [[15, 0], 'Ignore']
  \ }
let g:stoneline.UseMinimalChecker = { -> winwidth(0) < 70 }

set laststatus=2
call stoneline#define_mode_highlight(g:stoneline.feat_mode_hl_termansicolors)
set statusline=%!stoneline#create_active_statusline()
augroup stoneline
  autocmd!
  autocmd BufEnter,WinEnter * setlocal statusline=%!stoneline#create_active_statusline()
  autocmd Bufleave,WinLeave * setlocal statusline=%!stoneline#create_active_statusline()
augroup END

let &cpoptions = s:save_cpo
unlet! s:save_cpo

" vim: set ft=vim ts=2 sts=-1 sw=0 et fdm=marker fmr={{{,}}} cms="\ %s:
"
