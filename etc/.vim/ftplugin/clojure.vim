" https://vimawesome.com/plugin/rainbow-parentheses-vim-all-too-well
autocmd FileType clojure RainbowParentheses
let g:rainbow#blacklist = [225, 193, 244, 81, 229]
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']']]

" COC linter and autocomplete (bridge to lsp-clojure and clj-kondo)
let g:coc_global_extensions = ['coc-clojure', 'coc-diagnostic']
