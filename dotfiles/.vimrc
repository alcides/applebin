set nocompatible               " be iMproved
filetype on
filetype off                   " required!

" Ack
noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>


filetype plugin indent on

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

set incsearch
set autoread " Load files from outside

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set background=dark
syntax on
filetype on
filetype plugin on
filetype indent on

set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set number

" Font settings
"set guifont=Inconsolata-dz:h14

set encoding=utf8
try
    lang en_US
catch
endtry

" always set autoindenting on
set autoindent

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

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

" Error marks
let g:syntastic_enable_signs=1

" Highlight trailing whitespace
"set list listchars=trail:.,tab:>.
"highlight SpecialKey ctermfg=DarkGray ctermbg=Black

" Disable toolbar
if has("gui_running")
    set guioptions=egmrt
else
    colorscheme torte
endif

" Latex Stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Alcides: Tab bar
hi TabLineSel guifg=#857b6f guibg=#000000 cterm=None ctermfg=Cyan ctermbg=Grey

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

set number
set numberwidth=5

filetype plugin indent on

command! W :w
map <leader>r :QuickRun
map <leader>s :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>


" Always show tab bar
set showtabline=2

map <leader>f :CommandT<cr>
map <leader>t :CommandT<cr>
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
