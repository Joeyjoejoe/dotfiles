"----- VIM PLUG-----"
  call plug#begin('~/.vim/plugged')

  " Status bar
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter' " might remove

  " Colorschemes
  Plug 'tomasr/molokai'

  " Autocomplete, lsp-server and linter
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Clojure
  Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
  Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
  Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'clojure' }


  call plug#end()


"----- COC config -----"

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

  " Some servers have issues with backup files, see coc.nvim#649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2


"----- STATUS BAR-----"
  let g:airline_powerline_fonts = 1
  let g:airline_theme='badwolf'

  function! MyLineNumber()
    return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). ' | '.
      \    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
  endfunction

  call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})

  let g:airline_section_z = airline#section#create(['%3p%%: ', 'linenr', ':%3v'])
  let g:airline_section_warning = ''

"-----UTILITY FUNCTIONS-----"

	"Remove trailing spaces on save
	function! <SID>StripTrailingWhitespaces()
			let l = line(".")
			let c = col(".")
			%s/\s\+$//e
			call cursor(l, c)
	endfunction

  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


"-----KEYBOARD SHORTCUTS-----"

  " ctrl+@ ~> Display git status
  nnoremap <silent> <c-@> :vertical Gstatus<CR>

"-----VIM DEFAULTS-----"
  set nocompatible
  syntax on
  filetype plugin indent on

  set encoding=utf-8

  ".swp files directory
  set directory=$HOME/.vim/.swapfiles//

  "Enable mouse
  set mouse=a

  "Vim update delay
  set updatetime=100

  set guifont=Fantasque\ Sans\ Mono

  "256 colors
  set t_Co=256

  if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
  endif

  "Colorscheme
  let g:molokai_original = 1
  colorscheme molokai

  "Comments & Strings font style
  highlight Comment cterm=italic gui=italic
  highlight String cterm=italic gui=italic

  "Highlight search resuts
  set hlsearch

  "Indentation options
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set expandtab

  "Set autoindents
  set cindent

  "Backspace over anythings
  set backspace=indent,eol,start

  "Display long lines on multiple lines
  set wrap linebreak nolist

  "Treat fils with .group extension as js
  autocmd BufNewFile,BufRead *.group set syntax=js

  runtime macros/matchit.vim

  set backupcopy=yes
