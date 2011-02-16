" Vim filetype detection file
" Language:     Google Go
" Author:       Alexander Færøy <ahf@0x90.dk>
" Copyright:    Copyright (c) 2011 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

autocmd BufRead,BufNewFile *.go set filetype=go

" vim: set et ts=4 :
