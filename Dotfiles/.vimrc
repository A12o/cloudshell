" HOTKEYS
"""""""""""""""""""""""""""""""""""
" F12 Toggles Mouse between terminal and vim mode
" F9 Saves as root
" F5 Beautifies JSON
" F3 Toggle Search Highlight
" <S-...>          shift-key                        *shift* *<S-*
" <C-...>          control-key                      *control* *ctrl* *<C-*
" <M-...>          alt-key or meta-key              *meta* *alt* *<M-*
" <A-...>          same as <M-...>                  *<A-*
" <D-...>          command-key (Macintosh only)     *<D-*
"""""""""""""""""""""""""""""""""""
"
"""""""""""""""""""""""""""""""""""
"swapfiles the location wim writes the temp .swp files created during editing
set directory=$HOME/.vim/swapfiles//

set hidden   " This option is set for one command with ":hide {command}" |:hide|.
" WARNING: It's easy to forget that you have changes in hidden buffers.
" Think twice when using ":q!" or ":qa!".

" NOTE * if a directory ends in two path separators "//" or "\\", the swap file name will be built from the complete path to the file with all path separators substituted to percent '%' signs. This will ensure file name uniqueness in the preserve directory
"""""""""""""""""""""""""""""""""""
" usage type either #t or shrug# and a space character
" see :h Abbrev    for help
:abbreviate #t # TODO(alasrado):
:ab shrug# #  ¯\_(ツ)_/¯ :
set showcmd
" set relativenumber
let mapleader = " "
"
"####################################################
" Begin Vim-plug
"https://github.com/junegunn/vim-plug"

" Auto install
" See https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Reload .vimrc and :PlugInstall to install plugins.
"Commands
"PlugInstall [name ...] [#threads]	Install plugins
"PlugUpdate [name ...] [#threads]	Install or update plugins
"PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
"PlugUpgrade	Upgrade vim-plug itself
"PlugStatus	Check the status of plugins
"PlugDiff	Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins

" set rtp+=/usr/local/opt/fzf "Fuzzy finder, installed via homebrew
call plug#begin('~/.vim/plugged')

" Themes
Plug 'cocopon/iceberg.vim' "https://github.com/cocopon/iceberg.vim
Plug 'ryanoasis/vim-devicons' "Icons for filetypes
Plug 'vim-airline/vim-airline' "Status bar
Plug 'vim-airline/vim-airline-themes' "Applicable themes

" Language Syntax Support
Plug 'pangloss/vim-javascript' "JS highlighting
Plug 'mxw/vim-jsx' "JSX syntax highlighting
Plug 'jparise/vim-graphql' "graphql syntax highlighting
Plug 'digitaltoad/vim-pug' "Pug highlighting

" Tools
Plug 'prettier/vim-prettier' , { 'do': 'npm install' }
" Plug 'ntpeters/vim-better-whitespace' " https://github.com/ntpeters/vim-better-whitespace
Plug 'a12o/al-vim-better-whitespace' " https://github.com/a12o/al-vim-better-whitespace
Plug 'scrooloose/nerdcommenter' " https://github.com/scrooloose/nerdcommenter
Plug 'wellle/targets.vim' " additional text objects
                          " https://github.com/wellle/targets.vim
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround' " surround.vim: quoting/parenthesizing made simple
                          "https://github.com/tpope/vim-surround
Plug 'tpope/vim-repeat' " enable repeating supported plugin maps
                         " https://github.com/tpope/vim-repeat
Plug 'tpope/vim-fugitive' "Git tools
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} "Nerdtree
Plug 'neoclide/coc.nvim', {'branch': 'release'} "autocompletion

" All of your Plugins must be added before the following line
call plug#end()            " required

filetype plugin indent on    " required

" Nerd Commenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' }, 'vimscript': { 'left': '"' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
" Nerd Commenter

" WhiteSpace strip_whitespace_on_save
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=2
let g:better_whitespace_ctermcolor=48

" Display Newline and track cursor line
set list
" set listchars=eol:¬,space:⋅,nbsp:%,tab:>-,extends:>
" set listchars=eol:↩,space:⋅,nbsp:%,tab:>-,extends:>
set listchars=eol:¬,space:\ ,trail:⋅,nbsp:%,tab:>-,extends:>
" Highlight the cursor line number
set cursorline
" Set Cursor lineOpts in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    set cursorlineopt=number
endif
" Not Iterm
highlight CursorLineNr term=bold,reverse cterm=bold ctermfg=0 ctermbg=208 gui=bold guifg=bg guibg=DarkOrange
" Display Newline and track cursor line

" Theme settings
syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Changes NerdTree Toggle to Ctrl + n
map <C-e> :NERDTreeToggle<CR>
" autocmd VimEnter * NERDTree "Toggles Nerdtree on vim open
let NERDTreeQuitOnOpen = 1 "closes NerdTree when opening a file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set ai            " Auto indent
set si            " Smart indent
set wrap          " Wrap lines

" Code fold bliss
" https://www.linux.com/learn/vim-tips-folding-fun
" set foldmethod=indent

" Blink cursor on error instead of beeping (grr)
set visualbell
set t_vb=

" save with zz
nnoremap zz :update<cr>

" set clipboard to easily copy from vim and paste into OSx
set clipboard=unnamed

" adds blue highlight to vim in visual mode selections
highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
" Not Iterm
"
" cursor style
" Insert mode blinking underscore
let &t_SI .= "\<Esc>[3 q"
" Normal/command mode solid underscore
let &t_EI .= "\<Esc>[1 q"
" 0 -> blinking line
" 1 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore

" Shows the title within the window
set title titlestring=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autosave
" disables autosave feature
let g:prettier#autoformat = 0

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'
"
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0

" runs prettier on file formats
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
autocmd BufWritePre,TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" vim-airline https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
" theme https://github.com/vim-airline/vim-airline-themes
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'

" End Vim-plug
"####################################################

if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
" vmap gx <Plug>NetrwBrowseXVis
" nmap gx <Plug>NetrwBrowseX
" vnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
" nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())
"
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 60
"
let &cpo=s:cpo_save
unlet s:cpo_save
" set background=dark
set backspace=2
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=en
set modelines=0
set ruler
set incsearch
set ignorecase
set smartcase
set laststatus=2
syntax on
set window=0
set number
set wrap
set smarttab
set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab
set cindent
set smartindent
set shiftround

" global var Hilite is for hlsearch
let g:hilite = 1

" Mouse is for Vim
set mouse=a

"" filetype detection
"filetype off
"filetype plugin indent on
"
"" FILETYPE SPECIFIC
""""""""""""""""""""""""""""""""""""
"" treat metatrader as c
"au BufNewFile,BufRead *.mq4 set filetype=c
"" 2 space tabs for ruby
"au BufNewFile,BufRead *.rb set shiftwidth=2
"" json format syntax hilighting
"au BufEnter,BufNewFile,BufRead *.json set filetype=json
"au BufEnter,BufNewFile,BufRead *.json call JsonSyntax()
""""""""""""""""""""""""""""""""""""

" HOTKEYS
"""""""""""""""""""""""""""""""""""
" F12 Toggles Mouse between terminal and vim mode
if !hasmapto('<SID>ToggleMouse()')
    noremap <F12> :call <SID>ToggleMouse()<CR>
    inoremap <F12> <Esc>:call <SID>ToggleMouse()<CR>a
endif

" F9 Saves as root
if !hasmapto('<SID>SudoSave()')
    noremap <F9> :call <SID>SudoSave()<CR>
    inoremap <F9> <Esc>:call <SID>SudoSave()<CR>a
endif

" F5 Beautifies JSON
if !hasmapto('JsonBeautify()')
    noremap <F5> :call JsonBeautify()<CR>
    inoremap <F5> <Esc>:call JsonBeautify()<CR>a
endif

" F3 ToggleHilite
if !hasmapto('ToggleHilite()')
    noremap <F3> :call ToggleHilite()<CR>
    inoremap <F3> <Esc>:call ToggleHilite()<CR>1
endif

" F10 ToggleFileRegister
"if !hasmapto('ToggleFileRegister()')
"    noremap <F10> :call ToggleFileRegister()<CR>
"    inoremap <F10> <Esc>:call ToggleFileRegister()<CR>a
"endif
"""""""""""""""""""""""""""""""""""

" Disable comment guessing
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" Color Scheme
" hi clear
" syntax reset
" syntax enable
" syntax on
" set background=dark
" filetype on
" if has('gui_running')
"     hi Normal       guifg=LightGray   guibg=Black
"     hi NonText      guifg=#505050    guibg=Black
"     hi Comment      guifg=#505050    guibg=Black gui=bold
"     hi Constant     guifg=DarkCyan    guibg=Black
"     hi Identifier   guifg=Cyan        guibg=Black
"     hi Statement    guifg=#5588cc     guibg=Black
"     hi PreProc      guifg=LightGray   guibg=Black gui=bold
"     hi Type         guifg=DarkGreen   guibg=Black
"     hi Special      guifg=#5588cc     guibg=Black
"     hi Underlined   guifg=LightGray   guibg=Black gui=underline
"     hi Error        guifg=Red         guibg=Black gui=bold
"     hi Folded       guifg=DarkGreen   guibg=Black gui=underline
"     hi Scrollbar    guifg=#5588cc     guibg=Black
"     hi Cursor       guifg=Black       guibg=White
"     hi ErrorMsg     guifg=Red         guibg=Black gui=bold
"     hi WarningMsg   guifg=Yellow      guibg=Black
"     hi VertSplit    guifg=White       guibg=Black
"     hi Directory    guifg=Cyan        guibg=DarkBlue
"     hi Visual       guifg=Black       guibg=Cyan gui=underline
"     hi Title        guifg=White       guibg=DarkBlue
"     hi Search       guifg=Black       guibg=Cyan
"     hi MatchParen   guifg=Black       guibg=Cyan
"     hi StatusLine   guifg=White       guibg=Black gui=bold,underline
"     hi StatusLineNC guifg=Gray        guibg=Black gui=bold,underline
"     hi LineNr       guifg=White       guibg=#505050 gui=bold
"     hi Normal       guifg=LightGray   guibg=Black
"     hi NonText      guifg=#505050    guibg=Black
" else
"     hi Normal       ctermfg=LightGray ctermbg=Black
"     hi NonText      ctermfg=DarkGray  ctermbg=Black
"     hi Comment      ctermfg=DarkGray  ctermbg=Black cterm=bold
"     hi Constant     ctermfg=DarkCyan  ctermbg=Black
"     hi Identifier   ctermfg=Cyan      ctermbg=Black
"     hi Statement    ctermfg=Blue      ctermbg=Black
"     hi PreProc      ctermfg=LightGray ctermbg=Black cterm=bold
"     hi Type         ctermfg=DarkGreen ctermbg=Black
"     hi Special      ctermfg=Blue      ctermbg=Black
"     hi Underlined   ctermfg=LightGray ctermbg=Black cterm=underline
"     hi Error        ctermfg=Red       ctermbg=Black cterm=bold
"     hi Folded       ctermfg=DarkGreen ctermbg=Black cterm=underline term=none
"     hi Scrollbar    ctermfg=Blue      ctermbg=Black
"     hi Cursor       ctermfg=Black     ctermbg=White
"     hi ErrorMsg     ctermfg=Red       ctermbg=Black cterm=bold term=bold
"     hi WarningMsg   ctermfg=Yellow    ctermbg=Black
"     hi VertSplit    ctermfg=White     ctermbg=Black
"     hi Directory    ctermfg=Cyan      ctermbg=DarkBlue
"     hi Visual       ctermfg=Black     ctermbg=Cyan cterm=underline term=none
"     hi Title        ctermfg=White     ctermbg=DarkBlue
"     hi Search       ctermfg=Black     ctermbg=Cyan
"     hi MatchParen   ctermfg=Black     ctermbg=Cyan
"     hi StatusLine   ctermfg=White     ctermbg=Black term=bold cterm=bold,underline
"     hi StatusLineNC ctermfg=Gray      ctermbg=Black term=bold cterm=bold,underline
"     hi LineNr       ctermfg=White     ctermbg=DarkGray term=bold cterm=bold
" endif
"
" Protect large files from sourcing and other overhead.
" Files become read only
" if !exists("my_auto_commands_loaded")
"     let my_auto_commands_loaded = 1
" Large files are > 10M
" Set options:
" eventignore+=FileType (no syntax highlighting etc
" assumes FileType always on)
" noswapfile (save copy of file)
" bufhidden=unload (save memory when other file is viewed)
" buftype=nowritefile (is read-only)
" undolevels=-1 (no undo possible)
"     let g:LargeFile = 1024 * 1024 * 10
"     augroup LargeFile
"         autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
"         augroup END
" endif

" Beautify Json, prompting incase of fat finger
" passing 1 as an argument skips the prompt
fun! JsonBeautify(...)
    if a:0 != 1
        let curline = getline('.')
        call inputsave()
        let response = input('Beautify as JSON, Are you Sure? (N/y): ')
        echo ""
    endif
    if a:0==1 || response == "y" || response == 'Y'
        :call JsonSyntax()
        let tmpmem = &l:maxmempattern
        set maxmempattern=2000000
        :silent %s/\({\)\(\%([^"]\|"[^"]*"\)*$\)\@=/{\r/g
        :silent %s/\(\[\)\(\%([^"]\|"[^"]*"\)*$\)\@=/[\r/g
        :silent %s/\(}\)\(\%([^"]\|"[^"]*"\)*$\)\@=/\r}/g
        :silent %s/\(\]\)\(\%([^"]\|"[^"]*"\)*$\)\@=/\r]/g
        :silent %s/\(,\)\(\%([^"]\|"[^"]*"\)*$\)\@=/,\r/g
        :call JsonIndent()
        :let &maxmempattern=tmpmem
    endif
endfunction

fun! JsonSyntax()
    syntax clear
    let main_syntax = 'javascript'
    " Syntax: Strings {{{2
    syn region  jsonString    start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=jsonEscape
    " Syntax: JSON does not allow strings with single quotes, unlike JavaScript.
    syn region  jsonStringSQ  start=+'+  skip=+\\\\\|\\"+  end=+'+
    " Syntax: Escape sequences {{{3
    syn match   jsonEscape    "\\["\\/bfnrt]" contained
    syn match   jsonEscape    "\\u\x\{4}" contained
    " Syntax: Strings should always be enclosed with quotes.
    syn match   jsonNoQuotes  "\<\a\+\>"
    " Syntax: Numbers {{{2
    syn match   jsonNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>"
    " Syntax: An integer part of 0 followed by other digits is not allowed.
    syn match   jsonNumError  "-\=\<0\d\.\d*\>"
    " Syntax: Boolean {{{2
    syn keyword jsonBoolean   true false
    " Syntax: Null {{{2
    syn keyword jsonNull      null
    " Syntax: Braces {{{2
    syn match   jsonBraces     "[{}\[\]]"
    command -nargs=+ HiLink hi def link <args>
    HiLink jsonString             String
    HiLink jsonEscape             Special
    HiLink jsonNumber     Number
    HiLink jsonBraces       Operator
    HiLink jsonNull       Function
    HiLink jsonBoolean      Boolean
    HiLink jsonNumError           Error
    HiLink jsonStringSQ           Error
    HiLink jsonNoQuotes           Error
    delcommand HiLink
    let b:current_syntax = "javascript"
    unlet main_syntax
endfunction

fun! JsonIndent()
    let lines = line('$')
    let counter = 1
    let depth = 0
    let TAB = '    '
    while counter <= lines
        if getline(counter) =~ '\(}\)\(\%([^"]\|"[^"]*"\)*$\)\@=' || getline(counter) =~ '\(]\)\(\%([^"]\|"[^"]*"\)*$\)\@='
            let depth = depth - 1
        endif
        let dcnt = depth
        let buf = ''
        while dcnt > 0
            let buf = buf . TAB
            let dcnt = dcnt - 1
        endwhile
        :exe counter.'s/^/'.buf.'/g'
        if getline(counter) =~ '\({\)\(\%([^"]\|"[^"]*"\)*$\)\@=' || getline(counter) =~ '\(\[\)\(\%([^"]\|"[^"]*"\)*$\)\@='
            let depth = depth + 1
        endif
        let counter = counter + 1
    endwhile
endfunction

" Function to toggle search highlight
function ToggleHilite()
    if !exists("old_hilite")
        let old_hilite = 1
    endif
    if g:hilite == 0
        let g:hilite = old_hilite
        set hlsearch!
    else
        let old_hilite = g:hilite
        let g:hilite = 0
        set hlsearch
    endif
endfunction

" Function to toggle mouse from Vim to Terminal
fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif
    if &mouse == ""
        let &mouse = s:old_mouse
        set number
        set nopaste
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        set number!
        set paste
        echo "Mouse is for Terminal"
    endif
endfunction

" Function to save as root if you don't have permissions
fun! s:SudoSave()
    let curline = getline('.')
    call inputsave()
    let response = input('Saving as Root, Are you Sure? (N/y): ')
    echo ""
    if response == "y" || response == 'Y'
        :silent w !sudo tee % >/dev/null
        :edit!
    endif
endfunction

" let g:file_register=0
" function ToggleFileRegister()
"     if g:file_register == 0
"         echo "Enabled File Register"
"         let g:session_yank_file="~/.vim_yank"
"         vnoremap <silent> y :call Yoink("'<,'>y")<CR>
"         vnoremap <silent> d :call Yoink("'<,'>d")<CR>
"         nnoremap <silent> dd :call Yoink("normal! dd")<CR>
"         nnoremap <silent> yy :call Yoink("normal! yy")<CR>
"         nnoremap <silent> YY :call Yoink("normal! YY")<CR>
"         nnoremap <silent> p :call Plop("p")<CR>
"         nnoremap <silent> P :call Plop("P")<CR>
"         let g:file_register=1
"     else
"         echo "Disabled File Register"
"         vunmap y
"         vunmap d
"         nunmap dd
"         nunmap yy
"         nunmap YY
"         nunmap p
"         nunmap P
"         let g:file_register=0
"     endif
" endfunction
"
" function Yoink(...) range
"     echo a:000
"     return
"     exec a:command
"     new
"     silent call setline(1,getregtype())
"     silent put
"     silent exec 'wq! ' . g:session_yank_file
"     exec 'bdelete ' . g:session_yank_file
" endfunction
"
" function Plop(command)
"     silent exec 'sview ' . g:session_yank_file
"     let l:opt=getline(1)
"     silent 2,$yank
"     if (l:opt == 'v')
"         call setreg('"', strpart(@",0,strlen(@")-1), l:opt)
"     else
"         call setreg('"', @", l:opt)
"     endif
"     exec 'bdelete ' . g:session_yank_file
"     exec 'normal! ' . a:command
" endfunction
"
" silent call ToggleFileRegister()
