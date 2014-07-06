" Vim filetype plugin
" Language:     F#
" Last Change:  Fri 18 May 2012 01:59:07 AM CEST
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
    let save = @/    " save last search pattern
    mark '
    while cnt > 0
	silent! exe a:motion
	let cnt = cnt - 1
    endwhile
    call histdel('/', -1)
    let @/ = save    " restore last search pattern
endfun

" enable syntax based folding
setl fdm=syntax

" comment settings
setl formatoptions=croql
setl commentstring=(*%s*)
setl comments=s0:*\ -,m0:*\ \ ,ex0:*),s1:(*,mb:*,ex:*),:\/\/\/,:\/\/

" make ftplugin undo-able
let b:undo_ftplugin = 'setl fo< cms< com< fdm<'

let s:candidates = [ 'fsi',
            \ 'fsi.exe',
            \ 'fsharpi',
            \ 'fsharpi.exe' ]

if !exists('g:fsharp_interactive_bin')
    let g:fsharp_interactive_bin = ''
    for c in s:candidates
        if executable(c)
            let g:fsharp_interactive_bin = c
        endif
    endfor
endif

function! s:launchInteractive(from, to)
    if !executable(g:fsharp_interactive_bin)
        echohl WarningMsg
        echom 'fsharp.vim: no fsharp interactive binary found'
        echom 'fsharp.vim: set g:fsharp_interactive_bin appropriately'
        echohl None
        return
    endif

    let tmpfile = tempname()
    echo tmpfile
    exec a:from . ',' . a:to . 'w! ' . tmpfile
    exec '!' . g:fsharp_interactive_bin '--gui- --nologo --use:"'.tmpfile.'"'
endfunction

com! -buffer -range=% Interactive call s:launchInteractive(<line1>, <line2>)

let &cpo = s:cpo_save

" vim: sw=4 et sts=4
