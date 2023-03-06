" FileName: autoload/stoneline.vim
" Author:   leviosa42

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:stoneline = g:stoneline

function! stoneline#define_mode_highlight(use_termansicolor) abort " {{{
  let mhl = g:stoneline.mode_highlight
  for [k, v] in items(mhl)
    if a:use_termansicolor
      execute 'highlight StatusLine_' .. k
        \ 'guifg=' .. g:terminal_ansi_colors[v[0][0]]
        \ 'guibg=' .. g:terminal_ansi_colors[v[0][1]]
    else
      execute 'highlight link' 'Statusline_' .. k v[1]
    endif
  endfor
endfunction " }}}

function! stoneline#get_mode_type(mode) abort " {{{
  let m = a:mode[0]
  if m ==# 'n'
    return 'normal'
  elseif m ==# 'v' || m ==# 'V' || m ==# "\<C-v>"
    return 'visual'
  elseif m ==# 's' || m ==# 'S' || m ==# "\<C-s>"
    return 'select'
  elseif m ==# 'i'
    return 'insert'
  elseif m ==# 'R'
    return 'replace'
  elseif m ==# 'c'
    return 'command'
  elseif m ==# 't'
    return 'terminal'
  else
    return 'ignore'
  endif
endfunction " }}}

function! stoneline#get_mode_highlight_name(mode) abort " {{{
  let type = g:GetModeType(a:mode)
  return 'StatusLine_' .. type
endfunction " }}}

function! stoneline#create_active_statusline() abort " {{{
  let use_minimal = g:stoneline.UseMinimalChecker()
  let s = ''
  let s .= '%#' .. stoneline#get_mode_highlight_name(mode()) .. '#'
  let s .= ' %{g:stoneline.mode_title[mode(0)][' .. !use_minimal .. ']} '
  let s .= &modified ? '%#DiffAdd#' : '%#CursorLineNr#'
  let s .= mode(0) ==# 't' ? ' <terminal>' : ' %f'
  let s .= ' '
  let s .= '%y'              " Show filetype
  let s .= '%m'
  let s .= '%='
  if !use_minimal
    let s .= '%#DiffText#'
    " let s .= '▏'
    let s .= ' '
    let s .= '%{&fileencoding?&fileencoding:&encoding}'
    let s .= ' %{&fileformat} '
  endif
  " let s .= '▏'
  let s .= '%#Search#'
  let s .= ' '
  let s .= '%l:%c'              " Show line number and column
  let s .= ' '
  if !use_minimal
    let s .= '%p%% '               " Show percentage
  endif
  return s
endfunction " }}}

function! stoneline#create_inactive_statusline() abort " {{{
  let use_minimal = g:stoneline.UseMinimalChecker()
  let s = ''
  let s .= '%#StatusLineNC#'
  let s .= ' %{g:stoneline.mode_title[mode(0)][' .. !use_minimal .. ']} '
  let s .= mode(0) ==# 't' ? '▏<terminal>' : '▏%f'
  let s .= ' '
  let s .= '%y'              " Show filetype
  let s .= '%m'
  let s .= '%='
  if !use_minimal
    let s .= '▏'
    " let s .= ' '
    let s .= '%{&fileencoding?&fileencoding:&encoding}'
    let s .= ' %{&fileformat} '
  endif
  let s .= '▏'
  " let s .= ' '
  let s .= '%l:%c'              " Show line number and column
  let s .= ' '
  if !use_minimal
    let s .= '%p%% '               " Show percentage
  endif
  let s .= '%#VertSplit#'
  return s
endfunction " }}}

let &cpoptions = s:save_cpo
unlet! s:save_cpo

" vim: set ft=vim ts=2 sts=-1 sw=0 et fdm=marker fmr={{{,}}} cms="\ %s:
"
