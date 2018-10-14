"Vundle setup:

set nocompatible              " required (not comp old vi)
filetype off                  " required


" set the runtime path to include vim-olug and initialize
call plug#begin('~/.vim/plugged')

" Add all your plugins here 

Plug 'Valloric/YouCompleteMe', { 'dir': '~/.vim/plugged/YouCompleteMe', 'do': './install.py --js-completer' }   "completion and goto. Can add flags to install for more languages!
Plug 'junegunn/vim-plug'        " package manager
Plug 'elzr/vim-json'            "easier to read json
Plug 'tpope/vim-commentary'     "gcc = comment
Plug 'tpope/vim-surround'	     " yss) cs]} ds' etc to change surround etc
Plug 'tpope/vim-sleuth'	            " detects indentation style for buffer
Plug 'airblade/vim-gitgutter'   "shows changes since commit on the left
Plug 'vim-scripts/taglist.vim'  "split window to see all tags for GUI vim :TlistOpen
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " :FZF. Last part not necessary if brew install
Plug 'scrooloose/nerdtree'       " File system explorer
Plug 'Vimjas/vim-python-pep8-indent' 
Plug 'w0rp/ale'                  " Async lint engine, for all languages
Plug 'mileszs/ack.vim'           " Search file content with :Ack [options] {pattern} [{directories}]
Plug 'tpope/vim-fugitive'         "git wrapper

Plug 'junegunn/fzf.vim'         " This or the above might have broken prezto completions ? 

" Plug 'maxbrunsfeld/vim-yankstack' " alt/meta-p to cycle yanks. Will remap y and d internally.
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

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" All of your Plugins must be added before the following line
call plug#end()
" Brief help
" :PlugSnapshot   - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"let g:markdown_composer_external_renderer='pandoc -f markdown -t html'

" YouCompleteMe requires python.
" pip2 install --user --upgrade neovim
" pip3 install --user --upgrade neovim

" It also has to be built. This is done by running `install.py` in:
" `~/.vim/plugged/YouCompleteMe`

" Let ack use silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let mapleader = ','

" Search file content (ack uses ag)
nnoremap <Leader>a :Ack!<Space>

" fzf.vim searching
" nmap ; :Buffers<CR>
" nmap <Leader>t :Files<CR>
" nmap <Leader>r :Tags<CR>

" Autofix python:
nmap <Leader>f :Black<CR>

"Default is same-buffer, but does not work with unsaved changes:
"let g:ycm_goto_buffer_command = 'same-buffer'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Toggle ale linter
map <leader>e :ALEToggle <CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" autocmd VimEnter * ALEDisable

let g:ale_fix_on_save = 1
let g:ale_maximum_file_size = 500000                " Don't lint large files (> 500KB), it can slow things down
let g:ale_linters = {}
let g:ale_linters.javascript = ['eslint', 'xo']
let g:ale_linters.python = ['flake8']
let g:ale_linters.html = []
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier']
let g:ale_fixers.python = ['yapf', 'trim_whitespace'] ", 'isort']
let g:ale_python_flake8_options = "max-line-length = 81"

let g:ale_sign_error = '💣'
let g:ale_sign_warning = '⚠'

highlight clear ALEErrorSign
highlight clear ALEWarningSign

" Fuzzy search file
nnoremap <C-p> :FZF! <CR>

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

" Reload file when changed (e.g. with git) 
set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

" wrap markdown:
au BufRead,BufNewFile *.md setlocal textwidth=80

"makes command use aliases, i.e. a user terminal session. this hack makes vim crash a lot
"set shellcmdflag+=i

"Escape terminal mode in neovim:
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

"space to single char map
" :nmap <Space> i_<Esc>r

" paste in visual mode with p"
vnoremap p "_dP

" Clipboard sharing on mac osx, first run brew install vim
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

set mouse=a
set mousef

" set margin wrapping
set wrapmargin=1

set splitright    " spawn vertical splits to the right instead of left"

"emacs in command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>


" Helpful keybindings for function keys on a mac
"map! only does in command and insert mode.
"use read in bash to see what to map (like <esc>[5~

"map <Esc>[5~ <C-B>
"map <Esc>[6~ <C-F>
"map <Esc>[3~ x
"map! <Esc>[3~ <Del>

"map <Esc>[H 0
"map <Esc>[F $
"map! <Esc>[H <Home>
"map! <Esc>[F <End>  


" Pydiction:
"filetype plugin on
"let g:pydiction_location = '/Users/anton/.vim/bundle/pydiction/complete-dict'

" DONT know what the below does, should figure out:

" System vimrc file for Mac OS X
" Author:  Benji Fisher <benji@member.AMS.org>
" Last modified:  8 May 2006

" Note:  Do not move this to the gvimrc file, else this value of $PATH will
" not be available to plugin scripts.
if has("gui_running") && system('ps xw | grep "Vim -psn" | grep -vc grep') > 0
  " Get the value of $PATH from a login shell.
  " If your shell is not on this list, it may be just because we have not
  " tested it.  Try adding it to the list and see if it works.  If so,
  " please post a note to the vim-mac list!
  if $SHELL =~ '/\(sh\|csh\|bash\|tcsh\|zsh\)$'
    let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
    let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
  endif
endif


" Vim color file
" Maintainer:   Gerald S. Williams
" Last Change:  2003 Mar 20

" This is a dark version/opposite of "seashell". The cterm version of this is
" very similar to "evening".
"
" Only values that differ from defaults are specified.

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

hi Normal guibg=Black guifg=seashell ctermfg=White
hi NonText guifg=LavenderBlush ctermfg=LightMagenta
hi DiffDelete guibg=DarkRed guifg=Black ctermbg=DarkRed ctermfg=Black
hi DiffAdd guibg=DarkGreen ctermbg=DarkGreen ctermfg=Black
hi DiffChange guibg=Gray30 ctermbg=DarkCyan ctermfg=Black
hi DiffText gui=NONE guibg=Cyan ctermbg=Cyan ctermfg=Black
hi Comment guifg=LightBlue
hi Constant guifg=DeepPink
hi PreProc guifg=Magenta ctermfg=Magenta
hi StatusLine guibg=Black guifg=Gray30 cterm=NONE ctermfg=Black ctermbg=LightGray
hi StatusLineNC guifg=Gray
hi VertSplit guifg=Gray
hi Type gui=NONE
hi Identifier guifg=Cyan
hi Statement guifg=brown3 ctermfg=DarkRed

" Colors for vimdiff:
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
