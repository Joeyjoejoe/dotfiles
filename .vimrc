"----- VIM PLUG-----"
  call plug#begin('~/.vim/plugged')
    " Misc
    Plug 'roman/golden-ratio'

    " Status bar
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Git
    Plug 'tpope/vim-fugitive'

    " Clojure
    Plug 'clojure-emacs/cider-nrepl'
    " Plug 'tpope/vim-fireplace'
    Plug 'guns/vim-clojure-static'
    Plug 'guns/vim-clojure-highlight'
    Plug 'kien/rainbow_parentheses.vim'

    " Colorschemes
    Plug 'tomasr/molokai'
  call plug#end()

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

"-----CLOJURE SPECIFICS-----"

  "Evaluate Clojure buffers on load
  autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry
  "Compatibility fix
  autocmd Syntax clojure EnableSyntaxExtension

  "Rainbow parenthesis
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

"-----UTILITY FUNCTIONS-----"

	"Remove trailing spaces on save
	function! <SID>StripTrailingWhitespaces()
			let l = line(".")
			let c = col(".")
			%s/\s\+$//e
			call cursor(l, c)
	endfunction

  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"-----VIM DEFAULTS-----"
  set nocompatible
  syntax on
  filetype plugin indent on

  ".swp files directory
  set directory=$HOME/.vim/.swapfiles//

  "Enable mouse
  set mouse=a

  set guifont=Ubuntu\ Mono\ 13

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

  "Highlight search resuts
  set hlsearch

  "Indentation options
  set expandtab
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2

  "Set autoindents
  set cindent

  "Backspace over anythings
  set backspace=indent,eol,start

