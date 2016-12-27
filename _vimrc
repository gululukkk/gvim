" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Apr 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  syntax on

  " Also switch on highlighting the last used search pattern.
  set hlsearch

  " I like highlighting strings inside C comments.
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

"去除菜单栏和工具栏
set guioptions-=m
set guioptions-=T

" 默认编码 {{{
if has('vim_starting')
    if &encoding !=? 'utf-8'
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,default,cp936
endif
" }}} end

"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"Vundle的路径
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
"插件的安装路径
call vundle#begin('$VIM/vimfiles/bundle/')
Plugin 'gmarik/Vundle.vim'
"nerdtree
Plugin 'scrooloose/nerdtree'
"括号自动补全
Plugin 'jiangmiao/auto-pairs'
"打开上一次编辑的文件
Plugin 'yegappan/mru'
"emmet
Plugin 'mattn/emmet-vim'
"js格式化
Plugin 'maksimr/vim-jsbeautify'
"vim状态栏
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"html5标签自动缩进
Plugin 'othree/html5.vim'
"大神推荐的插件
Plugin 'hail2u/vim-css3-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'gorodinskiy/vim-coloresque'

"vim主题
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'altercation/vim-colors-solarized'
call vundle#end()
filetype plugin indent on

"emmet的设置
let g:user_emmet_leader_key='<F2>'
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall

"airline的设置
set laststatus=2
let g:airline_theme='powerlineish'
"使用powerline打过补丁的字体
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

"设置gvim字体，此语句需要写在airline的设置后面，可能受到airline设置字体语句的影响
set guifont=Fantasque_Sans_Mono:h13
set guifontwide=Consolas:h13

"NERDTree的设置
nnoremap <F1> :NERDTreeToggle<cr>
set autochdir

"auto-pairs的设置
let g:AutoPairsMapSpace=0
"开启飞行模式
let g:AutoPairsFlyMode=0
let g:AutoPairsShortcutBackInsert='<m-b>'

"mru插件的设置
let mapleader=","
map <F6> :MRU<cr>

"vim按键映射
inoremap <m-k> <up>
inoremap <m-j> <down>	
inoremap <m-l> <right>
inoremap <m-h> <left>
"inoremap <cr> <Esc>:w<cr> "插入模式回车键自动保存
inoremap <c-cr> <esc>O
inoremap <s-cr> <esc>o
nnoremap <cr> :w<cr>	"普通模式回车键自动保存
nnoremap <tab> :bn<cr>	"tab键切换buffer
nnoremap <silent><F5> :source $VIM/_vimrc<cr>	"f5刷新配置文件
nnoremap p P 	"交换p的大小写
nnoremap P p 
nnoremap Y y$	"映射Y为复制到行尾
"取消匹配高亮
nnoremap <silent><esc> :noh <cr>
nnoremap <silent><f3> :e $VIMRUNTIME/doc/越难越爱.txt<cr>

"备份文件的设置
set undodir=c:/vimdodir
"智能缩进
set smartindent

"设置vim的备份文件的路径
set backupext=.bak
set backupdir=c:/vimrc_bak
"设置vim缩进和行号
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set number
set relativenumber
set nuw=1
hi LineNr guifg=LightBlue

"设置gvim背景色
hi Normal GUIBG = #FDF6E3

"关闭bd命令保存提示
set hidden

"窗口滚动的设置
set scrolloff=5
"自动重启gvim
autocmd! bufwritepost $VIM/_vimrc source %


"显示排版符号
set list listchars=eol:$,tab:>-,trail:.,nbsp:%
hi NonText guifg=#DF5F00
hi SpecialKey guifg=#00ff00




