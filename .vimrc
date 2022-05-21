
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

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'morhetz/gruvbox'           " Colorshcema
Plug 'dpelle/vim-LanguageTool'           " grammarly ish

let g:languagetool_jar='$HOME/Applications/LanguageTool-5.2/languagetool-commandline.jar'

Plug 'neovim/nvim-lspconfig'

Plug 'pocco81/autosave.nvim'

Plug 'Vimjas/vim-python-pep8-indent' 
Plug 'github/copilot.vim'
Plug 'mhartington/formatter.nvim'


" Plug 'maxbrunsfeld/vim-yankstack' " alt/meta-p to cycle yanks. Will remap y and d internally.

"Plug 'xolox/vim-misc'           "prereq for vim-easytags
"Plug 'xolox/vim-easytags'       "auto update of global tags https://github.com/xolox/vim-easytags
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

" let g:markdown_composer_external_renderer='pandoc -f markdown -t html'

" Set mac python path for neovim:
" let g:os = substitute(system('uname'), '\n', '', '')
" if g:os == "Darwin"
"   let g:python3_host_prog = '/usr/local/bin/python3'
"   let g:python_host_prog  = '/usr/bin/python2'
" else " Linux
"   let g:python3_host_prog = '/usr/bin/python3'
"   let g:python_host_prog  = '/usr/bin/python2'
" endif


let mapleader = ','


" LUA for lsp stuff
lua << EOF
-- Autosave
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)

-- Disable swapfile
vim.opt.swapfile = false

-- LSP

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- formatter

-- Provides the Format and FormatWrite commands

local util = require("formatter.util")
require('formatter').setup {
  filetype = {
    -- see defaults: https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
    lua = {
      require('formatter.filetypes.lua').stylua,
    },
    json = {
      require('formatter.filetypes.json').prettier,
    },
    python = {
      require('formatter.filetypes.python').black,
    },
    javascript = {
      require('formatter.filetypes.javascript').prettier,
      require('formatter.filetypes.javascript').eslint,
    },
    sql = {
      function()
        return {
          exe = "sqlfluff fix -f --dialect bigquery -",
          args = { },
          stdin = true,
        }
      end
    }
  }
}
EOF


" PERSISTENT UNDO
" guard for distributions lacking the 'persistent_undo' feature.
if has('persistent_undo')
    " define a path to store persistent undo files.
    let target_path = expand('~/.config/vim-persisted-undo/')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    " point Vim to the defined undo directory.
    let &undodir = target_path
    " finally, enable undo persistence.
    set undofile
endif


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


" ####### SEARCH #######


" Format with formatter.nvim
nnoremap <silent> <leader>f :Format<CR>

" override for sql
autocmd FileType sql nnoremap <silent> <leader>l :!sqlfluff lint --dialect bigquery %<CR>
autocmd FileType sql nnoremap <silent> <leader>f :!sqlfluff fix -f --dialect bigquery %<CR>


" Search file content
nnoremap <C-a> :Ag<CR>

" git blame
nnoremap <Leader>gb :Git blame<CR>  

" Fast saving (less use of pinky finger)
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>x :x<CR>

" Fuzzy search file
nnoremap <C-f> :FZF! <CR>

" Fuzzy search buffers
nnoremap <leader>b :Buffer <CR>

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

"  Copy to clipboard, useful on some OS where clipboard sharing is more difficult
"vnoremap  <leader>y  "+y
"nnoremap  <leader>Y  "+yg_
"nnoremap  <leader>y  "+y
"nnoremap  <leader>yy  "+yy
"
"" Paste from clipboard, useful on some OS where clipboard sharing is more difficult
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

" Colors for vimdiff, messed up on current terminal manager
" highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
