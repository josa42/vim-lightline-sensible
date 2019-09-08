# lightline-sensible

## Installation

Install using a plugin manager of your choice, for example [`vim-plug`](https://github.com/junegunn/vim-plug):

```viml
Plug 'josa42/vim-lightline-sensible'
```

## Features

- All components are hidden in [`NERDTree`](https://github.com/scrooloose/nerdtree) or other plugin buffers.  
  If I missed something, feel free to open an issue.

## Components

- `mode`
- `readonly`
- `filename`
- `modified`
- `lineinfo`
- `percent`
- `fileformat`
- `fileencoding`
- `filetype`
- `gitbranch` Show current git branch  
  **Requires [`vim-fugitive`](https://github.com/tpope/vim-fugitive) or [`vim-gitbranch`](https://github.com/itchyny/vim-gitbranch)**

## Integration

```viml
let g:lightline = {
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'gitbranch'],
  \       [ 'readonly', 'filename', 'modified' ],
  \     ],
  \     'right': [
  \       [ 'lineinfo' ],
  \       [ 'percent' ],
  \       [ 'fileformat', 'fileencoding', 'filetype' ],
  \     ]
  \   },
  \ }

" register compoments:
call lightline#sensible#register()
```

## Configuration

* `g:lightline#sensible#branch_icon`  
  Icon that is shown next to the branch.
* `lightline#sensible#percent_chars'`
* `g:lightline#sensible#modified_indicator`
* `g:lightline#sensible#not_modifiable_indicator`

## Helper

- `lightline#sensible#isHidden()`
  Can be used in custom components:

  ```viml
  function! MyComponent()
    if exists('*lightline#sensible#isHidden') && lightline#sensible#isHidden()
      return ''
    endif
    return 'Hello'
  endfunction

  let g:lightline['component_function']['my_component'] = 'MyComponent'
  ```

## License

[MIT © Josa Gesell](LICENSE)
