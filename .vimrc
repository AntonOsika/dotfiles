"Vundle setup:

set nocompatible              " required (not comp old vi)
filetype off                  " required


" Changed from vundle to vim-plug. Should cleanup vundle references below, delete vundle repo, and put in brew_installs

" set the runtime path to include vim-olug and initialize
call plug#begin('~/.vim/plugged')

" Add all your plugins here 

Plug 'Valloric/YouCompleteMe', { 'dir': '~/.vim/plugged/YouCompleteMe', 'do': './install.py' }   "completion and goto. Can add flags to install for more languages!
Plug 'junegunn/vim-plug'        " package manager
Plug 'elzr/vim-json'            "easier to read json
Plug 'tpope/vim-commentary'     "gcc = comment
Plug 'airblade/vim-gitgutter'   "shows changes since commit on the left
Plug 'vim-scripts/taglist.vim'  "split window to see all tags for GUI vim :TlistOpen
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " :FZF. Last part not necessary if brew install
Plug 'goerz/ipynb_notedown.vim' " When opening .ipynb files this should do something useful ?
Plug 'tpope/vim-surround'	" yss) cs]} ds' etc to change surround etc

"Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Plug 'bling/vim-airline' " a smooth status/tabline for vim
"Plug 'suan/vim-instant-markdown' " like compose but slower
"Plug 'junegunn/fzf.vim'         " This or the above might have broken prezto completions ? 
"Plug 'ivanov/vim-ipython'      "should send commands to most recent ipython, not working.
"Plug 'xolox/vim-misc'           "prereq for vim-easytags
"Plug 'xolox/vim-easytags'       "auto update of global tags https://github.com/xolox/vim-easytags
"Plug 'chrisbra/Recover.vim'     " adds option to diff when swap file exists. Does not display message or Delete option in neovim atm.
"Plugin 'easymotion/vim-easymotion' ",,w = jump to word
"Plugin 'vim-pandoc/vim-pandoc'     "markdown thing
"Plugin 'vim-pandoc/vim-pandoc-syntax'
"Plugin 'tope/vim-fugitive'         "git wrapper

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


let mapleader = ','

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" from eleijonmarck:
nnoremap <C-p> :FZF! <CR>

" follow tags without pinky finger 
map gk <C-]>

" create tag
map <leader>t :!ctags -R -f ./tags . &<CR>

" open tlist
noremap <leader>l :TlistOpen

" Open zsh terminal
map <leader>z :vs term://zsh<CR>i

" Tab between buffers
noremap <tab> <c-w>w
noremap <S-tab> <c-w>W


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
:nmap <Space> i_<Esc>r

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
