" Vim filetype plugin file
" Language:     Exlib
" Author:       Alexander Færøy <ahf@exherbo.org>
" Copyright:    Copyright (c) 2008, 2009 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

runtime! ftplugin/sh.vim

setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal fileencoding=utf-8
setlocal textwidth=100

" vim: set et ts=4 :
