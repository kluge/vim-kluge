" .vimrc
" Author: Kari Oikarinen


" BEHAVIOR OPTIONS {{{1
set nocompatible " not vi-compatible behaviour
behave xterm " mouse behaviour like in xterm
set backspace=indent,eol,start " backspace wraps to previous line
set report=1 " report if 2 or more lines change

set hidden " an abandoned buffer is hidden, not unloaded
set switchbuf=useopen " jump to the first open window that contains the buffer
                      " we're moving into if there is one

set wildmenu " show a menu of available command line completions on status line
" first complete to longest common string and show 'wildmenu' and then
" complete fully
set wildmode=longest:full,full

" allows using ^A and ^X with alphabetical characters, octal and hexadecimal
" numbers in addition to decimal numbers
set nrformats=alpha,octal,hex
" }}}1

" INDENTING RELATED OPTIONS {{{1
set autoindent " preserve indentation of current line, if there's nothing fancier
set smarttab " <Tab> at the start of line inserts 'shiftwidth', otherwise 'tabstop'
set expandtab " use spaces instead of tabs
set shiftwidth=4 " how many spaces one indent level is
set shiftround " > and < round indent to multiples of 'shiftwidth'
" }}}1

" SEARCH OPTIONS {{{1
set ignorecase " ignore case in searches...
set smartcase  " ...unless the pattern contains upper-case letters
set incsearch " search while entering pattern
set hlsearch " highlight search patterns
set gdefault " substitute globally on lines by default
" }}}1

" OWN COMMANDS, GLOBAL MAPPINGS AND ABBREVIATIONS {{{1


" move to the directory of current file
command! CD cd %:p:h

" use comma as the leader
let mapleader = ","
" get rid of the search highlights
nnoremap <leader><space> :noh<cr>
" use normal regexps instead of Vim's own syntax
nnoremap / /\v
vnoremap / /\v
" map  to  as it is clumsy to hit
map  
" 'a is practically never the intended behaviour and `a is so hard to write
" that let's make ' to work like `
map ' `
" map <F4> and <F5> to add a date in ISO 8601 format 
imap <F4> <C-R>=strftime("%FT%R")<CR>
imap <F5> <C-R>=strftime("%F %R")<CR>
cmap <F5> <C-R>=strftime("%F")<CR>
" map Ctrl+A to begin omni completion
imap <C-A> <C-X><C-O>

" visual shifting with reselection
vnoremap < <gv
vnoremap > >gv
" }}}1

" FILE TYPE DEPENDENT STUFF {{{1
" (last section because might override common preferences)

" automatic file type detection, filetype settings and language-dependent
" indenting
filetype plugin indent on

" -- Vim scripts -- {{{2
augroup VimScript
    autocmd!
    autocmd FileType vim set formatoptions=crq
    " snipMate snippets have to be defined with hard tabs
    autocmd BufRead *.snippet set noexpandtab shiftwidth=8
    autocmd BufNewFile *.snippet set noexpandtab
augroup END " }}}2

" -- Perl scripts -- {{{2
augroup PerlScript
    autocmd!
    autocmd FileType perl set formatoptions=crq
    autocmd FileType perl set makeprg=$VIMRUNTIME/tools/efm_perl.pl\ -c\ %\ $* errorformat=%f:%l:%m
augroup END " }}}2

" -- C++ -- {{{2
augroup Cpp
    autocmd!
    autocmd FileType cpp command! -nargs=* -complete=file Run !%:p:r <args>
augroup END " }}}2

" -- Latex --- {{{2
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_MultipleCompileFormats="dvi,pdf"
augroup Latex
    autocmd!
    autocmd FileType tex setlocal sw=2
    autocmd FileType tex set iskeyword+=:
augroup END
" }}}2

" -- Fortran -- {{{2
let fortran_free_source=1
" standard forbids tabs
"let fortran_have_tabs=1
let fortran_more_precise=1
augroup Fortran
    autocmd!
    autocmd BufRead,BufNewFile *.f90 let fortran_do_enddo=1 " try to indent do loops, too
    autocmd FileType fortran set errorformat=%E%.%#rror:\ %f\\,\ line\ %l:\ %m,\%-C%.%#,\%-Z\%p^
augroup END
" }}}2

" -- Python -- {{{2
augroup Python
    autocmd!
    autocmd FileType python command! -nargs=* -complete=file Run !%:p <args>
augroup END
" }}}2

" -- Haskell -- {{{2
let g:haddock_browser="/usr/bin/chromium"
let g:haddock_docdir="/usr/share/doc/ghc6-doc/html/"
let g:haddock_indexfiledir="/home/kluge/.vim/"
augroup Haskell
    autocmd!
    " autocmd BufEnter *.hs compiler ghc
    " Haskell layout is not based on fixed tab stops
    autocmd BufEnter *.hs setlocal noshiftround
    autocmd BufEnter *.hs setlocal formatoptions=crq
augroup END
" }}}2

" -- Mail (plain text) -- {{{2
augroup Mail
    autocmd!
    autocmd FileType mail set nocindent noautoindent
augroup END
" }}}2

" -- Markdown -- {{{2
augroup Markdown
    autocmd!
    autocmd FileType markdown set textwidth=79
augroup END
" }}}2

" -- Django -- {{{2
augroup Django
    autocmd!
    autocmd BufRead *.html set filetype=htmldjango.html
    autocmd BufNewFile *.html set filetype=htmldjango.html
augroup END
" }}}2

" }}}1

" VISUAL ADJUSTMENTS {{{1
set ruler " always show cursor position on status line
set showcmd " show uncompleted commands on status line
set noshowmatch
set scrolloff=3 " keep some context between current line and window border

" Use Peaksea color scheme
set background=dark
" if this is not a GVim, we'll choose the colorscheme and enable syntax
" for GVim we can't do it yet because mixed fontface is set in .gvimrc
" (it's not supported in console)
if !has("gui_running")
    colorscheme peaksea
    syntax enable
endif
set guioptions-=T " no toolbar in GUI (too late to set in .gvimrc)
hi MatchParen ctermbg=blue guibg=#004040

" highlight trailing whitespace
highlight link WhitespaceEOL ErrorMsg
match WhitespaceEOL /\s\+\%#\@!$/ " trailing whitespace without cursor
" }}}1

" vim: set fen fdm=marker norl tw=78 fo=crq:
