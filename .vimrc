set autoread                                        " autoload files edited from the outside
" let mapleader = ","                                 " master key is now the comma (look for more informations)
autocmd! bufwritepost vimrc source ~/.vimrc         " autoload .vimrc when it's been modified
set ruler                                           " always show current position
set nowrap                                          " set no wrap (!)
set hid                                             " change buffer without saving
set hlsearch                                        " highlight the search
set incsearch                                       " like a good old browser search
set encoding=utf8                                   " may be usefull who knows?
set nobackup                                        " no backup
set noswapfile                                      " no swap file
set expandtab                                       " tab no more spaces are better
set shiftwidth=2                                    " when entering a tab it's replaced with two spaces
set tabstop=2                                       " tabs are all replaced with two spaces
set smartindent                                     " smart indent
imap ii <esc>                                       " type ii instead of esc
map <leader>tn :tabnew<cr>                          " backslash plus t and n create a new tab
map <leader>tc :tabclose<cr>                        " backslash plus t and c close a tab
map <leader>n  :NERDTree<cr>                        " backslash plus n open NERDTree
set laststatus=2                                    " always display the status line
set list
set listchars=eol:¬,trail:·,tab:»·
set number
set mouse=a                                         " Enable mouse for a(ll)
filetype plugin indent on                           " enable third party plugin autoindent

" Refactore me:
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ asc
" set statusline +=%1*\ %n\ %*            "buffer number
" set statusline +=%5*%{&ff}%*            "file format
" set statusline +=%3*%y%*                "file type
" set statusline +=%4*\ %<%F%*            "full path
" set statusline +=%2*%m%*                "modified flag
" set statusline +=%1*%=%5l%*             "current line
" set statusline +=%2*/%L%*               "total lines
" set statusline +=%1*%4v\ %*             "virtual column number
" set statusline +=%2*0x%04B\ %*          "character under cursor

" Third part:

" pathogen
call pathogen#infect()

" nerdtree
" autocmd vimenter * NERDTree " autoload NERDTree

" AND CHANGE THAT FREAKING DEFAULT THEME!
