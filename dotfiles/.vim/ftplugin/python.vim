" Execute file being edited with <Shift> + e:
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Autocomplete
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python set completeopt-=preview
