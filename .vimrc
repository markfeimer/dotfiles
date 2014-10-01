colorscheme monokai

syntax enable

" indenting
filetype plugin indent on
set expandtab       " Use softtabstop spaces instead of tab characters
set shiftwidth=2    " Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=2   " Indent by 4 spaces when pressing <TAB 
set tabstop=2       " Indent by 4 spaces when pressing <TAB>
set autoindent      " Keep indentation from previous line

" line numbers, yes
set number
set nuw=6  " number width to 6 makes things look a little neater

" word wrap, no
set nowrap

" Height of the command bar
set cmdheight=2

" colors, yes
set t_Co=256

set clipboard=unnamed
set nostartofline
set showcmd
set statusline+=%F
set laststatus=2

" plugins
execute pathogen#infect()

let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
