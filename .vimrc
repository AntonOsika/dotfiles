"Vundle setup:

set nocompatible              " required (not comp old vi)
filetype off                  " required

" set the runtime path to include vim-olug and initialize
call plug#begin('~/.vim/plugged')

" Add all your plugins here 

Plug 'junegunn/vim-plug'        " package manager
Plug 'elzr/vim-json'            "easier to read json
Plug 'tpope/vim-commentary'     "gcc = comment
Plug 'tpope/vim-surround'	     " yss) cs]} ds' etc to change surround etc
Plug 'tpope/vim-sleuth'	            " detects indentation style for buffer
Plug 'airblade/vim-gitgutter'   "shows changes since commit on the left
Plug 'vim-scripts/taglist.vim'  "split window to see all tags for GUI vim :TlistOpen
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " :FZF. Last part not necessary if brew install
Plug 'scrooloose/nerdtree'       " File system explorer
Plug 'w0rp/ale'                  " Async lint engine, for all languages
Plug 'mileszs/ack.vim'           " Search file content with :Ack [options] {pattern} [{directories}]
Plug 'tpope/vim-fugitive'         "git wrapper
Plug 'junegunn/fzf.vim'         " This or the above might have broken prezto completions ? 

" Completion Engine
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-vim-lsp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'  " buffer keyword completion
Plug 'ncm2/ncm2-path'  " filepath completion
Plug 'davidhalter/jedi-vim'   " jedi for python

" Plug 'ncm2/ncm2-jedi'  " fast python completion (use ncm2 if you want type info or snippet support)
" Plug 'Valloric/YouCompleteMe', { 'dir': '~/.vim/plugged/YouCompleteMe', 'do': './install.py --js-completer' }   "completion and goto. Can add flags to install for more languages!
" Plug 'Vimjas/vim-python-pep8-indent' 
" Plug 'maxbrunsfeld/vim-yankstack' " alt/meta-p to cycle yanks. Will remap y and d internally.
" Plug 'Vimjas/vim-python-pep8-indent' 
" Pip instal black and flak8 instead
" Plug 'ambv/black'                " Autofix python code
" Plug 'goerz/ipynb_notedown.vim'  " When opening .ipynb files this should do something useful ?
" Plug 'nvie/vim-flake8'            " python lint, use F7 or: autocmd BufWritePost *.py call Flake8()
"Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plug 'bling/vim-airline' " a smooth status/tabline for vim
"Plug 'suan/vim-instant-markdown' " like compose but slower
"Plug 'ivanov/vim-ipython'      "should send commands to most recent ipython, not working.
"Plug 'xolox/vim-misc'           "prereq for vim-easytags
"Plug 'xolox/vim-easytags'       "auto update of global tags https://github.com/xolox/vim-easytags
"Plug 'chrisbra/Recover.vim'     " adds option to diff when swap file exists. Does not display message or Delete option in neovim atm.
"Plug 'easymotion/vim-easymotion' ",,w = jump to word
"Plug 'vim-pandoc/vim-pandoc'     "markdown thing
"Plug 'vim-pandoc/vim-pandoc-syntax'

" Fast rust markdown to browser
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --manifest-path ~/.vim/plugged/vim-markdown-composer
    else
      !cargo build --release --manifest-path ~/.vim/plugged/vim-markdown-composer --no-default-features --features json-rpc
    endif
  endif
endfunction

" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Brief vim-plug help
" :PlugSnapshot   - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" </Plugins>
call plug#end()
"""""""""""""""""""""""""""""""""

" let g:markdown_composer_external_renderer='pandoc -f markdown -t html'

let mapleader = ','

" Language Server plugins

if executable('pyls')
  " pip install python-language-server
  au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('docker-langserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
endif

if executable('go-langserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
endif

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki

" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
" make it very fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1,1]]
let g:ncm2#matcher = 'substrfuzzy'

" number of suggestions in popup
set pumheight=5

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" enter closes popup if nothing selected
inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

" disable Jedi features (using ncm2 for those):
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0

" Let ack use silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Search file content (ack uses ag)
nnoremap <Leader>a :Ack!<Space>

" fzf.vim searching
" nmap ; :Buffers<CR>
" nmap <Leader>t :Files<CR>
" nmap <Leader>r :Tags<CR>

" Fast saving (less using pinky finger)
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

" Below is handled by jedi (,g and ,d)
" nnoremap K :LspHover<CR>
" nnoremap <leader>d :LspDefinition<CR>

" Toggle ale linter
map <leader>e :ALEToggle <CR>
map <leader>f :ALEFix <CR>

" Go to next error/warning
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <leader>g <Plug>(ale_go_to_definition) " Not working

let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0
let g:ale_maximum_file_size = 500000                " Don't lint large files (> 500KB), it can slow things down
let g:ale_linters = {}
let g:ale_linters.python = ['pylint', 'flake8']
let g:ale_linters.go = ['go', 'golint', 'errcheck']
let g:ale_linters.javascript = ['eslint', 'xo']
let g:ale_linters.html = []
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.python = ['yapf', 'trim_whitespace']

let g:ale_python_flake8_options = "max-line-length = 81"
let g:ale_python_pylint_options = "max-line-length = 81"

let g:ale_sign_error = '💣'
let g:ale_sign_warning = '⚠'

highlight clear ALEErrorSign
highlight clear ALEWarningSign


" Fuzzy search file
nnoremap <C-f> :FZF! <CR>

" Switch tabs
nnoremap <C-h> :tabp <CR>
nnoremap <C-l> :tabn <CR>

" follow tags without pinky finger 
map gk <C-]>

" create tags
" map <leader>t :!ctags -R -f ./tags . &<CR>

" open tlist
noremap <leader>l :TlistOpen<CR>

" open nerdtree
noremap <leader>n :NERDTreeToggle<CR>

" Open zsh terminal
map <leader>z :vs term://zsh<CR>i

" open vimrc
nmap <leader>, :e ~/.vimrc<CR>

" cd to current buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>

" map paste, yank and delete to named register so the content
" will not be overwritten
nnoremap x "_x
vnoremap x "_x

"set smartindent " Comments makes comments not be indented
set tabstop=4
set shiftwidth=4
set expandtab

" set auto-indenting on for programming
set ai

" Disable automatic comments.  These get annoying
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" set line numbers
set nu

" make :diffsplit {filename} split vertically
set diffopt+=vertical

" Reload file when changed (e.g. with git) 
set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

" wrap markdown:
au BufRead,BufNewFile *.md setlocal textwidth=80

"makes !command use .zshrc aliases, i.e. a user terminal session. this hack makes vim crash
"set shellcmdflag+=i

"Escape terminal mode in neovim:
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" paste in visual mode with p"
vnoremap p "_dP

" Clipboard sharing on mac osx (requires later versions)
set clipboard=unnamed

" look for tags in parent dir if not found
set tags=./tags;/

" turn color syntax highlighting on by default
" set term=builtin_beos-ansi
syntax on

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

" highlight words when searching for them. it's distracting.
set hlsearch

" case insensitive. Put \C anywhere in search to do case sensitive (opposite of \c)
set ignorecase

" automatically use case sensitive if it contains upper case chars (unless \c or \C is used)
set smartcase

" case-insensitive vim command line completion. vim-ambicmd does this and more.
set wildignorecase

" automatically show matching brackets. works like it does in bbedit.
set showmatch

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set noeol

" make that backspace key work the way it should
set backspace=indent,eol,start

" Mouse. Really necessary in nvim?
set mouse=a
set mousef

" set margin wrapping
set wrap

set splitright   " spawn vertical splits to the right instead of left"
set splitbelow   " spawn splits below

"emacs in command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>


" Jonas valfridssons {} creation:

inoremap (<CR> ()<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> []<Esc>i
inoremap [; [];<Esc>i<Esc>i
inoremap [, [],<Esc>i<Esc>i


" Set tab width etc
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Works poorly for git diffs:
" hi Normal guibg=Black guifg=seashell ctermfg=White
" hi NonText guifg=LavenderBlush ctermfg=LightMagenta
" hi DiffDelete guibg=DarkRed guifg=Black ctermbg=DarkRed ctermfg=Black
" hi DiffAdd guibg=DarkGreen ctermbg=DarkGreen ctermfg=Black
" hi DiffChange guibg=Gray30 ctermbg=DarkCyan ctermfg=Black
" hi DiffText gui=NONE guibg=Cyan ctermbg=Cyan ctermfg=Black
" hi Comment guifg=LightBlue
" hi Constant guifg=DeepPink
" hi PreProc guifg=Magenta ctermfg=Magenta
" hi StatusLine guibg=Black guifg=Gray30 cterm=NONE ctermfg=Black ctermbg=LightGray
" hi StatusLineNC guifg=Gray
" hi VertSplit guifg=Gray
" hi Type gui=NONE
" hi Identifier guifg=Cyan
" hi Statement guifg=brown3 ctermfg=DarkRed


" Colors for vimdiff:
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
