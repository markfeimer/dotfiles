colorscheme monokai

syntax enable

" indenting
filetype plugin indent on
set noexpandtab     " Use softtabstop spaces instead of tab characters
set shiftwidth=2    " Indent by 2 spaces when using >>, <<, == etc.
set softtabstop=2   " Indent by 2 spaces when pressing <TAB 
set tabstop=2       " Indent by 2 spaces when pressing <TAB>
set autoindent      " Keep indentation from previous line

" line numbers, yes
set number
set nuw=6  " number width to 6 makes things look a little neater

" word wrap, no
set nowrap

" Height of the command bar
set cmdheight=2

" set blank space characters
set list
set listchars=tab:␉·

" colors, yes
set t_Co=256

set clipboard=unnamed
set nostartofline
set showcmd
set statusline+=%F
set laststatus=2

" open .md as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" plugins
execute pathogen#infect()

let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1

" close a buffer
noremap <leader>h :bd<Enter>

" file manipulation
nnoremap <leader><space> :Vexplore<Enter> 
let g:netrw_liststyle=3

" for faster ctrlp plugin fuzzy find
set wildignore+=*/node_modules/*,*/vendor_libs/*

