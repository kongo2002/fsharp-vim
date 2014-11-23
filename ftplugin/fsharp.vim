" Vim filetype plugin
" Language:     F#
" Last Change:  Sun 31 Aug 2014 06:58:41 PM CEST
" Maintainer:   Gregor Uhlenheuer <kongo2002@googlemail.com>

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" Jump to bindings in the first column, taken from python.
nnoremap <silent> <buffer> ]] :call <SID>Fsharp_jump('/^\(let\\|type\\|do\\|module\)')<cr>
nnoremap <silent> <buffer> [[ :call <SID>Fsharp_jump('?^\(let\\|type\\|do\\|module\)')<cr>
nnoremap <silent> <buffer> ]m :call <SID>Fsharp_jump('/^\s*\(let\\|type\\|do\\|module\)')<cr>
nnoremap <silent> <buffer> [m :call <SID>Fsharp_jump('?^\s*\(let\\|type\\|do\\|module\)')<cr>

if exists('*<SID>Fsharp_jump') | finish | endif

fun! <SID>Fsharp_jump(motion) range
    let cnt = v:count1
    " save last search pattern
    let save = @/
    mark '
    while cnt > 0
        silent! exe a:motion
        let cnt = cnt - 1
    endwhile
    call histdel('/', -1)
    " restore last search pattern
    let @/ = save
endfun

" enable syntax based folding
setl fdm=syntax

" comment settings
setl formatoptions=croql
setl commentstring=(*%s*)
setl comments=s0:*\ -,m0:*\ \ ,ex0:*),s1:(*,mb:*,ex:*),:\/\/\/,:\/\/

" switching between interfaces (.fsi) and implementations (.fs). taken from omlet.
if !exists("g:did_fsharp_switch")
  let g:did_fsharp_switch = 1
  map <LocalLeader>s :call FSharp_switch(0)<CR>
  map <LocalLeader>S :call FSharp_switch(1)<CR>
  fun FSharp_switch(newwin)
    if (match(bufname(""), "\\.fsi$") >= 0)
      let fname = substitute(bufname(""), "\\.fsi$", ".fs", "")
      if (a:newwin == 1)
        exec "new " . fname
      else
        exec "arge " . fname
      endif
    elseif (match(bufname(""), "\\.fs$") >= 0)
      let fname = bufname("") . "i"
      if (a:newwin == 1)
        exec "new " . fname
      else
        exec "arge " . fname
      endif
    endif
  endfun
endif

" tab/indentation settings
setl expandtab
setl nolisp
setl nosmartindent

" make ftplugin undo-able
let b:undo_ftplugin = 'setl fo< cms< com< fdm< et< si< lisp<'

let &cpo = s:cpo_save

" vim: sw=4 et sts=4
