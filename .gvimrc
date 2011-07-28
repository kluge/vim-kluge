" .gvimrc
" Author: Kari Oikarinen

" VISUAL ADJUSTMENTS {{{1
" set a readable font
set guifont=DejaVu\ Sans\ Mono\ 8
" no menubar
set guioptions-=m

let psc_fontface='mixed' " use bold text in highlighting (PS_color)
colorscheme ps_color
syntax enable

" adjust size
set columns=120
set lines=50
" }}}1

" MAPPINGS {{{1
map <A-m> :if &guioptions =~# 'm' <Bar>
                \set guioptions-=m <Bar>
          \else <Bar>
                \set guioptions+=m <Bar>
          \endif<CR>
" }}}1

" vim: set fen fdm=marker norl tw=78 fo=crq:
