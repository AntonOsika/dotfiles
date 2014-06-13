set softtabstop=4
set shiftwidth=4
set expandtab

set nu

"antons remaps:"
"end line swedish layout
:nmap ¤  $
"space to single char map
:nmap <Space> i_<Esc>r
" esc
:imap <C-q> <Esc>
" paste in visual mode with p"
vnoremap p "_dP

"Downloaded TAB Hax:
"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
          return "\<C-N>"
	    else
		    return "\<Tab>"
		      endif
		      endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

"emacs in command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

"notes, to have a terminal window: 
" :ConqueTerm bash
"after: installing the vimball by opening it, then so %


"==============================================================================
" closepairs.vim - Auto closes pairs of characters
"==============================================================================
"
" Author:   NoWhereMan (Edoardo Vacchi) <uncommonnonsense at gmail dot com>
" Version:  0.1
" URL: 	    http://www.flatpress.org/ 
" License:  Public Domain
"==============================================================================


inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>

vnoremap <leader>" "zdi"<c-r>z"
vnoremap <leader>' "zdi'<c-r>z'
vnoremap <leader>( "zdi(<c-r>z)
vnoremap <leader>[ "zdi[<c-r>z]
vnoremap <leader>{ "zdi{<c-r>z}

inoremap <expr> <bs> <SID>delpair()

inoremap <expr> ) <SID>escapepair(')')
inoremap <expr> } <SID>escapepair('}')
inoremap <expr> ] <SID>escapepair(']')

inoremap <expr> " <SID>pairquotes('"')
inoremap <expr> ' <SID>pairquotes("'")


function! s:delpair()
	let l:lst = ['""',"''",'{}','[]','()']
	let l:col = col('.')
	let l:line = getline('.')
	let l:chr = l:line[l:col-2 : l:col-1]
	if index(l:lst, l:chr) > -1
		return "\<bs>\<del>"
	else
		let l:chr = l:line[l:col-3:l:col-2]
		if (index(l:lst, l:chr)) > - 1
			return "\<bs>\<bs>"
		endif
		return "\<bs>"
endf

function! s:escapepair(right)
	let l:col = col('.')
	let l:chr = getline('.')[l:col-1]
	if a:right == l:chr 
		return "\<right>"
	else
		return a:right

endf

function! s:pairquotes(pair)
	let l:col = col('.')
	let l:line = getline('.')
	let l:chr = l:line[l:col-1]
	if a:pair == l:chr 
		return "\<right>"
	else
		return a:pair.a:pair."\<left>"

endf
"END OF CLOSEPAIRS"


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

" set our tabs to four spaces
"set ts=4

" turn color syntax highlighting on by default
" set term=builtin_beos-ansi
syntax on

" set auto-indenting on for programming
"set ai

" turn off compatibility with the old vi
set nocompatible

" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb

" do not highlight words when searching for them. it's distracting.
set nohlsearch

" automatically show matching brackets. works like it does in bbedit.
set showmatch

" do NOT put a carriage return at the end of the last line! if you are programming
" for the web the default will cause http headers to be sent. that's bad.
set binary noeol

" make that backspace key work the way it should
set backspace=indent,eol,start

set mousef

" set margin wrapping
"set wrapmargin=1

" for coding
set smartindent

" Disable automatic comments.  These get annoying
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o





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
"let g:colors_name = "BlackSea"

hi Normal guibg=Black guifg=seashell ctermfg=White
hi NonText guifg=LavenderBlush ctermfg=LightMagenta
hi DiffDelete guibg=DarkRed guifg=Black ctermbg=DarkRed ctermfg=White
hi DiffAdd guibg=DarkGreen ctermbg=DarkGreen ctermfg=White
hi DiffChange guibg=Gray30 ctermbg=DarkCyan ctermfg=White
hi DiffText gui=NONE guibg=DarkCyan ctermbg=DarkCyan ctermfg=Yellow
hi Comment guifg=LightBlue
hi Constant guifg=DeepPink
hi PreProc guifg=Magenta ctermfg=Magenta
hi StatusLine guibg=#1f001f guifg=DarkSeaGreen cterm=NONE ctermfg=White ctermbg=DarkGreen
hi StatusLineNC guifg=Gray
hi VertSplit guifg=Gray
hi Type gui=NONE
hi Identifier guifg=Cyan
hi Statement guifg=brown3 ctermfg=DarkRed
hi Search guibg=Gold3 ctermfg=White
