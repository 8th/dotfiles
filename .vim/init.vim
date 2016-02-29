set runtimepath+=$XDG_CONFIG_HOME/nvim/,$XDG_CONFIG_HOME/nvim/after

augroup MyAutoCmd
  autocmd!
augroup END

" vim-plug"{{{
if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/vim-plug
endif

call plug#begin('~/.config/nvim/bundle')
Plug 'junegunn/vim-plug',
      \ {'dir': '~/.config/nvim/bundle/vim-plug/autoload'}
Plug 'hachy/eva01.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/unite-outline'
Plug 'thinca/vim-quickrun'
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'glidenote/memolist.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tomtom/tcomment_vim'
Plug 'vim-jp/vimdoc-ja'
call plug#end()
"}}}

filetype plugin indent on

" Basic"{{{
if has("syntax")
  syntax on
endif
set imdisable
set ruler
set cursorline
set title
set number
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set autoindent
set smartindent
" Highlight parenthesis
set showmatch
" Show command on statusline
set showcmd
set cmdheight=2
set cmdwinheight=5
set pumheight=15
set history=200
" Show <TAB> and <CR>
set list
" Show 'invisible' characters
set listchars=tab:»-,trail:-,extends:»,precedes:«
" Allow backspace in insert mode
set backspace=indent,eol,start
" Enable mouse in all modes
set mouse=a
" Do not display greetings message
set shortmess=aTI
" Enable multibyte format.
set formatoptions+=mM
" Increment/Decrement the alphabet by pressing <C-a>/<C-x>
set nrformats=alpha,octal,hex
" Folding
set foldenable
set foldmethod=marker
set foldcolumn=0
autocmd MyAutoCmd FileType vim setlocal foldcolumn=2
" No backups
set nobackup
set noswapfile
" Move the cursor to positions where there isn't any text
set virtualedit=block

set textwidth=0
set scrolloff=5

set splitright
set splitbelow

if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" neosnippet で変なの出さない
set completeopt-=preview

set helpheight=30

set pastetoggle=<F10>
autocmd MyAutoCmd InsertLeave * set nopaste

if has('mac')
  let mapleader = "_"
endif

let java_highlight_all=1
let java_highlight_functions="style"
"}}}

" Color"{{{
set background=dark
colorscheme eva01
"}}}

" Tabline"{{{
set showtabline=2
nmap <C-S-Tab> :tabprevious<CR>
nmap <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprevious<CR>
map <C-Tab> :tabnext<CR>
imap <C-S-Tab> <Esc>:tabprevious<CR>a
imap <C-Tab> <Esc>:tabnext<CR>a
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>
"}}}

" Search"{{{
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

nnoremap <Esc><Esc> :<C-u>set nohlsearch<CR>
nnoremap / :<C-u>set hlsearch<CR>/
nnoremap ? :<C-u>set hlsearch<CR>?
nnoremap * :<C-u>set hlsearch<CR>*
nnoremap # :<C-u>set hlsearch<CR>#

nmap n nzz
nmap N Nzz
nmap * *zz
" # == *
nmap # *zz
nmap g* g*zz
nmap g# g#zz
" count number of matches
nmap ,c :%s///gn<CR>
"}}}

" Statusline"{{{
set laststatus=2
set statusline=%<\%F\ %y%m%r%=%{fugitive#statusline()}\ %{''.(&fenc!=''?&fenc:&enc).''}\%{(&bomb?\",BOM\":\"\")}\ %{&ff}\ %3p%%\ [%4l:%3c]
"}}}

" Keymappings"{{{
nnoremap <C-h> <Home>
vnoremap <C-h> <Home>
nnoremap <C-l> <End>
vnoremap <C-l> <End>

inoremap <silent><expr><C-h> pumvisible() ? "\<C-y>\<Left>" : "\<Left>"
inoremap <silent><expr><C-j> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"
inoremap <silent><expr><C-k> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"
inoremap <silent><expr><C-l> pumvisible() ? "\<C-y>\<Right>" : "\<Right>"

inoremap <C-a> <Home>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap < <><Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" Yank the characters under the cursor until the end of the line
nnoremap Y y$
" Enter == o
noremap <CR> o<Esc>
" C-c == ESC
inoremap <C-c> <Esc>
" F1 == ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" Close help by pressing q.
autocmd MyAutoCmd FileType help nnoremap <buffer> q <C-w>c
" コメントアウトが連続して入力されるのを禁止 :a!でも代用可
autocmd MyAutoCmd FileType * setlocal formatoptions-=ro
" Disable unused keys
nnoremap ZZ <Nop>
" Disable Ex-mode
nnoremap Q <Nop>
nnoremap q <Nop>
" for tmux prefix key
nnoremap <C-z> <Nop>
inoremap <C-z> <Nop>
vnoremap <C-z> <Nop>
" help vertical topleft
nnoremap <Space>h :<C-u>vert to h<Space>
" Visual mode で検索
vnoremap <silent> # "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" preview current html file
nnoremap <Leader>W :silent !xdg-open %:p &<CR>
"}}}

" 全角スペースを強調表示"{{{
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif
"}}}

" Command line"{{{
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

nmap :  <SID>(command-line-enter)
xmap :  <SID>(command-line-enter)

autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> q :<C-u>quit<CR>
  nnoremap <buffer> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

  startinsert!
endfunction
"}}}

" Unite.vim"{{{
let g:unite_data_directory = $HOME.'/.tmp/.unite'
call unite#custom#profile('default', 'context', {
      \ 'winwidth': 35,
      \ 'winheight': 15,
      \ 'direction': 'botright',
      \ })

autocmd MyAutoCmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <silent><buffer> <Esc><Esc> q
  imap <silent><buffer> <Esc><Esc> <Esc>q
endfunction

let g:unite_source_grep_max_candidates = 200

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <silent> ,uf :<C-u>Unite file<CR>
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
nnoremap <silent> ,uo :<C-u>Unite -vertical -no-quit outline<CR>
nnoremap <silent> ,ur :<C-u>Unite history/yank -buffer-name=register register<CR>
nnoremap <silent> ,ug :<C-u>Unite -no-quit grep<CR>
nnoremap <silent> ,cg :<C-u>UniteWithCursorWord -no-quit grep<CR>
"}}}

" deoplete.nvim"{{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return deoplete#mappings#close_popup() . "\<CR>"
endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"}}}

" neosnippet.vim"{{{
imap <C-o> <Plug>(neosnippet_expand_or_jump)
smap <C-o> <Plug>(neosnippet_expand_or_jump)
" Define directory
let g:neosnippet#snippets_directory = $HOME.'/dotfiles/.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {
      \   'c' : 1
      \ }
"}}}

" vimfiler.vim"{{{
let g:vimfiler_data_directory= $HOME.'/.tmp/.vimfiler'
let g:vimfiler_as_default_explorer = 1
call vimfiler#custom#profile('default', 'context', {
      \ 'safe' : 0,
      \ 'edit_action' : 'tabopen',
      \ })

autocmd MyAutoCmd FileType vimfiler nmap <buffer> o <Plug>(vimfiler_sync_with_current_vimfiler)

nnoremap <Space>vf :<C-u>VimFiler -status<CR>
"}}}

" vim-quickrun"{{{
let g:quickrun_config = {}
let g:quickrun_config._ = {
      \ 'split' : '%{winwidth(0) * 2 < winheight(0) * 5 ? "botright 8" : "vertical 80"}',
      \ 'runner' : 'vimproc',
      \ "runner/vimproc/updatetime" : 10
      \ }
let g:quickrun_config.coffee = {'command' : 'coffee', 'exec' : '%c -cbp %s'}
let g:quickrun_config.ruby = {'command' : 'ruby'}
let g:quickrun_config['ruby.rspec'] = {'command': 'rspec', 'exec': 'bundle exec %c %o', 'cmdopt': '-f d --color'}
let g:quickrun_config.slim = {'command' : 'slimrb', 'exec' : '%c -p %s'}
let g:quickrun_config.markdown = {
      \ 'runner' : 'vimproc',
      \ 'outputter' : 'null',
      \ 'command' : 'open',
      \ 'cmdopt' : '-a',
      \ 'args' : '"Premark" --args',
      \ 'exec' : '%c %o %a %s',
      \ }

nmap <silent> <Leader>r <Plug>(quickrun)
"}}}

" fugitive"{{{
nnoremap <Space>gd :<C-u>Gvdiff<Enter>
nnoremap <Space>gs :<C-u>Gstatus<Enter>
nnoremap <Space>gl :<C-u>Glog<Enter>
nnoremap <Space>gb :<C-u>Gblame<Enter>
"}}}

" emmet-vim"{{{
let g:user_emmet_settings = {
      \  'indentation' : '  ',
      \  'lang' : 'ja',
      \  'charset': "utf-8",
      \  'html': {
      \    'snippets': {
      \      'html:5': "<!DOCTYPE html>\n"
      \              ."<html lang=\"${lang}\">\n"
      \              ."<head>\n"
      \              ."    <meta charset=\"${charset}\">\n"
      \              ."    <title></title>\n"
      \              ."    <link rel=\"stylesheet\" href=\"reset.css\">\n"
      \              ."</head>\n"
      \              ."<body>\n${child}|\n"
      \              ."<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js\"></script>\n"
      \              ."</body>\n"
      \              ."</html>",
      \    }
      \  }
      \}
"}}}

" matchit.vim"{{{
source $VIMRUNTIME/macros/matchit.vim
"}}}

" memolist.vim "{{{
let g:memolist_unite = 1
let g:memolist_memo_date = '%Y-%m-%d'
let g:memolist_memo_suffix = 'markdown'
let g:memolist_path = $HOME.'/Dropbox/memo'
let g:memolist_template_dir_path = '~/.vim/template'

map ,mn  :MemoNew<CR>
map ,ml  :MemoList<CR>
map ,mg  :MemoGrep<CR>
"}}}

" syntastic"{{{
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby'],
                           \ 'passive_filetypes': ['javascript']}
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = ['eslint']
"}}}

" vim-gitgutter"{{{
hi GitGutterAdd ctermfg=156 ctermbg=NONE cterm=bold
hi GitGutterChange ctermfg=179 ctermbg=NONE cterm=bold
hi GitGutterDelete ctermfg=168 ctermbg=NONE cterm=bold
"}}}

" au! MyAutoCmd FileType scss syntax cluster sassCssAttributes add=@cssColors
autocmd MyAutoCmd BufNewFile,BufRead *_spec.rb set filetype=ruby.rspec
autocmd MyAutoCmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd MyAutoCmd BufNewFile,BufRead *.{ruby,jbuilder} set filetype=ruby

if $GOROOT != ''
  set rtp+=$GOROOT/misc/vim
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
  " set completeopt=menu,preview
endif

autocmd MyAutoCmd BufNewFile,BufRead *.go set filetype=go
autocmd MyAutoCmd BufWritePre *.go Fmt

let g:markdown_fenced_languages = ['ruby']

" Edit init.vim"{{{
nnoremap <silent> <Space>ev  :<C-u>edit $HOME/dotfiles/.vim/init.vim<CR>
nnoremap <silent> <F5> :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
"}}}

let g:netrw_localcopycmd = ''

" エンコーディングutf-8を優先する"{{{
let &fileencodings=substitute(substitute(&fileencodings, ',\?utf-8', '', 'g'), 'cp932', 'utf-8,cp932', '')
"}}}
