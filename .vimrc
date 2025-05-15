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
    silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'Lokaltog/vim-distinguished'


" Use buffers as GUI tabs
Plug 'jlanzarotta/bufexplorer'

" Beautifier
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Start page for vim
Plug 'mhinz/vim-startify'

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

" Command-T and try to make it work - nice plugin but we are using fzf now!
"  Plug 'wincent/command-t', {
"      \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
"      \ }

" Rich python syntax highlighting
Plug 'kh3phr3n/python-syntax'

" Better commit scren
Plug 'rhysd/committia.vim'

" Autocomplete with ML powers!
" Plug 'zxqfl/tabnine-vim'   Consumes A LOT of memory. Take it out

" Use FZF. fzf runs asynchronously so it might be faster than command-T
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Recover.vim adds a diff option when Vim finds a swap file
Plug 'chrisbra/Recover.vim'

" Change working dir automagically
Plug 'airblade/vim-rooter'

" Generate doxygen documentation
Plug 'vim-scripts/DoxygenToolkit.vim'

" Typescript syntax highlighting
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Try ALE
" Plug 'dense-analysis/ale'

" NEOVIM specific setup
if has('nvim')
    " Colors for neovim
    Plug 'eddyekofo94/gruvbox-flat.nvim'
    " Github Copilot
    Plug 'github/copilot.vim', {'branch': 'release'}
    " Black integration
    let g:python3_host_prog = $WORKON_HOME. '/nvim/bin/python'
    Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}

    " gundo doesn't work with neovim
    Plug 'simnalamburt/vim-mundo'

    " Black does not work in NeoVim... :(
    command! -nargs=0 Black !black %
else
    " Black intregration for better python formatting
    Plug 'psf/black', { 'branch': 'stable' }

    " Undo tree <C-U>
    Plug 'sjl/gundo.vim'
endif

" Initialize plugin system
call plug#end()

if vim_plug_just_installed
    :execute PlugInstall
endif

" => Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tabs_label = 't'

" Disable fancy powerline arrows
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
            \ {'nvrc': '~/.config/nvim/init.vim'},
            \ {'zrc': '~/.zshrc'},
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

if !has('nvim')
    " => Gundo configuration
    if has('python3')
        " If vim is compiled with python3+ we need this
        let g:gundo_prefer_python3 = 1
    endif
    nnoremap <C-U> :GundoToggle<CR>
else
    if has('python3')
        " If vim is compiled with python3+ we need this
        let g:mundo_prefer_python3 = 1
    endif
    " => Mundo configuration
    nnoremap <C-U> :MundoToggle<CR>

    " Enable persistent undo so that undo history persists across vim sessions
    set undofile
    set undodir=~/.vim/undo
endif

"=> Copy things from VI to clipboard
set clipboard^=unnamed,unnamedplus

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
    execute "%!python3 -m json.tool"
    set filetype=json
    set foldmethod=indent
    silent w
endfunction

function! MakeSQLPretty()
    execute "%!sqlformat --reindent --indent_columns --keywords upper --identifiers lower -"
    set filetype=sql
    silent w
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
filetype plugin on

" set number
" turn hybrid line numbers off
set number norelativenumber

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

" When searching, use case if any caps used, else ignore
set ignorecase
set smartcase
" Do not highlight search pattern on match, but allow for easy toggle
set nohlsearch
nnoremap <Leader>/ :set hlsearch!<CR>
" Disable incremental search
set noincsearch

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
" When using neovim, we use Shada files, not viminfo
if !has('nvim')
    set viminfo+=n~/.vim/dirs/viminfo
endif

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

    nnoremap <Leader>a :GAdd <CR>
    nnoremap <Leader>i :GIgnore <CR>
    set cursorline
    map ] ]c
    map [ [c
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none

    " Move things from remote to merged
    nnoremap <Leader>gr :diffget 3<CR>
    nnoremap <Leader>g3 :diffget 3<CR>
    " Move things from local to merged
    nnoremap <Leader>gl :diffget 1<CR>
    nnoremap <Leader>g1 :diffget 1<CR>
    " Move things from current highlighted change to merged
    nnoremap <Leader>dp :diffput 2<CR>
endif

" Mergetool config
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'

" Open git diffs vertically
set diffopt+=vertical

" I actually liked this and I'm used to them. Bring them back :)
command Gblame Git blame
command Gdiff Gvdiffsplit

" Quicker commands
noremap ; :


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
let use_distinguished = 0

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
if use_distinguished
    set background=dark
    let g:distinguished#background = '#202020'
    let g:distinguished = 0 " default: 0
    let g:distinguished#solid_vertsplit = 0 " default: 0
    colorscheme distinguished
    let g:airline_theme='distinguished'
endif

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
" Show incomplete keystrokes in status line
set showcmd

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

au BufNewFile,BufRead python setf python
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" For Scons files, use python highlithting
au BufReadPost SC* set syntax=python

" For json files, use foldmethod with indent
au BufReadPost *.json set foldmethod=indent
au BufWinLeave *.json set foldmethod=manual


au FileType python          set smartindent sw=4 ts=8 et sts=4 et
au FileType c               set smartindent sw=4 ts=4 et sts=4 et
au FileType c++             set smartindent sw=4 ts=4 et sts=4 et
au FileType css             set smartindent sw=2 ts=2 et sts=2 et
au FileType yaml            set smartindent sw=2 ts=2 et sts=2 et
au FileType html            set smartindent sw=2 ts=2 et sts=2 et
au FileType javascript      set smartindent sw=2 ts=2 et sts=2 et
au FileType typescript      set smartindent sw=2 ts=2 et sts=2 et
au FileType typescriptreact set smartindent sw=2 ts=2 et sts=2 et
au FileType javascriptreact set smartindent sw=2 ts=2 et sts=2 et
au FileType xml             set smartindent sw=2 ts=2 et sts=2 et
au FileType rml             set smartindent sw=2 ts=2 et sts=2 et
au FileType sh              set smartindent sw=2 ts=2 et sts=2 et

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

" invoke choosewin plugin
nmap <Leader>w  <Plug>(choosewin)
" I seem to remember there's a reason I didn't want this. But I can't remember it now, so....
nmap <Leader><tab> <Plug>(choosewin)

"Use overlay feature for choosewin
let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 0
let g:choosewin_return_on_single_win = 1

"""""""""""""""""""""""""""""""""
" => Custom commands
"""""""""""""""""""""""""""""""""
" Quickly open a terminal
map <S-t> <ESC>:terminal<cr>

" Highlight the line with a cursor
set cursorline

" Disable cursor line highlighting in Insert mode
augroup aug_cursor_line
  au!
  au InsertEnter * setlocal nocursorline
  au InsertLeave * setlocal cursorline
augroup END

" Toggle cursorline (i.e. line highlight)
nnoremap <Leader>h :set cursorline!<CR>

" Close all buffers but current
nnoremap <Leader>Q :if confirm('Close all other buffers?', "&Yes\n&No", 1)==1 <Bar> %bd <Bar> e# <Bar> bnext <Bar> bd <Bar> endif<CR><CR>

" Additional <ESC> mapping to Ctrl-C, bash style
noremap <C-c> <ESC>
xnoremap <C-c> <ESC>

" Toggle paste/nopaste and show the current state
" set pastetoggle=<F2>

" Extended matching with `%`
runtime macros/matchit.vim

nnoremap <F7> :%s/\s\+$<ENTER>
nnoremap <F8> :g/\s*import pdb;\s*pdb.set_trace()$/d<ENTER>
nnoremap <F9> Oimport pdb; pdb.set_trace()  # noqa fmt: skip<ESC>:w<ENTER>

" save as sudo
ca w!! w !sudo tee "%"

" Para borrar los espacios en blanco al final de las líneas automágicamente
"autocmd BufWritePre *.py :%s/\s\+$//e

" Buffer related stuff
" Show opened buffers and wait for number of buffer to change to
nnoremap <Leader>l :buffers<CR>:buffer<Space>
map <C-Right> :bnext<CR>
map <C-Left> :bprev<CR>
map <C-H> :bprev<CR>
map <C-L> :bnext<CR>
set hidden
" Close current buffer faster
nnoremap <silent> <Leader>bd :bd<CR>

" Maximize/Minimize buffer
nnoremap <Leader>m mm:tabedit %<CR>`m
nnoremap <Leader>tm mm:tabedit %<CR>`m
nnoremap <Leader>tab mm:tabedit %<CR>`m
nnoremap <Leader>q :tabclose<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>td :tabclose<CR>

" Yank entire file
nnoremap <Leader>Y :%y<CR>

" Split/edit buffers by number
command! -nargs=1 Vs :vs <Bar> b<args>
command! -nargs=1 Sp :sp <Bar> b<args>
command! -nargs=1 E :b<args>

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
command! -nargs=0 SQLPretty :execute MakeSQLPretty()

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
let g:netrw_browse_split = 0
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

" Use 'H' and 'L' keys to move to start/end of the line
noremap H ^
noremap L $
" When in insert mode, use jj to do Esc
inoremap jj <ESC>


function! AddGitDirToPath()
    " Change working dir to the current file
    cd %:p:h
    " Set 'gitdir' to be the folder containing .git
    let gitdir=system("git rev-parse --show-toplevel | tr -d '\\n'")
    " See if the command output starts with 'fatal' (if it does, not in a git repo)
    let isgitdir=empty(matchstr(gitdir, '^fatal:.*'))

    " If it empty, there was no error. Let's cd
    if isgitdir
		let &path.=gitdir."/**".",./**"
    endif
endfunction
" autocmd! BufEnter * call AddGitDirToPath()


" Until I fix the `path`, it is excruciatingly slow to use autocomplete scanning tags  on included files.
" Don't do it (i.e. exclude option `i` from the `complete` setting
set complete=.,w,u,kspell,]

" Show the automcomplete menu even when there's only one option and auto select the longest match
set completeopt=menuone,preview

" Disable showing menu info about automcomplete
set shortmess+=c

" Use j,k to scroll trhough autocomplet options.
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Enable mouse for scrolling, split resizing, goto tags and more!
set mouse=a

" Set the window’s title, reflecting the file currently being edited.
set title

" Follow and go back from tags quicker
noremap <Leader>] <C-]>   " forward
noremap <Leader>[ <C-T>   " back

" Configure how fzf should look like
let g:fzf_layout = { 'right': '~20%' }
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_layout = { 'window': { 'width': 0.75, 'height': 0.85, 'highlight': 'Normal' } }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Opne the tagbar browser
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 1
let g:tagbar_indent = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_silent = 1
map tt :TagbarToggle<CR>

" Don't show the warning from Command-T
" let g:CommandTSuppressMaxFilesWarning=1
" let g:CommandTMaxFiles=2000000
" let g:CommandTWildIgnore=&wildignore . ",*/result/*,*/variant-dir/*,*/aristotle/*,*/mason_packages/*,*/externals/*,*/_build/*,*/_install/*"
" let g:CommandTNeverShowDotFiles=1

" Open CommandT to look for open buffers
" nnoremap <Leader>b :CommandTBuffer<CR>
" Open CommandT to look for files in current directory recursively
" nnoremap <Leader>f :CommandTSearch<CR>
" Open CommandT to look for words in current file
" nnoremap <C-f> :CommandTLine<CR>

" Open fzf to look for open buffers
nnoremap <Leader>b :Buffers<CR>
" Open fzf to look for files in current directory recursively
nnoremap <Leader>f :Files<CR>
" Open fzf to look for words in current file
nnoremap <C-f> :BLines<CR>
" Look for tags (ctags) for word under cursor
function! FzfCurrentWord(action)
  let l:word = expand('<cword>')
  if len(l:word) == 0
    if a:action == "tag"
      execute ':Tags'
    elseif a:action == "ag"
      execute ':Ag'
    endif
  else
      let l:list = taglist(l:word)
      if a:action == "tag"
        if len(l:list) == 1
          execute ':tag ' . l:word
        else
          call fzf#vim#tags(l:word, {'options': '--no-preview'})
        endif
      elseif a:action == "ag"
        call fzf#vim#ag(l:word)
      endif
  endif
endfunction
nnoremap <silent><Leader>] :call FzfCurrentWord("tag")<cr>
nnoremap <silent><Leader><S-f> :call FzfCurrentWord("tag")<cr>


" Search selected word using Ag
nnoremap <silent><Leader>ag :call FzfCurrentWord("ag")<cr>


" Make fold ignore blocks of less than 15 lines
set foldminlines=8

" Copy/print breakpoint in current location (pdb/gdb style) (short and full path versions)
command! -nargs=0 PBreak :echo "break ".expand('%').":".line(".")
command! -nargs=0 Break :let @+="break ".expand('%').":".line(".") | echo 'Copied to clipboard: ' . @+
command! -nargs=0 PFBreak :echo "break ".expand('%:p').":".line(".")
command! -nargs=0 FBreak :let @+="break ".expand('%:p').":".line(".") | echo 'Copied to clipboard: ' . @+

" Copy/print file path (short and full path versions)
command! -nargs=0 PFFile :echo expand('%:p')
command! -nargs=0 FFile :let @+=expand('%:p') | echo 'Copied to clipboard: ' . @+
command! -nargs=0 PFile :echo expand('%')
command! -nargs=0 File :let @+=expand('%') | echo 'Copied to clipboard: ' . @+

" (Un)Indent selected test in visual mode
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Mappings to move lines
nnoremap <S-down> :m .+1<CR>==
nnoremap <S-up> :m .-2<CR>==
inoremap <S-down> <Esc>:m .+1<CR>==gi
inoremap <S-up> <Esc>:m .-2<CR>==gi
vnoremap <S-up> :m '<-2<CR>gv=gv
vnoremap <S-down> :m '>+1<CR>gv=gv

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
autocmd FileType python map <buffer> <LocalLeader>p :call Flake8()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Trying AutoPEP8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=120
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
    %s/POLYGON((/Polygon[PointList[{/e
    %s/))/}]]/e
    "%s/),(/}]]\rPolyLine[PointList[{/e
    %s/LINESTRING({\(\d\+\)\(\.\d\+\)\{0,1},\(\d\+\)\(\.\d\+\)\{0,1}},{\(\d\+\)\(\.\d\+\)\{0,1},\(\d\+\)\(\.\d\+\)\{0,1}})/Segment[(\1\2,\3\4), (\5\6,\7\8)]/e
    " Move cursor to original position
    call winrestview(l:save)
    echo "Converted :-)"
endfunction


ca wttr vertical term curl https://wttr.in/Rosario\?lang\=es
ca clima vertical term curl https://wttr.in/Rosario\?lang\=es

""""""""""""""""""""""""""""""""""""""""""
" => Helpful commands for working with CSV
""""""""""""""""""""""""""""""""""""""""""
command! -nargs=0 CSVPretty :%ArrangeColumn
command! -nargs=0 CSVUgly :%UnArrangeColumn



""""""""""""""""""""""""""""""""""""""""""""""
" => Hack for AHS development and Tako. Ignore dir webu
""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_patterns = ['!=website', '!=webui', '.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json']


"""""""""""""""""""""""""""""""""""""""""""""""""
" => Print SQLAlchemy query with expanded params
"""""""""""""""""""""""""""""""""""""""""""""""""
function! DebugQuery()
    " Save cursor position
    let l:save = winsaveview()
    let importStatement = 'from sqlalchemy.dialects import postgresql'
    let queryVariable = expand('<cword>')
    let debugStatement = "print(f\"\\n\\n{" . queryVariable . ".statement.compile(dialect=postgresql.dialect(), compile_kwargs={'literal_binds': True})}\\n\\n\")"

    execute "normal! o" . importStatement . "\<Esc>"
    execute "normal! o" . debugStatement . "\<Esc>"
    call winrestview(l:save)
endfunction


" NEOVIM specific setup
if has('nvim')
    let use_gruvbox_flat = 1
    if use_gruvbox_flat
        let g:solarized_termtrans=1
        let g:solarized_termcolors=256
        " let g:airline_theme='distinguished'
        let g:airline_theme='badwolf'
        set background=dark
        colorscheme gruvbox-flat
    endif
endif

" Ruff commands
let pyproject_toml = expand('python/pyproject.toml')
if filereadable(pyproject_toml)
    command! -nargs=0 Ruff execute '!ruff format --config ' . pyproject_toml . ' % && ruff check --fix --config ' . pyproject_toml . ' % && ruff format --config ' . pyproject_toml . ' %'
    command! -nargs=0 RuffCheck execute '!ruff check --fix --config ' . pyproject_toml . ' %'
    command! -nargs=0 RuffFormat execute '!ruff format --config ' . pyproject_toml . ' %'
else
    command! -nargs=0 Ruff execute '!ruff format % && ruff check --fix % && ruff format %'
    command! -nargs=0 RuffCheck execute '!ruff check --fix %'
    command! -nargs=0 RuffFormat execute '!ruff format %'
endif


" Configure ALE
if executable('ruff')
    let g:ale_linters={
    \ 'python': ['ruff', 'mypy'],
    \}

    if filereadable("python/pyproject.toml")
        let g:ale_python_ruff_format_options = '--config=python/pyproject.toml'
    endif
else
    let g:ale_linters={
    \ 'python': ['pylint', 'mypy'],
    \}
    if filereadable("python/pyproject.toml")
        let g:ale_python_pylint_options = '--rcfile=python/pyproject.toml'
    endif
endif

" Enable ALE linting on save
let g:ale_lint_on_save = 1
" Enable linting as we are typing
" let g:ale_lint_on_text_changed = 'always'


" Enable linting for Python
let g:ale_fixers = {
\   'python': ['black', 'isort'],
\}
let g:ale_python_mypy_options = '--ignore-missing-imports'  " Optional: Ignore imports you don't want mypy to check
" Show linting errors in a more detailed format
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


"" Project specifics config (e.g. remove unnecessary dirs from paths)
command! -nargs=0 Break :let @+="break ".substitute(expand('%'), 'python/', '', 'g').":".line(".") | echo 'Copied to clipboard: ' . @+
function! FromImport()
    let l:filepath = expand('%')
    let l:module = substitute(l:filepath, '.py$', '', 'g')
    let l:module = substitute(l:module, 'python/', '', 'g')
    let l:module = substitute(l:module, 'website/website', 'website', 'g')
    let l:module = substitute(l:module, '/', '.', 'g')
    let l:import_statement = 'from ' . l:module . ' import ' . expand('<cword>')
    let @+ = l:import_statement
    echo 'Copied to clipboard: ' . @+
endfunction
command! -nargs=0 FromImport :call FromImport()
command! -nargs=0 FI :FromImport
