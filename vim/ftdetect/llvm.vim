" Vim filetype detection file
" Language:     Low-Level Virtual Machine
" Author:       Alexander Færøy <ahf@0x90.dk>
" Copyright:    Copyright (c) 2011 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

autocmd BufRead,BufNewFile *.ll set filetype=llvm
autocmd BufRead,BufNewFile *.llx set filetype=llvm
autocmd BufRead,BufNewFile *.td set filetype=tablegen

" vim: set et ts=4 :
