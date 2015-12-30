
set nocompatible
filetype off

let first_vundle = 0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Vundle is missing. Installing..."
    silent !mkdir -p ~/.vim/bundle
    silent !git clone 'https://github.com/gmarik/vundle.vim' ~/.vim/bundle/Vundle.vim
    let first_vundle = 1
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'gmarik/Vundle.vim'
Plugin 'sjl/gundo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'godlygeek/tabular'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'

" Git plugins
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" Color schemes
Plugin 'nanotech/jellybeans.vim'

" Rust Plugins
Plugin 'rust-lang/rust.vim'

" python addons
" Plugin 'davidhalter/jedi-vim'
"  when changed or updates neede call :PluginInstall
call vundle#end()
if first_vundle == 1
    echo "Installing Plugins..."
    :VundleInstall
endif

colorscheme jellybeans

set modeline
filetype plugin indent on
syntax on

" I want these to be my default, I'll add at the bottom any changes
" needed such as for makefiles
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set nowrap
set autoindent
set backspace=indent,eol,start
set scrolloff=3
set smartcase
set incsearch
set hlsearch
set autowrite

" Centralize backup and swap files
silent execute '!mkdir ~/.vim ~/.vim/backup ~/.vim/tmp >/dev/null 2>&1'
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/tmp//
set writebackup

set ttimeout
set ttimeoutlen=200
set display+=lastline
set history=1000
set cmdheight=2
set wildmenu
set showmatch
set autoread
set showcmd
set showmode
set number
set cursorline      "underlines current line
set colorcolumn=80  "put a red line at 80 char column
set visualbell

set foldenable
set foldmethod=marker
" hi Folded ctermfg=7
" hi Folded ctermbg=23


" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" {{{ UltiSnip

let g:UltiSnipsExpandTrigger = "<C-SPACE>"
let g:UltiSnipsJumpForwardTrigger = "<C-n>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"


" }}}

"Statusline {{{

    set laststatus=2
    set statusline =%#identifier#
    set statusline+=[%t]    "tail of the filename
    set statusline+=%*

    "display a warning if fileformat isnt unix
    set statusline+=%#warningmsg#
    set statusline+=%{&ff!='unix'?'['.&ff.']':''}
    set statusline+=%*

    "display a warning if file encoding isnt utf-8
    set statusline+=%#warningmsg#
    set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
    set statusline+=%*

    set statusline+=%h      "help file flag
    set statusline+=%y      "filetype

    "read only flag
    set statusline+=%#identifier#
    set statusline+=%r
    set statusline+=%*

    "modified flag
    set statusline+=%#identifier#
    set statusline+=%m
    set statusline+=%*
    set statusline+=%=\ col\ %c%V\ \ line\ %l\,%L\ %P

    set statusline+=%{fugitive#statusline()}
"}}}

"TMUX fixes {{{

if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
        set t_Co=256
else
        let &t_SI = "\e[5 q"
        let &t_EI = "\e[2 q"
endif

"}}}

" toggle number to relative number function {{{
function! ToggleRelativeNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    end
endfunc
command! ToggleRelativeNumber call ToggleRelativeNumber()
" }}}

" Tabularize noremaps {{{
"tabularize signs so that they are aligned
vnoremap ;t= :Tabularize /=<CR>
nnoremap ;t= :Tabularize /=<CR>
vnoremap ;t# :Tabularize /#<CR>
nnoremap ;t# :Tabularize /#<CR>
vnoremap ;t/ :Tabularize //<CR>
nnoremap ;t/ :Tabularize //<CR>
"tabularize colons, so that whatever is after them in aligned
vnoremap ;t: :Tabularize /:\zs<CR>
nnoremap ;t: :Tabularize /:\zs<CR>
" tabularize pipe delimited tables
vnoremap ;tt :Tabularize /\|<CR>
nnoremap ;tt :Tabularize /\|<CR>
" }}}

" NERDTree autocmd and maps {{{

let g:NERDTreeDirArrows=0

nnoremap ;e :NERDTreeToggle<CR>

" }}}

nnoremap ;; :nohlsearch<CR>
nnoremap ;s :w<CR>
nnoremap ;n :ToggleRelativeNumber<CR>
nnoremap ;k :bn<CR>
nnoremap ;j :bp<CR>
nnoremap ; <Nop>
" too many times have I missed ; to substitute stuff unintentionally
nnoremap s <Nop>

nmap j gj
nmap k gk
nnoremap H ^
nnoremap L $
nnoremap $ <Nop>
nnoremap ^ <Nop>


"Folded maps:

" ;e :NERDTreeToggle<CR>
" ;gs <Plug>GitGutterStageHunk
" ;gr <Plug>GitGutterRevertHunk
" ;t{=,#,/,:,|} Tabularize
" ;u :GundoToggle<CR>
" ;S :SyntasticCheck<CR>

"GitGutter settings {{{
let g:gitgutter_map_keys=0
"let g:gitgutter_realtime=0
let g:gitgutter_eager=1
nnoremap ;gs <Plug>GitGutterStageHunk
nnoremap ;gr <Plug>GitGutterRevertHunk
"}}}

"Gundo settings {{{
let g:gundo_close_on_revert=1
let g:gundo_prefer_python3 = 1
nnoremap ;u :GundoToggle<CR>
"}}}
" {{{ Syntasic settings
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap ;S :SyntasticCheck<CR>
" }}}
" make specific settings{{{

autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" }}}
