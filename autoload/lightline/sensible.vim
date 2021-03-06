""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configs
let s:percentChars = [
  \   "\u25CF       ",
  \   "\u25CF\u25CF      ",
  \   "\u25CF\u25CF\u25CF     ",
  \   "\u25CF\u25CF\u25CF\u25CF    ",
  \   "\u25CF\u25CF\u25CF\u25CF\u25CF   ",
  \   "\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF  ",
  \   "\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF ",
  \   "\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF\u25CF"
  \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline components

function! lightline#sensible#mode()
  return lightline#sensible#isHidden() ? '': lightline#mode()
endfunction

function! lightline#sensible#readonly()
  return lightline#sensible#isHidden() ? '': ( &readonly ? s:icon("\ufbce", "RO") : '' )
endfunction

function! lightline#sensible#filename()
  let fname = expand('%')
  if match(fname, 'vimspector\.') == 0
    return substitute(fname, '^vimspector\.', s:icon("\uf532 ", ''), '')
  end

  return lightline#sensible#isHidden() ? '': expand('%')
endfunction

function! lightline#sensible#modified()
  if lightline#sensible#isHidden()
    return ''
  endif
  return &modified ? s:icon("\uf055", "+") : ( &modifiable ? '' : s:icon("\uf023", "-") )
endfunction

function! lightline#sensible#lineinfo()
  return lightline#sensible#isHidden() ? '' : printf('%d:%-2d', line('.'), col('.'))
endfunction

function! lightline#sensible#percent()
  if lightline#sensible#isHidden()
    return ''
  endif

  let l = 100 * line('.') / line('$')
  let n = len(s:percentChars)
  let s = 100 / n

  let p = s:percentChars[0]

  let i = n - 1
  while i > 0
    if l > (s * i)
      let p = s:percentChars[i]
      break
    endif

    let i -= 1
  endwhile

  return p . ' ' . l . '%'
endfunction

function! lightline#sensible#fileformat()
  return lightline#sensible#isHidden() ? '': &fileformat
endfunction

function! lightline#sensible#fileencoding()
  return lightline#sensible#isHidden() ? '': (&fenc !=# '' ? &fenc : &enc)
endfunction

function! lightline#sensible#filetype()
  return lightline#sensible#isHidden() ? '': (&filetype !=# '' ? &filetype : 'no ft')
endfunction

function! lightline#sensible#branch()
  if lightline#sensible#isHidden()
    return ''
  endif

  let b = ''
  if exists('*fugitive#head')
    let b = fugitive#head()
  elseif exists('*gitbranch#name')
    let b = gitbranch#name()
  endif

  return b == '' ? '' : s:icon("\ue725", 'ᚴ') . " " . b
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Register

function! lightline#sensible#register() abort
  call s:setLightline('component_function', 'mode',         'lightline#sensible#mode')
  call s:setLightline('component_function', 'readonly',     'lightline#sensible#readonly')
  call s:setLightline('component_function', 'filename',     'lightline#sensible#filename')
  call s:setLightline('component_function', 'modified',     'lightline#sensible#modified')
  call s:setLightline('component_function', 'lineinfo',     'lightline#sensible#lineinfo')
  call s:setLightline('component_function', 'percent',      'lightline#sensible#percent')
  call s:setLightline('component_function', 'fileformat',   'lightline#sensible#fileformat')
  call s:setLightline('component_function', 'fileencoding', 'lightline#sensible#fileencoding')
  call s:setLightline('component_function', 'filetype',     'lightline#sensible#filetype')
  call s:setLightline('component_function', 'gitbranch',    'lightline#sensible#branch')
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" helper

function! s:setLightline(scope, name, value) abort
  let g:lightline = get(g:, 'lightline', {})
  let g:lightline[a:scope] = get(g:lightline, a:scope, {})
  let g:lightline[a:scope][a:name] =  get(g:lightline[a:scope], a:name, a:value)
endfunction

function! lightline#sensible#isHidden()
  if get(b:, 'lightline_hidden', v:false) == v:true
    return v:true
  endif

  let filetypes = ['nerdtree', 'startify', 'list', 'help', 'fugitive', 'fugitiveblame', 'qf', 'git']
  let filenames = [
    \ '[Plugins]', '__vista__', 'startify', 'NERDTree', 'Tagbar', 'Gundo',
    \   'vimspector.Variables', 'vimspector.Watches', 'vimspector.StackTrace', 'vimspector.Console'
    \ ]

  return index(filetypes, &filetype) != -1 || index(filenames, expand('%:t')) != -1
endfunction

function! s:icon(default, nerdfont) abort
  return get(g:, 'nerdfont', v:false) ? a:default : a:nerdfont
endfunction

