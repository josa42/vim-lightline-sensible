""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configs
let s:nerdfont = get(g:, 'nerdfont', 0)

let s:branch_icon = get(g:, 'lightline#helper#branch_icon', (s:nerdfont ? "\ue725" : 'ᚴ'))
let s:percentChars = get(g:, 'lightline#helper#percent_chars', [ "\u25CF       ", "\u25CF\u25CF      ", "\u25CF\u25CF\u25CF     ", "\u25CF\u25CF\u25CF\u25CF    ", "\u25CF\u25CF\u25CF\u25CF\u25CF   ", "\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF  ", "\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF ", "\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF" ])

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline components

function! lightline#helper#isHidden()
  let filetypes = ['nerdtree', 'startify', 'list']
  let filenames = ['[Plugins]', '__vista__', 'startify', 'NERDTree']
  return index(filetypes, &filetype) != -1 || index(filenames, expand('%:t')) != -1
endfunction"

function! lightline#helper#mode()
  return lightline#helper#isHidden() ? '': lightline#mode()
endfunction

function! lightline#helper#readonly()
  return lightline#helper#isHidden() ? '': ( &readonly ? 'RO' : '' )
endfunction

function! lightline#helper#filename()
  return lightline#helper#isHidden() ? '': expand('%')
endfunction

function! lightline#helper#modified()
  return lightline#helper#isHidden() ? '': ( &modified ? '+' : &modifiable ? '' : '-' )
endfunction

function! lightline#helper#lineinfo()
  return lightline#helper#isHidden() ? '' : printf('%d:%-2d', line('.'), col('.'))
endfunction


function! lightline#helper#percent()
  if lightline#helper#isHidden()
    return ''
  endif

  let l = 100 * line('.') / line('$')

  let p = " "
  if     l > 87 | let p = s:percentChars[7]
  elseif l > 75 | let p = s:percentChars[6]
  elseif l > 62 | let p = s:percentChars[5]
  elseif l > 50 | let p = s:percentChars[4]
  elseif l > 37 | let p = s:percentChars[3]
  elseif l > 25 | let p = s:percentChars[2]
  elseif l > 12 | let p = s:percentChars[1]
  els           | let p = s:percentChars[0]
  endif

  return p . ' ' . l . '%'
endfunction

function! lightline#helper#fileformat()
  return lightline#helper#isHidden() ? '': &fileformat
endfunction

function! lightline#helper#fileencoding()
  return lightline#helper#isHidden() ? '': (&fenc !=# '' ? &fenc : &enc)
endfunction

function! lightline#helper#filetype()
  return lightline#helper#isHidden() ? '': (&filetype !=# '' ? &filetype : 'no ft')
endfunction

function! lightline#helper#branch()
  if lightline#helper#isHidden()
    return ''
  endif
  let b = fugitive#head()
  " return b == '' ? '' : 'ᚴ '.b
  return b == '' ? '' : s:branch_icon . " " . b

endfunction

