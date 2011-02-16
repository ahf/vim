" Vim syntaxfile
" Language:     Common code for exheres syntax
" Author:       Alexander Færøy <ahf@exherbo.org>
" Copyright:    Copyright (c) 2008 Alexander Færøy
" License:      You may redistribute this under the same terms as Vim itself

if &compatible || v:version < 603
    finish
endif

let is_bash = 1
runtime! syntax/sh.vim
unlet b:current_syntax

syn region ExheresHeader contained start=/^#/ end=/$/ contains=ExheresCopyrightHeader
syn region ExheresHeaderBlock start=/\%^\(#\)\@=/ end=/^$/ contains=ExheresHeader

" Unfilled copyright notice
syn region ExheresCopyrightHeader contained start=/^#\s*Copyright/ end=/$/ contains=ExheresCopyrightError
syn match ExheresCopyrightError contained  /<\(name\|year\)>/

" Phases
syn keyword ExheresZeroFunctions    pkg_pretend pkg_setup pkg_preinst pkg_postinst pkg_prerm pkg_postrm pkg_nofetch pkg_config pkg_info
syn keyword ExheresZeroFunctions    src_fetch_extra src_unpack src_prepare src_configure src_compile src_test src_test_expensive src_install

" Default phases
syn keyword ExheresZeroFunctions    default
syn keyword ExheresZeroFunctions    default_pkg_pretend default_pkg_setup default_pkg_preinst default_pkg_postinst default_pkg_prerm default_pkg_postrm default_pkg_nofetch default_pkg_config default_pkg_info
syn keyword ExheresZeroFunctions    default_src_fetch_extra default_src_unpack default_src_prepare default_src_configure default_src_compile default_src_test default_src_test_expensive default_src_install

" die_functions.bash
syn keyword ExheresZeroCoreKeyword  die assert nonfatal

" echo_functions.bash
syn keyword ExheresZeroCoreKeyword  einfo elog ewarn eerror ebegin eend
syn keyword ExheresZeroCoreKeyword  einfon ewend

" install_functions.bash
syn keyword ExheresZeroCoreKeyword  keepdir into insinto exeinto docinto insopts diropts exeopts libopts

" kernel_functions.bash
syn keyword ExheresZeroCoreKeyword  KV_major KV_minor KV_micro KV_to_int get_KV

" sydbox.bash
syn keyword ExheresZeroCoreKeyword esandbox
syn match ExheresZeroError          "sydboxcheck"
syn match ExheresZeroError          "sydboxcmd"
syn match ExheresZeroError          "addread"
syn match ExheresZeroError          "adddeny"
syn match ExheresZeroError          "addpredict"

" exheres-0/build_functions.bash
syn keyword ExheresZeroCoreKeyword  expatch econf einstall emagicdocs edo

" exheres-0/conditional_functions.bash
syn keyword ExheresZeroCoreKeyword  option_with option_enable
syn keyword ExheresZeroError        use_with use_enable

" exheres-0/exlib_functions.bash
syn keyword ExheresZeroRequire      require

" exheres-0/list_functions.bash
syn keyword ExheresZeroError        use usev useq
syn keyword ExheresZeroCoreKeyword  optionfmt option optionv optionq has hasv hasq

" exheres-0/portage_stubs.bash
syn keyword ExheresZeroCoreKeyword  has_version best_version
syn keyword ExheresZeroError        portageq vdb_path check_KV debug-print debug-print-function debug-print-section

" utils/
syn keyword ExheresZeroCoreKeyword  dobin doconfd dodir doenvd doexe doinfo
syn keyword ExheresZeroCoreKeyword  doinitd doins dolib dolib.a dolib.so doman domo dosbin dosym
syn keyword ExheresZeroCoreKeyword  newbin newconfd newdoc newenvd newexe newinitd newins newlib.a newlib.so
syn keyword ExheresZeroCoreKeyword  newman newsbin unpack
syn keyword ExheresZeroCoreKeyword  herebin hereconfd hereenvd hereinitd hereins heresbin
syn keyword ExheresZeroError        fperms fowners

" utils/exheres-0/
syn keyword ExheresZeroCoreKeyword  emake dodoc
syn keyword ExheresZeroError        dohard donewins dosed doset dohtml
syn keyword ExheresZeroError        prepall prepalldocs prepallinfo prepallman prepallstrip prepdocs prepinfo prepman prepstrip
syn match ExheresZeroError          /ecompress\w*/

" autotools.exlib
syn keyword ExheresZeroCoreKeyword  eautoreconf eaclocal eautoconf eautoheader eautomake

" Legacy ebuild stuff
syn match ExheresZeroError          /^SOURCES/
syn match ExheresZeroError          /^DISTDIR/
syn match ExheresZeroError          /^FILESDIR/
syn match ExheresZeroError          /^PORTDIR/
syn match ExheresZeroError          /^WORKDIR/
syn match ExheresZeroError          /^KEYWORDS/
syn match ExheresZeroError          /^PROVIDE/
syn match ExheresZeroError          /^IUSE/
syn match ExheresZeroError          /^LICENSE/
syn match ExheresZeroError          /^LICENCE[^S]/
syn match ExheresZeroError          /^SRC_URI/
syn match ExheresZeroError          /^EAPI/
syn match ExheresZeroError          /AA/
syn match ExheresZeroError          /ARCH/
syn match ExheresZeroError          /KV/
syn match ExheresZeroError          /^\(A\|D\|S\|T\)=/
syn match ExheresZeroErrorC         /\${\(P\|PF\|A\|D\|S\|T\)}/
syn match ExheresZeroErrorC         /\${\(DISTDIR\|FILESDIR\|PORTDIR\|SOURCES\|WORKDIR\)}/

" Read-only variables
syn match ExheresZeroError          /^\(PNV\|PN\|PV\|PR\|PVR\|PNVR\|ARCHIVES\)=/

" Bad variable assignments
syn match ExheresZeroError          /^SLOT\s*=\s*\(""\|''\|$\)/
syn match ExheresZeroError          ~^WORK="\?\${\?WORKBASE}\?/\${\?PNV}\?"\?\s*$~
syn match ExheresZeroErrorC         /\${PN}-\${PV}/

" Highlight tabs and trailing whitespace as errors
syn match ExheresZeroError          "	"
syn match ExheresZeroError          "\s\+$"

" Highlight last line if it's not empty
syn match ExheresZeroError          /^.\+\%$/

" Highlight it
syn cluster ExheresZeroContents     contains=ExheresZeroCoreKeyword,ExheresZeroFunctions,ExheresZeroRequire
syn cluster ExheresZeroContents     add=ExheresZeroError,ExheresZeroErrorC

syn cluster shCommandSubList        add=@ExheresZeroContents
syn cluster shDblQuoteList          add=ExheresZeroErrorC

hi def link ExheresZeroCoreKeyword  Keyword
hi def link ExheresZeroFunctions    Special
hi def link ExheresZeroRequire      Include
hi def link ExheresZeroError        Error
hi def link ExheresZeroErrorC       Error
hi def link ExheresHeader           Comment
hi def link ExheresCopyrightHeader  Comment
hi def link ExheresCopyrightError   Error

" vim: set et ts=4 :
