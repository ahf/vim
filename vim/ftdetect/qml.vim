" Vim filetype detection file
" Language:     QML
" Author:       Alexander Færøy <alexander.faeroy@nokia.com>
" Copyright:    Copyright (c) 2011 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

autocmd BufRead,BufNewFile *.qml set filetype=qml

" vim: set et ts=4 :
