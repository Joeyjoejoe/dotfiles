"----- VIM PLUG-----"
  call plug#begin('~/.vim/plugged')
    " Misc
    Plug 'roman/golden-ratio'
    Plug 'tpope/vim-surround'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'majutsushi/tagbar'

    " Status bar
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Git
    Plug 'tpope/vim-fugitive'

    " Clojure
    Plug 'clojure-emacs/cider-nrepl'
    Plug 'tpope/vim-fireplace'
    Plug 'guns/vim-clojure-static'
    Plug 'guns/vim-clojure-highlight'
    Plug 'kien/rainbow_parentheses.vim'

    " Javascript
    Plug 'pangloss/vim-javascript'
    Plug 'Joeyjoejoe/jsdoc.vim'

    " Scss
    Plug 'tpope/vim-haml'

    " HTML
    Plug 'othree/html5.vim'

    " Colorschemes
    Plug 'tomasr/molokai'

    " Linters
    Plug 'dense-analysis/ale'

    " UML display
    Plug 'tyru/open-browser.vim'
    Plug 'aklt/plantuml-syntax'
    Plug 'weirongxu/plantuml-previewer.vim'

  call plug#end()

"----- ALE LINTER -----"
  let g:ale_linters = {'scss': ['stylelint'], 'css': ['stylelint'], 'javascript': ['eslint'], 'ruby': ['rubocop'], 'clojure': ['clj-kondo', 'joker'], 'clojurescript': ['clj-kondo', 'joker']}
  let g:ale_fixers = {'scss': ['stylelint'], 'css': ['stylelint'], 'javascript': ['eslint'], 'ruby': ['rubocop'], 'clojure': ['remove_trailing_lines', 'trim_whitespace'], 'clojurescript': ['clj-kondo', 'joker']}

  let g:ale_sign_column_always = 1
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '⚠'
  let g:ale_fix_on_save = 1
  let g:ale_linters_explicit = 1
  let g:airline#extensions#ale#enabled = 1

  highlight ALEErrorSign ctermbg=NONE ctermfg=red
  highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

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
  let g:rbpt_max = 16
  let g:rbpt_loadcmd_toggle = 0
  autocmd VimEnter *       RainbowParenthesesToggle
  autocmd Syntax   clojure RainbowParenthesesLoadRound
  autocmd Syntax   clojure RainbowParenthesesLoadSquare
  autocmd Syntax   clojure RainbowParenthesesLoadBraces

"----- CTRLP CONFIG -----"

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|(node_modules|doc)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

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

  " F8 ~> Display tagbar
  nmap <F8> :TagbarToggle<CR>
  " jsd ~> Add doc to javascript function (Prompt on function name)
  nnoremap jsd :<C-u>call JSDocAdd()<CR>
  " ctrl+@ ~> Display git status
  nnoremap <silent> <c-@> :vertical Gstatus<CR>

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
