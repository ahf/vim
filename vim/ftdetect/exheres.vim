" Vim filetype detection file
" Language:     Exheres
" Author:       Alexander Færøy <ahf@exherbo.org>
" Copyright:    Copyright (c) 2008 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

au BufNewFile,BufRead *.exlib set filetype=exlib
au BufNewFile,BufRead *.exheres-0 set filetype=exheres-0

" vim: set et ts=4 :
