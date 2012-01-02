"
" Alexander Færøy <ahf@0x90.dk>
"
" Most recent update: Mon  2 Jan 19:11:24 2012
"

let g:name = 'Alexander Færøy'
let g:mail = 'ahf@0x90.dk'

set nocompatible
set wildmenu
set wildignore+=*.o,*~,.lo
set nowrap
set ruler
set bs=2
set backup
set backupdir=~/.vim/backup/
set swapfile
set directory=~/.vim/temp/
set history=150
set ruler
set noinsertmode
set nonumber
set incsearch
set showmatch
set path=.,~/
set undolevels=1000
set updatecount=100
set ttyfast
set ttyscroll=999
set report=0
set tabstop=4
set shiftwidth=4
set autoindent
set showcmd
set smartindent
set enc=utf-8
set tenc=utf-8
set fileformat=unix
set showmatch
set mat=5
set novisualbell
set noerrorbells
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set lazyredraw
set nofoldenable
set autoread
set makeef=error.err
set showfulltag
set pastetoggle=<F10>
set showfulltag
set expandtab
set scrolloff=3
set sidescrolloff=2
set noerrorbells

set nomodeline
let g:secure_modelines_verbose = 1
let g:secure_modelines_modelines = 15

if has("syntax")
    syntax on
    set syntax=on
    set popt+=syntax:y
endif

if has("eval")
    filetype on
    filetype indent on
    filetype plugin on
endif

if has("folding")
    set foldenable
    set foldmethod=indent
    set foldlevelstart=99
endif

if has("title")
    set title
endif

if has("title") && (has("gui_running") || &title)
    set titlestring=
    set titlestring+=%f\ " file name
    set titlestring+=%h%m%r%w
    set titlestring+=\ -\ %{v:progname}
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif

if has("eval")
    let g:scm_cache = {}
    function! ScmInfo()
        let l:key = getcwd()
        if ! has_key(g:scm_cache, l:key)
            if (isdirectory(getcwd() . "/.git"))
                let g:scm_cache[l:key] = "[" . substitute(readfile(getcwd() . "/.git/HEAD", "", 1)[0], "^.*/", "", "") . "] "
            else
                let g:scm_cache[l:key] = ""
            endif
        endif
        return g:scm_cache[l:key]
    endfunction
endif

set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*
set statusline+=%f\ " file name

if has("eval")
    set statusline+=%{ScmInfo()}
endif

set statusline+=%h%1*%m%r%w%0*
set statusline+=\[%{strlen(&ft)?&ft:'none'},
set statusline+=%{&encoding},
set statusline+=%{&fileformat}]

if has("gui")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    set mousemodel=popup
endif

if has("eval")
    function! LoadColourScheme(schemes)
        let l:schemes = a:schemes . ":"
        while l:schemes != ""
            let l:scheme = strpart(l:schemes, 0, stridx(l:schemes, ":"))
            let l:schemes = strpart(l:schemes, stridx(l:schemes, ":") + 1)
            try
                exec "colorscheme" l:scheme
                break
            catch
            endtry
        endwhile
    endfunction

    if has("gui")
        call LoadColourScheme("inkpot:night:darkblue:elflord")
    else
        if has("autocmd")
            autocmd VimEnter *
                        \ if &t_Co == 88 || &t_Co == 256 |
                        \     call LoadColourScheme("inkpot:darkblue:elflord") |
                        \ else |
                        \     call LoadColourScheme("darkblue:elflord") |
                        \ endif
        else
            if &t_Co == 88 || &t_Co == 256
                call LoadColourScheme("inkpot:darkblue:elflord")
            else
                call LoadColourScheme("darkblue:elflord")
            endif
        endif
    endif
endif

if "" == &shell
    if executable("/bin/bash")
        set shell=/bin/bash

        if has("eval")
            let is_bash=1
        endif
    elseif executable("/bin/zsh")
        set shell=/bin/zsh
    endif
endif

if has("gui_running") && v:version >= 700
    set cursorline
endif

if has("eval") && has("autocmd")
    function! <SID>check_pager_mode()
        if exists("g:loaded_less") && g:loaded_less
            set ruler
            set foldmethod=manual
            set foldlevel=99
            set nolist
        endif
    endfunction

    autocmd VimEnter * :call <SID>check_pager_mode()
endif

if has("eval")
    function! <SID>WindowWidth()
        if winwidth(0) > 90
            setlocal foldcolumn=2
            setlocal number

            if v:version >= 700
                try
                    setlocal numberwidth=3
                catch
                endtry
            endif
        else
            setlocal nonumber
            setlocal foldcolumn=0
        endif
    endfunction

    function! <SID>UpdateRcHeader()
        let l:c=col(".")
        let l:l=line(".")
        1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%c")-e
        call cursor(l:l, l:c)
    endfunction

    fun! <SID>UpdateCopyrightHeaders()
        let l:a = 0
        for l:x in getline(1, 10)
            let l:a = l:a + 1
            if -1 != match(l:x, 'Copyright (c) [- 0-9,]*20\(0[456789]\|10\) Alexander Færøy')
                if input("Update copyright header? (y/N) ") == "y"
                    call setline(l:a, substitute(l:x, '\(20[01][0456789]\) Alexander', '\1, 2011 Alexander', ""))
                endif
            endif
        endfor
    endfun

    function! CleverTab()
        if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
            return "\<Tab>"
        else
            return "\<C-P>"
        endif
    endfunction

    function! MakeGenericCopyrightHeader()
        0 put ='# Copyright (c) '.strftime('%Y').' '.g:name.' <'.g:mail.'>'
        put ='# Distributed under the terms of the GNU General Public License v2'
        $
    endfunction

    function! IncludeGuardText()
        let l:t = substitute(expand("%"), "[./]", "_", "g")
        return toupper("GUARD_" . l:t)
    endfunction

    function! MakeIncludeGuards()
        norm gg
        /^$/
        norm 2O
        call setline(line("."), "#ifndef " . IncludeGuardText())
        norm o
        call setline(line("."), "#define " . IncludeGuardText() . " 1")
        norm G
        norm o
        call setline(line("."), "#endif")
    endfunction

    function! FileTime()
        let ext=tolower(expand("%:e"))
        let fname=tolower(expand('%<'))
        let filename=fname . '.' . ext
        let msg=""
        let msg=msg." ".strftime("(Modified %b,%d %y %H:%M:%S)",getftime(filename))

        return msg
    endfunction

    function! CurrentTime()
        let ftime=""
        let ftime=ftime." ".strftime("%b,%d %y %H:%M:%S")

        return ftime
    endfunction

    noremap <Leader>ig :call MakeIncludeGuards()<CR>
    inoremap <Tab>   <C-R>=CleverTab()<CR>
    inoremap <S-Tab> <Tab>

    if v:version >= 700
        let g:switch_header_map = {
                    \ 'cc':    'hh',
                    \ 'hh':    'cc',
                    \ 'c':     'h',
                    \ 'h':     'c',
                    \ 'cpp':   'hpp',
                    \ 'hpp':   'cpp',
                    \ 'sig':   'sml',
                    \ 'sml':   'sig'}

        function! SwitchTo(f, split) abort
            if ! filereadable(a:f)
                echoerr "File '" . a:f . "' does not exist"
            else
                if a:split
                    new
                endif

                if 0 != bufexists(a:f)
                    exec ':buffer ' . bufnr(a:f)
                else
                    exec ':edit ' . a:f
                endif
            endif
        endfunction

        function! SwitchHeader(split) abort
            let filename = expand("%:p:r")
            let suffix = expand("%:p:e")

            if suffix == ''
                echoerr "Cannot determine header file (no suffix)"
                return
            endif

            let new_suffix = g:switch_header_map[suffix]
            if new_suffix == ''
                echoerr "Don't know how to find the header (suffix is " . suffix . ")"
                return
            end

            call SwitchTo(filename . '.' . new_suffix, a:split)
        endfunction

        noremap <Leader>sh  :call SwitchHeader(0)<CR>
        noremap <Leader>ssh :call SwitchHeader(1)<CR>
    endif
endif

if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
    else
        set list listchars=tab:»·,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>-,trail:.,extends:>
    endif
endif

if has("unix")
    if !isdirectory(expand("~/.vim/"))
        if !isdirectory(expand("~/.vim/backup/"))
            !mkdir -p ~/.vim/backup/
        endif

        if !isdirectory(expand("~/.vim/temp/"))
            !mkdir -p ~/.vim/temp/
        endif
    endif
endif

if filereadable("/usr/share/dict/words")
    set dictionary=/usr/share/dict/words
endif

if has("eval") && v:version >= 700
    if "horus" == hostname()
        let &makeprg="nice -n7 make -j3 2>&1"
    elseif "atum" == hostname()
        let &makeprg="nice -n7 make -j3 2>&1"
    elseif "anubis" == hostname()
        let &makeprg="nice -n7 make -j4 2>&1"
    elseif "bart" == hostname()
        let &makeprg="nice -n7 make -j12 2>&1"
    else
        let &makeprg="nice -n7 make -j2 2>&1"
    endif
endif

iabbrev monday Monday
iabbrev tuesday Tuesday
iabbrev wednesday Wednesday
iabbrev thursday Thursday
iabbrev friday Friday
iabbrev saturday Saturday
iabbrev sunday Sunday

let g:c_gnu=1
let g:c_no_curly_error=1
let html_number_lines=1
let html_use_css=1
let use_xhtml=1
let perl_extended_vars=1
let apache_version="2.0"
let g:load_doxygen_syntax=1
let g:doxygen_end_punctuation='[.?]'

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

noremap <Leader>gp gqap
noremap <Leader>clr :s/^.*$//<CR>:nohls<CR>
noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>

if v:version >= 700
    nmap <C-t> :tabnew<cr>
endif

if has("autocmd")
    if has("eval")
        function! <SID>abbrev_cpp()
            iabbrev <buffer> jin #include
            iabbrev <buffer> jde #define
            iabbrev <buffer> jci const_iterator
            iabbrev <buffer> jcl class
            iabbrev <buffer> jco const
            iabbrev <buffer> jdg \ingroup
            iabbrev <buffer> jdx /**<CR><CR>/<Up>
            iabbrev <buffer> jrd /*<CR><CR>/<Up>
            iabbrev <buffer> jit iterator
            iabbrev <buffer> jns namespace
            iabbrev <buffer> jpr protected
            iabbrev <buffer> jpu public
            iabbrev <buffer> jpv private
            iabbrev <buffer> jsl std::list
            iabbrev <buffer> jsm std::map
            iabbrev <buffer> jsM std::multimap
            iabbrev <buffer> jss std::string
            iabbrev <buffer> jsv std::vector
            iabbrev <buffer> jsp std::shared_ptr
            iabbrev <buffer> jty typedef
            iabbrev <buffer> jun using namespace
            iabbrev <buffer> jvi virtual
            iabbrev <buffer> jst static
            iabbrev <buffer> jmp std::make_pair
            iabbrev <buffer> jqs QString
            iabbrev <buffer> jql QList
            iabbrev <buffer> jqo QObject
            iabbrev <buffer> jqm QMap
            iabbrev <buffer> jqu QUrl
        endfunction

        function! <SID>abbrev_agda()
            iabbrev <buffer> forall ∀
            iabbrev <buffer> to →
            iabbrev <buffer> lambda λ
            iabbrev <buffer> Sigma Σ
            iabbrev <buffer> exists ∃
            iabbrev <buffer> equiv ≡
        endfunction

        function! <SID>abbrev_php()
            iabbrev <buffer> jcl class
            iabbrev <buffer> jfu function
            iabbrev <buffer> jco const
            iabbrev <buffer> jpr protected
            iabbrev <buffer> jpu public
            iabbrev <buffer> jpv private
            iabbrev <buffer> jst static
            iabbrev <buffer> jdx /**<CR><CR>/<Up>
            iabbrev <buffer> jrd /*<CR><CR>/<Up>
            iabbrev <buffer> jin include
        endfunction

        function! <SID>abbrev_ruby()
            iabbrev <buffer> jcl class
            iabbrev <buffer> jmo module
            iabbrev <buffer> jin require
            iabbrev <buffer> jdx #<CR><CR><Up>
        endfunction

        function! <SID>abbrev_c()
            iabbrev <buffer> jin #include
            iabbrev <buffer> jde #define
            iabbrev <buffer> jco const
            iabbrev <buffer> jdx /**<CR><CR>/<Up>
            iabbrev <buffer> jst static
        endfunction

        function! <SID>abbrev_python()
            iabbrev <buffer> jin import
            iabbrev <buffer> jcl class
        endfunction

        augroup abbreviations
            autocmd!
            autocmd FileType cpp :call <SID>abbrev_cpp()
            autocmd FileType php :call <SID>abbrev_php()
            autocmd FileType ruby :call <SID>abbrev_ruby()
            autocmd FileType c :call <SID>abbrev_c()
            autocmd FileType python :call <SID>abbrev_python()
            autocmd FileType agda :call <SID>abbrev_agda()
        augroup END
    endif

    augroup ahf
        autocmd!

        autocmd BufEnter *
            \ if &filetype == "cpp" |
            \   set noignorecase |
            \ else |
            \   set ignorecase |
            \ endif

        autocmd BufEnter * :call <SID>WindowWidth()
        autocmd BufEnter * syntax sync fromstart

        try
            autocmd Syntax *
                        \ syn match VimModelineLine /^.\{-1,}vim:[^:]\{-1,}:.*/ contains=VimModeline |
                        \ syn match VimModeline contained /vim:[^:]\{-1,}:/
            hi def link VimModelineLine comment
            hi def link VimModeline special
        catch
        endtry

        autocmd BufNewFile *.rb 0put ='# vim: set sw=2 sts=2 et tw=80 :' |
            \ 0put ='#!/usr/bin/env ruby' |
            \ 2put ='' |
            \ set sw=2 sts=2 et tw=80 |
            \ norm G

        autocmd BufNewFile *.py 0put ='#!/usr/bin/env python' |
            \ 1put ='# vim: set sw=4 sts=4 et tw=80 :' |
            \ 2put ='# -*- coding: utf-8 -*-' |
            \ 3put ='' |
            \ set sw=4 sts=4 et tw=80 |
            \ norm G

        autocmd BufNewFile *_TEST.py 4put ='import unittest' |
            \ 5put ='' |
            \ 6put ='if __name__ == \"__main__\":' |
            \ 7put ='    unittest.main()' |
            \ 5

        autocmd BufNewFile,BufRead *.markdown |
            \ set syntax=mkd spell spelllang=en sw=4 sts=4 et tw=80 |
            \ norm G

        autocmd BufNewFile *.hh 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
            \ call MakeIncludeGuards() |
            \ set sw=4 sts=4 et foldmethod=syntax |
            \ norm G

        autocmd BufNewFile *.h 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
            \ call MakeIncludeGuards() |
            \ set sw=4 sts=4 et foldmethod=syntax |
            \ norm G

        autocmd BufNewFile *.cc 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
            \ set sw=4 sts=4 et foldmethod=syntax |
            \ norm G

        autocmd BufNewFile *.c 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
            \ set sw=4 sts=4 et foldmethod=syntax |
            \ norm G

        autocmd BufNewFile *.php 0put ='<?php' |
            \ put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
            \ set sw=4 sts=4 et foldmethod=syntax |
            \ norm G

        autocmd BufNewFile *.exheres-* call MakeGenericCopyrightHeader() |
            \ norm g

        autocmd BufWritePre *vimrc  :call <SID>UpdateRcHeader()
        autocmd BufWritePre *bashrc :call <SID>UpdateRcHeader()

        autocmd FileType mail,human set nohlsearch formatoptions+=t textwidth=72 spell

        autocmd BufRead svn-commit.tmp setlocal nobackup
        autocmd BufRead COMMIT_EDITMSG setlocal nobackup

        autocmd BufWritePre * call <SID>UpdateCopyrightHeaders()
    augroup END
endif

if has("eval")
    if has("gui_running")
        let g:showmarks_enable=1
    else
        let g:showmarks_enable=0
        let loaded_showmarks=1
    endif

    let g:showmarks_include="abcdefghijklmnopqrstuvwxyz"

    if has("autocmd")
        fun! <SID>FixShowmarksColours()
            if has('gui')
                hi ShowMarksHLl gui=bold guifg=#a0a0e0 guibg=#2e2e2e
                hi ShowMarksHLu gui=none guifg=#a0a0e0 guibg=#2e2e2e
                hi ShowMarksHLo gui=none guifg=#a0a0e0 guibg=#2e2e2e
                hi ShowMarksHLm gui=none guifg=#a0a0e0 guibg=#2e2e2e
                hi SignColumn   gui=none guifg=#f0f0f8 guibg=#2e2e2e
            endif
        endfun
        if v:version >= 700
            autocmd VimEnter,Syntax,ColorScheme * call <SID>FixShowmarksColours()
        else
            autocmd VimEnter,Syntax * call <SID>FixShowmarksColours()
        endif
    endif
endif

if has("autocmd")
    au VimEnter * nohls
endif

" vim: set sw=4 sts=4 et tw=140 :
