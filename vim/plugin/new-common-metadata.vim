" Vim plugin
" Language:     Create new common-metadata.exlib
" Author:       Saleem Abdulrasool <compnerd@compnerd.org>
" Copyright:    Copyright (c) 2008 Saleem Abdulrasool <compnerd@compnerd.org>
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

fun! <SID>GenerateCommonMetadataExlib()
    let l:pastebackup = &paste
    set nopaste

    put = ''
    put = 'SUMMARY=\"\"'
    put = 'DESCRIPTION=\"'
    put = '\"'
    put = 'HOMEPAGE=\"\"'
    put = 'DOWNLOADS=\"\"'
    put = ''
    put = 'LICENCES=\"\"'
    put = 'SLOT=\"0\"'
    put = 'MYOPTIONS=\"\"'
    put = ''
    put = 'DEPENDENCIES=\"'
    put = '    build+run:'
    put = '\"'
    put = ''
    put = 'BUGS_TO=\"\"'
    put = ''
    put = 'REMOTE_IDS=\"\"'
    put = ''
    put = 'UPSTREAM_CHANGELOG=\"\"'
    put = 'UPSTREAM_DOCUMENTATION=\"\"'
    put = 'UPSTREAM_RELEASE_NOTES=\"\"'
    put = ''

    0
    /^SUMMARY=/
    exec "normal 2f\""
    nohls

    if pastebackup != 0
        set paste
    endif
endfun

com! -nargs=0 NewCommonMetadataExlib call <SID>GenerateCommonMetadataExlib

if !exists("g:common_metadata_create_on_empty")
    let g:common_metadata_create_on_empty = 1
endif

if v:progname =~ "vimdiff"
    let g:common_metadata_create_on_empty = 0
endif

augroup NewCommonMetadataExlib
    au!
    " common-metadata.exlib
    autocmd BufNewFile common-metadata.exlib
        \ if g:common_metadata_create_on_empty |
        \   call <SID>GenerateCommonMetadataExlib() |
        \ endif
    " ${PN}.exlib
    autocmd BufNewFile *.exlib
        \ if expand('%:p:t') == expand('%:p:h:t') . '.exlib' |
        \   if g:common_metadata_create_on_empty |
        \      call <SID>GenerateCommonMetadataExlib() |
        \   endif |
        \ endif
augroup END

" vim: set et ts=4 sw=4 :
