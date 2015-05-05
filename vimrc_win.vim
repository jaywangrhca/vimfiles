" ============================================================================
" _  _ _ _  _ ____ ____
" |  | | |\/| |__/ |        rstacruz's vimrc.
"  \/  | |  | |  \ |___     Also see plugin/*.vim for the initializers
"
" ============================================================================

set nocompatible
filetype off
"""""""""""""
" Vundle
"""""""""""""
" adjust configuration for such hostile environment as Windows
if has("win32") || has("win16")
    source $VIMRUNTIME/../../../Data/vimfiles/bundle/Vundle.vim/autoload/vundle.vim
    set nocompatible              " be iMproved
    filetype off                  " required!
    set rtp+=$VIMRUNTIME/../../../Data/vimfiles/bundle/Vundle.vim/
    " change bundle install dir
    call vundle#rc("$VIMRUNTIME/../../../Data/vimfiles/bundle/")
else
    source ~/vimfiles/bundle/Vundle.vim/autoload/vundle.vim
    set nocompatible              " be iMproved
    filetype off                  " required!
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    " change bundle install dir
    call vundle#rc("~/vimfiles/bundle/")
endif
let g:mapleader=" "

function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
endfunction

" Vundler: Bundle organizer --------------------------------------------------
  Bundle 'gmarik/Vundle.vim'

  "" :BundleList          - list configured bundles
  "" :BundleInstall(!)    - install(update) bundles
  "" :BundleSearch(!) foo - search(or refresh cache first) for foo
  "" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
  Bundle 'airblade/vim-gitgutter'
  "A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks. 
  Bundle 'kshenoy/vim-signature'
  "Plugin to toggle, display and navigate marks
  Bundle 'elzr/vim-json'
  "better json
  Bundle 'majutsushi/tagbar' 
  "在文档中高效的移动光标
  Bundle 'Lokaltog/vim-easymotion' 
  "显示行末的空格
  Bundle 'vim-scripts/ShowTrailingWhitespace' 
  "自动识别文件编码
  Bundle 'mbbill/fencview' 
  "注释多种语言代码
  Bundle 'mileszs/ack.vim'
  " vim-ruby
  Bundle 'vim-ruby/vim-ruby'
  " vim-rails
  Bundle 'tpope/vim-rails'
  " ri.vim  lets you search and navigate Ruby library and gem documentation
  " inside Vim
  Bundle 'danchoi/ri.vim'
  " emmet-vim for HTML and CSS
  Bundle 'mattn/emmet-vim'
  " navigation and editing key bindings from emacs
  Bundle 'maxbrunsfeld/vim-emacs-bindings'
  " Bundle 'godlygeek/csapprox'
  Bundle 'Yggdroot/indentLine'
  " bash perl support
  Bundle 'WolfgangMehner/vim-plugins'
"  Bundle 'Lokaltog/powerline-fonts'
  Bundle 'Raimondi/delimitMate'

  Bundle 'vim-scripts/bats.vim'
  Bundle 'jjasghar/snipmate-snippets'
  Bundle "narkisr/vim-chef"
" CSApprox: Make gvim-only colorschemes work in terminal vim -----------------
  " Bundle 'godlygeek/csapprox'
  "
  " This is a very slow plugin, so only enable (uncomment) it if you plan on
  " switching color schemes.
  "
  let g:CSApprox_verbose_level=0

" EditorConfig: see editorconfig.org -----------------------------------------
"  Bundle 'editorconfig/editorconfig-vim'

" Indent Object: text object for indentation ---------------------------------
  Bundle 'michaeljsmith/vim-indent-object'

  " vii  -  Delete indentation
  " vai  -  Delete indentation and the line above

" Vim Vitality: cursor changing for tmux/iTerm2 ------------------------------
  Bundle "sjl/vitality.vim"

" Endwise: Wisely add 'end', 'endif', et al ----------------------------------
  Bundle 'tpope/vim-endwise'

" TaskPaper: Taskpaper syntax file -------------------------------------------
  Bundle 'davidoc/taskpaper.vim'

  "" <leader>td - mark as done
  "" <leader>tD - archive done
  "" <leader>tP - focus
  "" <leader>t. - hide notes

  au Filetype taskpaper setl nonumber
  au Filetype taskpaper hi Title ctermfg=4
  au Filetype taskpaper hi taskpaperDoneTag ctermfg=Green ctermbg=none guifg=Green
  au Filetype taskpaper hi taskpaperCancelledTag ctermfg=Red ctermbg=none guifg=Red
  au Filetype taskpaper hi taskpaperUrl ctermfg=Blue ctermbg=none guifg=Blue
  au Filetype taskpaper hi taskpaperUrl ctermfg=Blue ctermbg=none guifg=Blue
  au Filetype taskpaper hi Conceal ctermfg=2 ctermbg=none guifg=Green

  au Filetype taskpaper hi link taskpaperComment       Text

" NERDTree: Project drawer ---------------------------------------------------
  " Bundle 'tpope/vinegar'
  Bundle 'scrooloose/nerdtree'

  "" <leader>nt  - open NERDTree
  "" <leader>nd  - open NERDTree drawer

  let NERDTreeDirArrows=1
  let NERDTreeMouseMode=2
  let NERDTreeMinimalUI=1
  let NERDTreeStatusline=' '
  let NERDTreeWinPos='left'
  let NERDTreeWinSize=50
  let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
  map <leader>nd :NERDTreeToggle<CR>
  map <leader>nt :e .<CR>

" == Non-essential plugins ===================================================
if $VIM_MINIMAL != '1'
" 
"   " to start Vim in minimal mode (which starts faster), just do:
"   "
"   "     VIM_MINIMAL=1 vim
"   "
"   " Useful as an editor for Git, viewing log files, or anything that doesn't
"   " need any heavy text editing.
" 
" Unite: ---------------------------------------------------------------------
  Bundle 'Shougo/vimproc.vim'
  Bundle 'Shougo/unite.vim'
  Bundle 'Shougo/unite-outline'
  Bundle 'Shougo/vimfiler.vim'
  Bundle 'tsukkee/unite-tag'

  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  let g:unite_winheight = 10
  let g:unite_win_split_rule = 'botright'
  let g:unite_prompt = '▸ '

  nnoremap <leader>ua :<C-u>Unite -no-split -start-insert file_rec/async:!<CR>
  nnoremap <leader>uf :<C-u>Unite -no-split file<CR>
  nnoremap <leader>ub :<C-u>Unite -quick-match buffer<CR>
  nnoremap <leader>um :<C-u>Unite -no-split -start-insert mru<CR>
  nnoremap <leader>ut :<C-u>Unite -no-split -start-insert tag<CR>

  nnoremap <leader>ug :<C-u>Unite -no-quit -winheight=10 grep:.<CR>
  nnoremap <leader>uo :<C-u>Unite -no-split -auto-preview -winheight=20 outline<CR>

  nnoremap <leader>uA :<C-u>Unite -start-insert file_rec/async<CR>
  nnoremap <leader>uF :<C-u>Unite -start-insert file buffer<CR>
  nnoremap <leader>uB :<C-u>Unite -start-insert buffer<CR>

  " Use ag for search
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --ignore vendor --ignore public'
    let g:unite_source_grep_recursive_opt = ''
  endif

  " http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html

" ----------------------------------------------------------------------------
  Bundle "tmhedberg/matchit"

" Airline: Lightweight powerline ---------------------------------------------
  Bundle 'bling/vim-airline'

  let g:airline_section_c = '%{strftime("%c")}'
  let g:airline_section_y = 'BN: %{bufnr("%")}'
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = '»'
  let g:airline#extensions#tabline#left_alt_sep = '»'
  let g:airline#extensions#hunks#enabled = 1
  let g:airline_left_sep='>'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif


  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_right_sep = '«'
  let g:airline_symbols.linenr = '¶'
  "let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.whitespace = 'Ξ'

  "" Themes
  "let g:airline_theme='solarized'

" ZenRoom2: iA Writer emulator -----------------------------------------------
  " focus
  Bundle 'junegunn/goyo.vim'
  Bundle 'amix/vim-zenroom2'
  let g:goyo_margin_top=0
  let g:goyo_margin_bottom=0

" Surround: Surround text ----------------------------------------------------
  Bundle 'tpope/vim-surround'

  "" (Visual) S"   - Surround with "
  "" (Visual) gS"  - Surround with " and indent
  "" cs"'          - Change surrounding thing from " to '
  "" cst<a>        - Change surrounding XML tag to <a>
  "" ds"           - Delete surrounding "
  "" dst           - Delete surrounding HTML tag
  "" ysiw]         - Surround with []
  "" csw]          - Surround with []
  "" yss]          - Surround entire line with []
  "" ySiw]         - Surround with [], but indent

" Abolish: Search and substitute multiple variants of a word -----------------
  Bundle 'tpope/vim-abolish'

  " crs - Coerce to snake_case
  " crm - Coerce to MixedCase
  " crc - Coerce to camelCase
  " cru - Coerce to UPPERCASE
  " %S/application/program  (works with Application, APPLICATION, ...)

" Commentary: Commenter ------------------------------------------------------
  Bundle 'tpope/vim-commentary'

  "" \\\            -  Comment line
  "" \\ap           -  Comment paragraph
  "" \\4j           -  Comment 5 lines
  "" / (in visual)  -  Toggle comment

  map \= \\
  vmap / \\

" ZoomWin: Zoom windows ------------------------------------------------------
  Bundle 'vim-scripts/ZoomWin'

  "   <C-W>o  -  Zoom in/out

" SuperTab Continued: insert mode completions with Tab -----------------------
  Bundle 'ervandew/supertab'

  "" (Insert) <Tab>    - Autocomplete

" Tabular: Align stuff -------------------------------------------------------
  Bundle 'godlygeek/tabular'

  " :Tabularize /=/   - Align by the given character

  map ,al :Tabularize /\v^\d*\.?\d*\*?\s/l2<Cr>
  map <F1> :noh<Cr>

" Vim Multiple Cursors: Sublime-style multi cursors --------------------------
  Bundle 'terryma/vim-multiple-cursors'

" Sparkup: HTML helper -------------------------------------------------------
  Bundle 'rstacruz/sparkup', {'rtp': 'vim'}

  "" <C-e>  -  Expand sparkup (HTML only)
  "" <C-n>  -  Move to next

" VimCoffeeScript: Coffee Script compilation ---------------------------------
  "Bundle 'kchmck/vim-coffee-script'

  "" :CoffeeCompile  - compile a snippet or file

  "vmap <leader>cc <esc>:'<,'>:CoffeeCompile<CR>
  "map <leader>cc :CoffeeCompile<CR>


" Signify: show VCS changed in left side --------------------------------------
  Bundle 'mhinz/vim-signify'

  let g:signify_disable_by_default     = 1
  "let g:signify_sign_add               = "⚙"
  "let g:signify_sign_change            = "•"
  "let g:signify_sign_delete            = "❌"
  "let g:signify_sign_delete_first_line = "✂"
  "let g:signify_skip_filetype = { 'taskpaper': 1 }

  " Colors
  au BufNewFile,BufRead * hi SignColumn ctermbg=none
  au BufNewFile,BufRead * hi SignifySignAdd ctermbg=none ctermfg=2
  au BufNewFile,BufRead * hi SignifySignChange ctermbg=none ctermfg=6
  au BufNewFile,BufRead * hi SignifySignDelete ctermbg=none ctermfg=1

  map <leader>st :SignifyToggle<Cr>

" " AutoTag: Auto generate ctags file ------------------------------------------
"   Bundle 'AutoTag'
" 
" Syntastic: Auto check syntax -----------------------------------------------
  Bundle 'scrooloose/syntastic'

  " :Errors - opens error window
  " :SyntasticCheck - forces checking

  let g:syntastic_quiet_messages = {'level': 'warnings'}
  let g:syntastic_check_on_open=1
  let g:syntastic_ruby_exec = "~/.rbenv/versions/1.9.3-p194/bin/ruby"
  let g:syntastic_mode_map = { 'mode': 'active',
                             \ 'active_filetypes': ['php', 'js', 'ruby', 'vim', 'python', 'html', 'coffee'],
                             \ 'passive_filetypes': ['sass', 'scss', 'haml', 'css'] }

  " Syntastic styles
  if has('unix')
    let g:syntastic_error_symbol='⚠'
    let g:syntastic_style_error_symbol='>'
    let g:syntastic_warning_symbol='★'
    let g:syntastic_style_warning_symbol='>'
  endif

" Fugitive: Git client -------------------------------------------------------
  Bundle 'tpope/vim-fugitive'

  "" :Gcd      - cd to project folder
  "" :Gstatus  - git status
  "" :Ggrep    - perform a git grep
  "" :G...

  autocmd QuickFixCmdPost *grep* cwindow  " Open Ggrep in quickfix window
" SnipMate
  Bundle "MarcWeber/vim-addon-mw-utils"
  Bundle "tomtom/tlib_vim"
  Bundle "garbas/vim-snipmate"

" " UltiSnips: Tab snippets ----------------------------------------------------
"   Bundle 'SirVer/ultisnips'
   Bundle 'honza/vim-snippets'
" 
"   "" <Tab>  - Expand snippet
" 
"   let g:UltiSnipsExpandTrigger="<tab>"
"   let g:UltiSnipsJumpForwardTrigger="<tab>"
"   let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
"   let g:UltiSnipsDontReverseSearchPath=0
" 
" Vim Ultisnips CSS: Fast CSS snippets ---------------------------------------
  Bundle 'rstacruz/vim-ultisnips-css'

" CtrlP: File opener ---------------------------------------------------------
  Bundle 'kien/ctrlp.vim'

  " map <C-t> :CtrlPTag<Cr>
  map <C-t> :CtrlPBuffer<Cr>
  map <leader>pb :CtrlPBuffer<Cr>
  map <leader>pt :CtrlPTag<Cr>
  map <leader>pp :CtrlP<Cr>
  " let g:ctrlp_working_path_mode=2

" Syntax bundles -------------------------------------------------------------

  Bundle 'tpope/vim-haml'
  Bundle 'vim-coffee-script'
  Bundle 'tpope/vim-markdown'
  Bundle 'jade.vim'
  Bundle 'cakebaker/scss-syntax.vim'
  Bundle 'vim-scripts/jQuery'
  Bundle 'Textile-for-VIM'
  Bundle 'ledger/vim-ledger'
  Bundle 'hsitz/VimOrganizer'
  Bundle 'git://gist.github.com/369178.git'
  " Less syntax

endif
" ============================================================================

  " For bundles not managed by Vundle, plop them onto extras/.
  "let extra_paths=substitute(glob('~/.vim/extras/*'), '\n', ',', 'g')
  "exec 'set runtimepath+=' . extra_paths

" == Color bundles ===========================================================

  Bundle 'altercation/vim-colors-solarized'
  Bundle 'spf13/vim-colors'
  " Bundle 'vydark'
  " Bundle 'vylight'
  Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim'}
  " Bundle 'noahfrederick/Hemisu'
  " Bundle 'gregsexton/Muon'
  " Bundle 'therubymug/vim-pyte'
  " Bundle 'tpope/vim-vividchalk'
  " Bundle 'molokai'
  " Bundle 'Lucius'
  " Bundle 'chriskempson/base16-vim'

filetype plugin indent on

" https://github.com/terryma/dotfiles/blob/master/.vimrc
"""""""""""""
" tagbar
"""""""""""""
" let g:tagbar_ctags_bin = "/../ctags58/ctags.exe"
autocmd VimEnter * nested :TagbarOpen
"""""""""""""
" indentLine
"""""""""""""
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_color_term = 100
let g:indentLine_color_tty_light = 7
let g:indentLine_color_dark = 1
let g:indentLine_char = '|'
"""""""""""""
" supertab
"""""""""""""
autocmd FileType ruby,eruby let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

"""""""""""""
" ri.vim
"""""""""""""
nnoremap  ,ri :call ri#OpenSearchPrompt(0)<cr> " horizontal split
nnoremap  ,RI :call ri#OpenSearchPrompt(1)<cr> " vertical split
nnoremap  ,RK :call ri#LookupNameUnderCursor()<cr> " keyword lookup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
" filetype on
" filetype plugin on
" filetype indent on
"
" syntax on
" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme seaperl
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,utf8,prc

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

autocmd  BufWrite  *.php :call  DeleteTrailingWS()
autocmd  BufWrite  *.phtml :call  DeleteTrailingWS()
autocmd  BufWrite  *.ctp :call  DeleteTrailingWS()
autocmd  BufWrite  *.js :call  DeleteTrailingWS()
autocmd  BufWrite  *.css :call  DeleteTrailingWS()
autocmd  BufWrite  *.cc :call  DeleteTrailingWS()
autocmd  BufWrite  *.h :call  DeleteTrailingWS()
autocmd  BufWrite  *.tmx :call  DeleteTrailingWS()
autocmd  BufWrite  *.py :call  DeleteTrailingWS()
autocmd  BufWrite  *.pl :call  DeleteTrailingWS()
autocmd  BufWrite  *.rb :call  DeleteTrailingWS()
autocmd  BufWrite  *.twig :call  DeleteTrailingWS()
autocmd  BufWrite  *.sql :call  DeleteTrailingWS()

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

inoremap <M-f> <C-o>e<Right>
"vnoremap <M-f> <C-o>e<Right>
cnoremap <M-f> <C-o>e<Right>
inoremap <M-b> <C-o>b
"vnoremap <M-b> <C-o>b
cnoremap <M-b> <C-o>b

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("mac") || has("macunix")
    set gfn=Menlo:h14
    set shell=/bin/bash
elseif has("win16") || has("win32")
    set gfn=DejaVu\ Sans\ Mono\ for\ Powerline:h11
elseif has("linux")
    set gfn=Monospace\ 10
    set shell=/bin/bash
endif

" Open MacVim in fullscreen mode
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $5 \|\|<esc>i
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i
inoremap $r %%<esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User Defined
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
winpos 0 20
" set lines=54 columns=85
set foldenable
set foldmethod=indent
set foldlevel=10
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set textwidth=78
set complete=.,w
" set ft=todolist
set fileformat=unix
set clipboard=unnamed
set guioptions-=m
set guifont=DejaVu\ Sans\ Mono:h11
language messages utf-8
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"if has("gui_running")
"  " GUI is running or is about to start.
"  " Maximize gvim window (for an alternative on Windows, see simalt below).
"  set lines=999 columns=999
"else
"  " This is console Vim.
"  if exists("+lines")
"    set lines=50
"  endif
"  if exists("+columns")
"    set columns=100
"  endif
"endif

" Buffer Mapping
nnoremap <silent>[b :bprevious<CR>
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[B :bfirst<CR>
nnoremap <silent>]B :blast<CR>
nnoremap <silent>[1 :1b<CR>
nnoremap <silent>>2 :2b<CR>
nnoremap <silent>>3 :3b<CR>
nnoremap <silent>>4 :4b<CR>
nnoremap <silent>>5 :5b<CR>
nnoremap <silent>>6 :6b<CR>
nnoremap <silent>>7 :7b<CR>
nnoremap <silent>>8 :8b<CR>
nnoremap <silent>>9 :9b<CR>
nnoremap <silent>>0 :10b<CR>

