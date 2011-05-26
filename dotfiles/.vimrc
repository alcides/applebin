" Pathogen to manage bundles
call pathogen#runtime_append_all_bundles() 

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set background=dark
colorscheme solarized
syntax on

set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set number

" Font settings
"set guifont=Inconsolata-dz:h14

" always set autoindenting on
set autoindent

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set cinkeys=0{,0},:,!^F

" Backups
set nobackup
set nowritebackup
set noswapfile


set pastetoggle=<F2>

set showmatch

" GRB: wrap lines at 78 characters
set textwidth=78

" GRB: highlighting search"
set hls

" Highlight
highlight Comment         ctermfg=DarkGrey guifg=#444444
highlight StatusLineNC    ctermfg=Black ctermbg=DarkGrey cterm=bold
highlight StatusLine      ctermbg=Black ctermfg=LightGrey

" Highlight trailing whitespace
set list listchars=trail:.,tab:>.
highlight SpecialKey ctermfg=DarkGray ctermbg=Black


" Latex Stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'


" GRB: Always source python.vim for Python files
au FileType python source ~/.vim/scripts/python.vim

" GRB: Use custom python.vim syntax file
au! Syntax python source ~/.vim/syntax/python.vim
let python_highlight_all = 1
let python_slow_sync = 1

" Remap the tab key to do autocompletion or indentation depending on the
" context (from http://www.vim.org/tips/tip.php?tip_id=102)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

set switchbuf=useopen

autocmd BufRead,BufNewFile *.html source ~/.vim/indent/html_grb.vim
autocmd FileType htmldjango source ~/.vim/indent/html_grb.vim

set number
set numberwidth=5

filetype plugin indent on

command! W :w
command! R :!python %

map <leader>rm :BikeExtract<cr>

function! ExtractVariable()
    let name = input("Variable name: ")
    if name == ''
        return
    endif
    " Enter visual mode (not sure why this is needed since we're already in
    " visual mode anyway)
    normal! gv

    " Replace selected text with the variable name
    exec "normal c" . name
    " Define the variable on the line above
    exec "normal! O" . name . " = "
    " Paste the original selected text to be the variable value
    normal! $p
endfunction

" Always show tab bar
set showtabline=2

map <leader>f :CommandT<cr>
nmap <leader><left>   :leftabove  vnew<CR>
nmap <leader><right>  :rightbelow vnew<CR>
nmap <leader><up>     :leftabove  new<CR>
nmap <leader><down>   :rightbelow new<CR>

set showfulltag
set wildmode=longest:full     " *wild* mode
set wildignore+=*.o,*~,.lo    " ignore object files
set wildmenu                  " menu has tab completion

" Ruby Stuff
au BufRead,BufNewFile *.ru         set ft=ruby
au BufRead,BufNewFile Rakefile     set ft=ruby


" Java Stuff
let g:EclimBrowser='open'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionTypeDiscovery = [
                  \ "&completefunc:<c-x><c-u>",
                  \ ]
let g:SuperTabLongestHighlight = 1
let NERDTreeIgnore=['\.class$', '\~$', '\.swp$', '\.pyc$','\bin$']
