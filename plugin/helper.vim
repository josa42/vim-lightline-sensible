let g:lightline = get(g:, 'lightline', {})
let g:lightline['component_function'] = get(g:lightline, 'component_function', {})

let g:lightline['component_function']['mode']         = 'lightline#helper#mode'
let g:lightline['component_function']['readonly']     = 'lightline#helper#readonly'
let g:lightline['component_function']['filename']     = 'lightline#helper#filename'
let g:lightline['component_function']['modified']     = 'lightline#helper#modified'
let g:lightline['component_function']['lineinfo']     = 'lightline#helper#lineinfo'
let g:lightline['component_function']['percent']      = 'lightline#helper#percent'
let g:lightline['component_function']['fileformat']   = 'lightline#helper#fileformat'
let g:lightline['component_function']['fileencoding'] = 'lightline#helper#fileencoding'
let g:lightline['component_function']['filetype']     = 'lightline#helper#filetype'
let g:lightline['component_function']['cocstatus']    = 'lightline#coc#status'
let g:lightline['component_function']['gitbranch']    = 'lightline#helper#branch'


