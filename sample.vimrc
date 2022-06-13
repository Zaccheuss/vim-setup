call plug#begin()
Plug 'vim-airline/vim-airline'
call plug#end()

set hidden 	   "open files in other buffers without saving
set number         "turn line numbers on
set colorcolumn=80 "show vertical line at 80 characters
set scrolloff=4    "scroll when cursor is within 4 lines of the end of screen
set tabstop=2      "indent size
set autoindent     "indent size
set shiftwidth=2   "indent size
set showmatch      "show matching brackets
set ignorecase     "case insensitive matching
set smartcase      "do case sensitive matching when a capital letter is typed
set incsearch	   "incremental search, show matches as you are typing

"cursor fix in windows terminal
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
