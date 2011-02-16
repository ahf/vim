" Vim plugin
" Language:     Create new exheres-0 package.
" Author:       Alexander Færøy <ahf@exherbo.org>
" Copyright:    Copyright (c) 2007 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

fun! <SID>GenerateExheresZeroPackage()
    let l:pastebackup = &paste
    set nopaste

    if exists("*strftime")
        let l:year = strftime("%Y")
    else
        let l:year = "<year>"
    endif

    put! ='# Copyright ' . l:year . ' ' . g:exheres_author_name
    put ='# Distributed under the terms of the GNU General Public License v2'
    put =''
    put ='SUMMARY=\"\"'
    put ='DESCRIPTION=\"'
    put ='If DESCRIPTION is set it must not be an empty string.'
    put ='\"'
    put ='HOMEPAGE=\"\"'
    put ='DOWNLOADS=\"\"'
    put =''
    put ='LICENCES=\"\"'
    put ='SLOT=\"0\"'
    put ='PLATFORMS=\"\"'
    put ='MYOPTIONS=\"\"'
    put =''
    put ='DEPENDENCIES=\"'
    put ='    build:'
    put ='    build+run:'
    put ='\"'
    put =''
    put ='BUGS_TO=\"\"'
    put =''
    put ='DEFAULT_SRC_CONFIGURE_PARAMS=( )'
    put ='DEFAULT_SRC_CONFIGURE_OPTION_WITHS=( )'
    put ='DEFAULT_SRC_CONFIGURE_OPTION_ENABLES=( )'
    put =''

    0
    /^SUMMARY=/
    exec "normal 2f\""
    nohls

    if pastebackup == 0
        set nopaste
    endif
endfun

com! -nargs=0 NewExheresZeroPackage call <SID>GenerateExheresZeroPackage()

if !exists("g:package_create_on_empty")
    let g:package_create_on_empty = 1
endif

if v:progname =~ "vimdiff"
    let g:package_create_on_empty = 0
endif

if !exists("g:exheres_author_name")
    let g:exheres_author_name = "<name>"
endif

augroup NewExheresZeroPackage
    au!
    autocmd BufNewFile *.exheres-0
        \ if g:package_create_on_empty |
        \   call <SID>GenerateExheresZeroPackage() |
        \ endif
augroup END

" vim: set et ts=4 :
