" Vim indent file
" Language:     Exheres-0
" Author:       Alexander Færøy <ahf@exherbo.org>
" Copyright:    Copyright (c) 2008 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

if exists("b:did_indent")
    finish
endif

runtime! indent/sh.vim
let b:did_indent = 1

" vim: set et ts=4 :
