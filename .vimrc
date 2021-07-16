
" .vimrc of Anton Osika
" 
" Overview 
" ========
"
" This .vimrc is made for neovim. It requires:
" - python3
" - jedi, pylint, language servers
" - silver-searcher, fzf
" - vim-plug
"
" Before installing necessary packages, set up your default python installation to a python 3.6, and set your
" PYTHONPATH to point to this python installation.
"
" If you are using a virtual environment `pip install neovim` in the virtual environment.
"
" If some plugin functionality is not working, make sure that you have installed the corresponding packages globally.
"
" Note:
" A lot of plugins are commented out so that I remember what I have decided to not use per default.


set nocompatible              " required (not compatible with old vi)
filetype off                  " required

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" set the runtime path to include vim-olug and initialize
call plug#begin('~/.vim/plugged')

" Add all your plugins here 

Plug 'junegunn/vim-plug'         " package manager
" Plug 'elzr/vim-json'             " easier to read json
Plug 'tpope/vim-commentary'      " gcc = comment
Plug 'tpope/vim-surround'	     " yss) cs]} ds' etc to change surround etc
Plug 'tpope/vim-sleuth'	         " detects indentation style for buffer
Plug 'airblade/vim-gitgutter'    " shows changes since commit on the left
Plug 'vim-scripts/taglist.vim'   " split window to see all tags for GUI vim :TlistOpen
Plug 'scrooloose/nerdtree'       " File system explorer
Plug 'mileszs/ack.vim'           " Search file content with :Ack [options] {pattern} [{directories}]
Plug 'tpope/vim-fugitive'        " git wrapper
Plug 'osyo-manga/vim-over'       " incsearch for substitution
Plug 'alfredodeza/pytest.vim'    " Run pytest
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " :FZF. Last part not necessary if brew install
Plug 'junegunn/fzf.vim'          " ctrl-f to open files.
Plug 'morhetz/gruvbox'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'Vimjas/vim-python-pep8-indent' 

Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

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

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Brief vim-plug help
" :PlugSnapshot   - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" </Plugins>
call plug#end()

" let g:markdown_composer_external_renderer='pandoc -f markdown -t html'

" Set mac python path for neovim:
let g:os = substitute(system('uname'), '\n', '', '')
if g:os == "Darwin"
  let g:python3_host_prog = '/usr/local/bin/python3'
  let g:python_host_prog  = '/usr/bin/python2'
else " Linux
  let g:python3_host_prog = '/usr/bin/python3'
  let g:python_host_prog  = '/usr/bin/python2'
endif


let mapleader = ','

" ####### Multi Cursor #######
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'

augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

####### COC #######

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()


" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)


let g:coc_global_extensions = [
        \ 'coc-css',
        \ 'coc-json',
        \ 'coc-tsserver',
        \ 'coc-git',
        \ 'coc-eslint',
        \ 'coc-tslint-plugin',
        \ 'coc-pairs',
        \ 'coc-sh',
        \ 'coc-vimlsp',
        \ 'coc-emmet',
        \ 'coc-prettier',
        \ 'coc-ultisnips',
        \ 'coc-explorer',
        \ 'coc-jedi',
        \ 'coc-go'
        \ ]

hi! CocErrorSign guifg=#d1666a
" hi! CocInfoSign guibg=#353b45
" hi! CocWarningSign guifg=#d1cd66

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc-format
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>f <Plug>(coc-format)

" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)
nmap gu :CocCommand git.chunkUndo<cr>

nmap <silent> <leader>k :CocCommand explorer<cr>

"remap keys for gotos
" nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh <Plug>(coc-doHover)

" diagnostics navigation
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)


" rename
nmap <silent> <leader>rn <Plug>(coc-rename)

" organize imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

"tab completion
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" ####### SEARCH #######

" Let ack use silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Search file content (ack uses ag)
nnoremap <leader>g :Ack!<Space>

" Fast saving (less use of pinky finger)
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>x :x<CR>

" Fuzzy search file
nnoremap <C-f> :FZF! <CR>

" Better command history with q::
command! CmdHist call fzf#vim#command_history({'right': '40'})
nnoremap q: :CmdHist<CR>

" ##### MISC #####

" pytest
nmap <leader>pt :Pytest project<CR>
nmap <leader>pn :Pytest next<CR>

" Switch tabs
nnoremap <C-h> :tabp <CR>
nnoremap <C-l> :tabn <CR>

" Next buffer
nnoremap <C-p> :bprevious<CR>
nnoremap <C-b> :bnext<CR>

" follow tags without pinky finger 
map gk <C-]>

" create tags
" map <leader>t :!ctags -R -f ./tags . &<CR>

" open tlist
noremap <leader>l :TlistOpen<CR>

" open nerdtree
noremap <leader>t :NERDTreeToggle<CR>

" Open zsh terminal
map <leader>z :vs term://zsh<CR>i

" open vimrc
nmap <leader>, :e ~/.vimrc<CR>

" cd to current buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>

"set smartindent " Comments makes comments not be indented
set tabstop=4
set shiftwidth=4
set expandtab

" set auto-indenting on for programming
set ai

" highlight current line
set cul

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

"Escape terminal mode in neovim:
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" paste in visual mode with p"
vnoremap p "_dP

" Search without special character treatment with :SS
command! -nargs=1 S let @/ = '\V'.escape(<q-args>, '\')

" Clipboard sharing on mac osx (requires later versions)
set clipboard=unnamed
set clipboard+=unnamedplus

"  Copy to clipboard
"vnoremap  <leader>y  "+y
"nnoremap  <leader>Y  "+yg_
"nnoremap  <leader>y  "+y
"nnoremap  <leader>yy  "+yy
"
"" Paste from clipboard
"nnoremap <leader>p "+p
"nnoremap <leader>P "+P
"vnoremap <leader>p "+p
"vnoremap <leader>P "+P

" look for tags in parent dir if not found
set tags=./tags;/

" turn color syntax highlighting on by default
" set term=builtin_beos-ansi
syntax on
autocmd vimenter * colorscheme gruvbox

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

" highlight words when searching for them. it's distracting.
set hlsearch
set incsearch

" highlight visual selection
vnoremap // y/<C-R>"<CR>gv

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


" Set tab width etc
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

try
    " colorscheme desert
catch
endtry


" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set termguicolors

" set background=transparent
hi Normal guibg=NONE ctermbg=NONE

" colo mycolo

" Colors for vimdiff:
" highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
