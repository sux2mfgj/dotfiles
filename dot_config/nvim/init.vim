" my init.vim

"encoding
set encoding=utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set fileformats=unix,mac,dos

set termguicolors

" for inotify
set backupcopy=yes

"backSpace
set backspace=start,eol,indent
set backspace=2

"tab
set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4

" status line
set laststatus=2
set statusline=%F%r%=
" set statusline+=%
" set statusline +=\ % { noscrollbar #statusline() }
set statusline+=\ [%n]
set statusline+=\ (%l,%c)

" match paren
let loaded_matchparen = 1
"hi MatchParen term=standout ctermbg=LightGrey ctermfg=Black guibg=LightGrey guifg=Black

"search
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu

"appearance
set number
set title
set cursorline
set cmdheight=1
set scrolloff=3
"set showmatch
"set matchtime=0
set showcmd
set showmode

"file
set autoread

"other
set autoindent
set cindent
set history=1000
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set noswapfile

"undo
set undodir=~/.vim/undodir
set undofile

" --- backup ---
set backupdir=~/.vim/backup
set backup
let &directory = &backupdir

"auto backup
autocmd BufWritePre,FileWritePre,FileAppendPre * call UpdateBackupFile()
function! UpdateBackupFile()
    let basedir = "$HOME/.vim/backup"
    let dir = strftime(basedir."/%Y%m/%d", localtime())
    if !isdirectory(dir)
        let retval = system("mkdir -p ".dir)
        let retval = system("chown username:groupname ".dir)
    endif
    exe "set backupdir=".dir
    let time = strftime("%H_%M_%S", localtime())
    exe "set backupext=.".time
endfunction

" --- mark ---
nnoremap [Mark] <Nop>
nmap m [Mark]

if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[Mark]m :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

nnoremap [Mark]n ]`
nnoremap [Mark]p [`

" --- set prefix key ---
let g:mapleader=","

nnoremap ZQ <Nop>
nnoremap Q gq
nnoremap <Space>w ZZ

nnoremap ; :
nnoremap : ;

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <S-Left> <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up> <C-w>-<CR>
nnoremap <S-Down> <C-w>+<CR>

nnoremap <Tab> %
vnoremap <Tab> %

" --- Tab ---
nnoremap <Space>n :tabnew<Space>
nnoremap <Space>j gT
nnoremap <Space>k gt
nnoremap gt <Nop>
nnoremap gT <Nop>

nnoremap <Space>tj :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

" --- clipboard ---
"set clipboard+=unnamed
set clipboard=unnamedplus

" --- fold ---
set foldmethod=syntax

" --- tags ---
nnoremap <C-]> g<C-]>
set tags=tags;

" --- for racket (scheme) ---
au BufRead,BufNewFile *.rkt set filetype=scheme


" --- for plugins ---
let s:dein_dir = expand('~/.config/nvim/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('Shougo/denite.nvim')
    "call dein#add('ozelentok/deoplete-gtags')
    "call dein#add('ozelentok/denite-gtags')
    call dein#add('Shougo/neoyank.vim')

	call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('honza/vim-snippets')

    call dein#add('rhysd/vim-clang-format')
	call dein#add('vim-scripts/vim-auto-save')
	call dein#add('itchyny/lightline.vim')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('w0ng/vim-hybrid')
    call dein#add('majutsushi/tagbar')
    call dein#add('tyru/caw.vim')
    call dein#add('bronson/vim-trailing-whitespace')
    ":FixWhitespace remote white space
    call dein#add('cohama/lexima.vim')
    call dein#add('thinca/vim-quickrun')

    "" for each langrages
    call dein#add('ekalinin/Dockerfile.vim')
    call dein#add('vim-jp/cpp-vim')
    call dein#add('neovimhaskell/haskell-vim')
    call dein#add('eagletmt/ghcmod-vim')

    call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" snippets
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" deoplete
call deoplete#enable()

" --- lightline ---
"let g:lightline = {
"      \ 'colorscheme': 'wombat'
"      \ }

" --- indent guide ----
"set ts=4 sw=4 et
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey

" --- auto save ---
let g:auto_save = 1

" --- clang-format ---
let g:clang_format#command="clang-format"
let g:clang_format#code_style="chromium"
let g:clang_format#style_options = {
    \ "BreakBeforeBraces" : "Stroustrup",
    \ "AlwaysBreakTemplateDeclarations" : "true",
    \ "AccessModifierOffset" : -4,
    \ "Standard" : "C++11",
    \ "IndentWidth" : 4
    \}

" --- denite ---
if dein#tap('denite.nvim')
    nnoremap [Denite] <Nop>
    nmap f [Denite]
	nnoremap <silent> [Denite]b  :<C-U>Denite buffer<CR>
    nnoremap <silent> [Denite]l  :<C-U>Denite line<CR>
    nnoremap <silent> [Denite]o  :<C-U>Denite outline<CR>
    nnoremap <silent> [Denite]gg :<C-U>Denite grep<CR>
    nnoremap <silent> [Denite]d  :<C-U>Denite -default-action=tab_open directory_mru<CR>
    nnoremap <silent> [Denite]y  :<C-U>Denite neoyank<CR>

    call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
    call denite#custom#map('normal', '<C-j>', '<denite:move_to_next_line>', 'noremap')
    call denite#custom#map('normal', '<C-k>', '<denite:move_to_previous_line>', 'noremap')


endif

" --- tagbar ---
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus   = 1
let g:tagbar_sort        = 0
let g:tagbar_compact     = 1
nnoremap <silent> <Leader>tb :<C-U>TagbarToggle<CR>

" --- caw ---
" 行の最初
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" 行頭
nmap <Leader>, <Plug>(caw:zeropos:toggle)
vmap <Leader>, <Plug>(caw:zeropos:toggle)

" --- neovimhaskell/haskell-vim ---
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2

" --- vim-hybrid ---
set background=dark
colorscheme hybrid
syntax on
