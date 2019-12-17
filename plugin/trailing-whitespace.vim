if exists('loaded_trailing_whitespace_plugin') | finish | endif
let loaded_trailing_whitespace_plugin = 1

if !exists('g:extra_whitespace_ignored_filetypes')
  let g:extra_whitespace_ignored_filetypes = []
endif

function! CheckMatchWhitespace(type)
  if index(g:extra_whitespace_ignored_filetypes, &ft)
    if a:type == 'insert_enter'
      match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/
    else
      match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/
    endif
  else
    match ExtraWhitespace none
  endif
endfunction

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=darkred guibg=darkred

autocmd BufRead,BufNew,WinEnter * call CheckMatchWhitespace('normal')

" The above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * call CheckMatchWhitespace('normal')
autocmd InsertEnter * call CheckMatchWhitespace('insert_enter')
