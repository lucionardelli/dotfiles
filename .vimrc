" File: _vimrc
" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)
" ============================================================================
"
" Remap leader key to space
let mapleader = "\<SPACE>"
let maplocalleader = "\<SPACE>"
nnoremap <SPACE> <nop>

"""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Colors
Plug 'KeitaNakamura/neodark.vim'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'


" Use buffers as GUI tabs
Plug 'jlanzarotta/bufexplorer'

" Beautifier
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Start page for vim
Plug 'mhinz/vim-startify'

" Undo tree <C-U>
Plug 'sjl/gundo.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Define operators easily (Recommended for clang)
Plug 'kana/vim-operator-user'

" Format C family code
Plug 'rhysd/vim-clang-format'

" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" C++ Additional syntax Highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Javascript formatting and highlithing
Plug 'pangloss/vim-javascript'
" JSX(React) formatting and highlithing
Plug 'chemzqm/vim-jsx-improve'

" Syntax checking plugin for Vim
" Plug 'vim-syntastic/syntastic'

" Browse the tags of the current file
Plug 'majutsushi/tagbar'

" Plug Command-T and try to make it work
 Plug 'wincent/command-t', {
     \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
     \ }

" Flake8 integration (static syntax and style checker for Python)
Plug 'nvie/vim-flake8'

" Rich python syntax highlighting
Plug 'kh3phr3n/python-syntax'

" Only for simple cases...you MUST write good code yourself
Plug 'tell-k/vim-autopep8'

" Visually select increasingly larger regions of text
Plug 'terryma/vim-expand-region'

" Better commit scren
Plug 'rhysd/committia.vim'

" Autocomplete with ML powers!
Plug 'zxqfl/tabnine-vim'

" Initialize plugin system
call plug#end()

if vim_plug_just_installed
    :execute PlugInstall
endif

" => Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '[%s]'
let airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#fnamemod = ':t' " Just show the file name
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'

" => Startify configuration
let g:startify_session_dir            = '~/.vim/session'
let g:startify_relative_path          = 1
let g:startify_enable_special         = 1
let g:startify_update_oldfiles        = 0
let g:startify_change_to_dir          = 0
let g:startify_change_to_vcs_root     = 1

let g:startify_bookmarks = [
            \ {'vrc': '~/.vimrc'},
            \ {'brc': '~/.bashrc'},
            \ {'git': '~/.gitignore'},
            \ ]
let g:startify_list_order = [
        \ ['    Code Monkey'],
        \ 'sessions',
        \ ['    Where where we?:'],
        \ 'files',
        \ ['    What do we have here?:'],
        \ 'dir',
        \ ['   The usual?:'],
        \ 'bookmarks',
        \ ['   Need a hand?:'],
        \ 'commands',
        \ ]
let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
    \ ]

let g:startify_custom_header =
            \ startify#fortune#cowsay('','═','║','╔','╗','╝','╚')

let test_clang_6 = executable("clang-format-6.0")
let test_clang_7 = executable("clang-format-7")
if test_clang_7
    let g:clang_format#command = "clang-format-7"
elseif test_clang_6
    let g:clang_format#command = "clang-format-6.0"
endif

" => Gundo configuration
if has('python3')
    " If vim is compiled with python3+ we need this
    let g:gundo_prefer_python3 = 1
endif
nnoremap <C-U> :GundoToggle<CR>

"=> Copy things from VI to clipboard
set clipboard=unnamedplus

hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction

" set working directory to git project root
" or directory of current file if not git project
function! SetWdGitDir()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

" Gets the selected word in visual mode
" From https://stackoverflow.com/a/6271254
function! Get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

function! ChangeCurrentWordTo(word)
    execute "%s/\\<" . expand('<cword>') . "\\>/" . a:word . "/gc"
endfunction

" RO files are open with a different color (Needs to be improved, because it changes all the window not only the buffer)
"function CheckRo()
"if &readonly
"highlight Normal ctermfg=grey ctermbg=darkblue
"endif
"endfunction

function! MakeJsonPretty()
    execute "%!python -m json.tool"
    execute "w"
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
filetype plugin on
set number
set encoding=utf-8

" Open new vertical split panes to right, which feels more natural
set splitright
set fillchars+=vert:│

" Change the current working directory when
" opening a file or switch buffers
" NOTE: can be the reason for conflicts with other plugins
" set autochdir

" Set working directory as the git dir, if any,
" else to current file location

nnoremap <Leader>c :call SetWdGitDir()<CR>

" Sets how many lines of history VIM has to remember
set history=900

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
" Ignore compiled and not compatible files
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,*.o,*~
"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=indent,eol,start
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" When seraching, use case if any caps used, else ignore
set ignorecase
set smartcase
" Highlight search pattern on match
nnoremap <Leader>/ :set hlsearch!<CR>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" autocomplete only full matches and list the options
set wildmode=full:longest

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
"set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" => Git fugitive configuration
if &diff
    command! GIgnore :qall
    command! GAdd :Gwrite | w! | qall

    nnoremap <C-a> :GAdd <CR>
    nnoremap <C-i> :GIgnore <CR>
    set cursorline
    map ] ]c
    map [ [c
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
if has('termguicolors')
    set termguicolors
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set t_Co=256   " This is may or may not needed.
let g:rehash256=1
let g:molokai_original = 1

let use_neodark = 1
let use_gruvbox = 0
let use_gruvbox_light = 0

if use_gruvbox
    set background=dark
    let g:gruvbox_italic=1
    let g:gruvbox_termcolors=256
    let g:solarized_termcolors=256
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
endif
if use_gruvbox_light
    set background=light
    let g:gruvbox_italic=1
    let g:gruvbox_termcolors=256
    let g:solarized_termcolors=256
    colorscheme gruvbox
    let g:airline_theme='gruvbox'
endif
if use_neodark
    set background=dark
    let g:neodark#background = '#202020'
    let g:neodark#use_256color = 1 " default: 0
    let g:neodark#terminal_transparent = 0 " default: 0
    let g:neodark#solid_vertsplit = 0 " default: 0
    colorscheme neodark
    let g:airline_theme='dark'
endif

" For Scons files, use python highlithting
au BufReadPost SC* set syntax=python

" For json files, use foldmethod with indent
au BufReadPost *.json set foldmethod=indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set et
" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set sts=4

set autoindent
set smartindent
" set cindent
filetype plugin indent on
" filetype indent on

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
" Remember info about open buffers on close
set viminfo^=%

"""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %F%m%r%h\ %w\ CWD:\ %r%{getcwd()}%h\ \ \ Line:%l\ Col:%c\ [%P]

"set statusline+=%7*\[%n]                                  "buffernr
"set statusline+=%1*\ %<%F\                                "File+path
"set statusline+=%2*\ %y\                                  "FileType
"set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
"set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
"set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
"set statusline+=%8*\ %=\ row:%l/%L\ (%02p%%)\             "Rownumber/total (%)
"set statusline+=%9*\ col:%03c\                            "Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.

" highlight trailing whitespace in red
" have this highlighting not appear whilst typing in insert mode
" have the highlighting of whitespace apply when opening new buffers
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

au FileType python      set smartindent sw=4 ts=4 et sts=4 et
au FileType c           set smartindent sw=4 ts=4 et sts=4 et
au FileType c++         set smartindent sw=4 ts=4 et sts=4 et
au FileType css         set smartindent sw=2 ts=2 et sts=2 et
au FileType yaml        set smartindent sw=2 ts=2 et sts=2 et
au FileType html        set smartindent sw=2 ts=2 et sts=2 et
au FileType javascript  set smartindent sw=2 ts=2 et sts=2 et
au FileType xml         set smartindent sw=2 ts=2 et sts=2 et
au FileType rml         set smartindent sw=2 ts=2 et sts=2 et

" Disable vi compatibility mode
nnoremap Q <nop>

" navigate windows with meta+arrows
map <C-Right> <c-w>l
map <C-Left> <c-w>h
map <C-Up> <c-w>k
map <C-Down> <c-w>j
imap <C-Right> <ESC><c-w>l
imap <C-Left> <ESC><c-w>h
imap <C-Up> <ESC><c-w>k
imap <C-Down> <ESC><c-w>j

"""""""""""""""""""""""""""""""""
" => Custom commands
"""""""""""""""""""""""""""""""""
" Toggle cursorline (i.e. line highlight)
nnoremap <Leader>f :set cursorline!<CR>

" Close all buffers but current
nnoremap <Leader>Q :if confirm('Close all other buffers?', "&Yes\n&No", 1)==1 <Bar> %bd <Bar> e# <Bar> endif<CR><CR>

" Toggle paste/nopaste and show the current state
set pastetoggle=<F2>

" Extended matching with `%`
runtime macros/matchit.vim

nnoremap <F7> :%s/\s\+$<ENTER>
nnoremap <F8> :g/\s*import pdb;\s*pdb.set_trace()$/d<ENTER>
nnoremap <F9> Oimport pdb; pdb.set_trace()  # noqa: E702,E501<ESC>:w<ENTER>

" save as sudo
ca w!! w !sudo tee "%"

" Para borrar los espacios en blanco al final de las líneas automágicamente
"autocmd BufWritePre *.py :%s/\s\+$//e

" Buffer related stuff
" Show opened buffers and wait for number of buffer to change to
nnoremap <Leader>l :buffers<CR>:buffer<Space>
map <C-S-Right> :bnext<CR>
map <C-S-Left> :bprev<CR>
map <C-S-H> :bprev<CR>
map <C-S-L> :bnext<CR>
set hidden

" Maximize/Minimize buffer
nnoremap <S-Up> mm:tabedit %<CR>`m
nnoremap <S-Down> :tabclose<CR>

" Yank entire file
nnoremap <C-S-y> :%y<CR>

" Split/edit buffers by number
command! -nargs=1 Vs :vs <Bar> b<args>
command! -nargs=1 Sp :sp <Bar> b<args>
command! -nargs=1 E :edit <Bar> b<args>

" Grep related
" Grep in WD for the word under the cursor
map <F4> :execute "noautocmd vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
command! GREP :execute 'noautocmd vimgrep /'.expand('<cword>').'/gj '.expand('%') | copen

" Greps in WD for the selection in visual mode
map <F10> <Esc>:execute "noautocmd vimgrep /" . Get_visual_selection() . "/j **" <Bar> cw<CR>

" Change word under cursor with given word. Asks confirmation
command! -nargs=1 Reword :execute ChangeCurrentWordTo('<args>')

" Make my json pretty
command! -nargs=0 Pretty :execute MakeJsonPretty()

"au BufReadPost * call CheckRo()

"""""""""""""""""""""""""""""""""
" => gVim options
"""""""""""""""""""""""""""""""""
"set belloff=all
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

if has("gui_running")
    "set guioptions-=m  "remove menu bar
    "set guioptions-=T  "remove toolbar
    "set guioptions-=r  "remove right-hand scroll bar
    "set guioptions-=L  "remove left-hand scroll bar
    "autocmd GUIEnter * set vb t_vb=
    set guioptions=c
else
    if &term =~ '^screen'
        set term=xterm
        "Esto es para remapear las teclas, pero creo que con lo primero alcanza
        execute "set <xUp>=\e[1;*A"
        execute "set <xDown>=\e[1;*B"
        execute "set <xRight>=\e[1;*C"
        execute "set <xLeft>=\e[1;*D"
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File navigation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_browse_split = 4
let g:netrw_winsize = 15

" Open at the left when entering vim? Only if plays well with startify
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Lexplore
" augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Code navigation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" search first in current directory then file directory for tag file
"set tags=.tags;,tags;,./tags;,./.tags;
" Let fugitive handle it...
set tags^=./.git/tags;

map <C-f> :sp <CR>:exec("tag ".expand("<cword>"))<CR>
map <S-f> :vs <CR>:exec("tag ".expand("<cword>"))<CR>

" Opne the tagbar browser
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
map tt :TagbarToggle<CR>

" Don't show the warning from Command-T
let g:CommandTSuppressMaxFilesWarning=1
let g:CommandTMaxFiles=2000000
let g:CommandTWildIgnore=&wildignore . ",*/result/*,*/variant-dir/*,*/aristotle/*,*/mason_packages/*,*/externals/*,*/_build/*,*/_install/*"
let g:CommandTNeverShowDotFiles=1

map <Leader>b :CommandTBuffer<CR>
"map tf :CommandT<CR> " This is done with <Leader>t
"map ts :CommandTLine<CR>

" Make fold ignore blocks of less than 15 lines
set foldminlines=8

"command! File :echo expand('%:p')
command! PBreak :echo "break ".expand('%:p').":".line(".")
command! PFile :echo expand('%:p')
command! File :let @+=expand('%:p')
command! Break :let @+="break ".expand('%:p').":".line(".")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => iRobot specific
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=/irobot/brewst/**,/irobot/brewst/*,/irobot/brewst/
set path+=/irobot/floorcare-dev/**,/irobot/floorcare-dev/*,/irobot/floorcare-dev/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spellchecking for commit messages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell spelllang=en_us

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Trying Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_error_symbol = "\u2717"
" let g:syntastic_warning_symbol = "\u26A0"
" let g:syntastic_enable_balloons = 0
" let g:syntastic_enable_highlighting = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_mode_map = {"mode": "passive",
"     \ "active_filetypes": [],
"     \ "passive_filetypes": ["c","cpp","python"] }



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Trying Vim-Flake8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:flake8_show_in_file=1
let g:flake8_show_in_gutter=0

" to use colors defined in the colorscheme
highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg

" Automatically call Flake8 on save
" autocmd  BufWritePost *.py :silent call Flake8()
" A la carte call for Flake8
autocmd FileType python map <buffer> <LocalLeader>F :call Flake8()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Trying AutoPEP8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=89
let g:autopep8_aggressive=4


"""""""""""""""""""""""""""""""""""
" => Convert GDB output to Geogebra
"""""""""""""""""""""""""""""""""""
function! ToGeogebra()
    " Save cursor position
    let l:save = winsaveview()
    %s/\s\+$//e
    %s/.*(gdb).*\n//e
    %s/.*Type <return> to continue, or q <return> to quit.*\n//e " in case you forgot to 'set pagination off'
    %s/.*No data fields.*\n//e
    %s/.*GridPoint.*\n//e
    %s/.*length.*\n//e
    %s/.*x = \(\d*\),.*\n.*y = \(\d*\)\n/{\1,\2},/e
    %s/},$/}}]]/e
    %s/^{/PolyLine[PointList[{{/e
    " Move cursor to original position
    call winrestview(l:save)
    echo "Converted :-)"
endfunction

function! WktToGeogebra()
    " Save cursor position
    let l:save = winsaveview()
    %s/),(/))\r\POLYGON((/ge
    %s/\(-\)\{0,1}\(\d\+\)\(\.\d\+\)\{0,1} \(-\)\{0,1}\(\d\+\)\(\.\d\+\)\{0,1}/{\1\2\3,\4\5\6}/ge
    %s/POINT({\(-\)\{0,1}\(\d\+\)\(\.\d\+\)\{0,1},\(-\)\{0,1}\(\d\+\)\(\.\d\+\)\{0,1}})/(\1\2\3,\4\5\6)/ge
    %s/POLYGON((/PolyLine[PointList[{/e
    %s/))/}]]/e
    "%s/),(/}]]\rPolyLine[PointList[{/e
    %s/LINESTRING({\(\d\+\)\(\.\d\+\)\{0,1},\(\d\+\)\(\.\d\+\)\{0,1}},{\(\d\+\)\(\.\d\+\)\{0,1},\(\d\+\)\(\.\d\+\)\{0,1}})/Segment[(\1\2,\3\4), (\5\6,\7\8)]/e
    " Move cursor to original position
    call winrestview(l:save)
    echo "Converted :-)"
endfunction


