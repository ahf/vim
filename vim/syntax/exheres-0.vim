" Vim syntaxfile
" Language:     Exheres-0
" Author:       Alexander Færøy <ahf@exherbo.org>
" Copyright:    Copyright (c) 2008 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

syn keyword ExheresZeroError      export_exlib_phases
syn keyword ExheresZeroError      myexparam exparam

runtime syntax/exheres-common.vim

let b:current_syntax = "exheres-0"

" vim: set et ts=4 :
