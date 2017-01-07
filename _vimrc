"去除vi兼容
set nocompatible
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
"Plugin 'pangloss/vim-javascript'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'ctrlpvim/ctrlp.vim'
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
set guifont=Fantasque_Sans_Mono:h10
set guifontwide=Consolas:h10

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

"开启语法高亮
syntax enable

"vim按键映射
inoremap <m-k> <up>
inoremap <m-j> <down>
inoremap <m-l> <right>
inoremap <m-h> <left>
inoremap <esc> <Esc>:w<cr> "插入模式自动保存
inoremap <c-cr> <esc>O
inoremap <s-cr> <esc>o
inoremap <c-j> <esc>:source d:\desktop\a.vim<cr>
inoremap <m-d> console.log()<left>
nnoremap <c-j> :source d:\desktop\a.vim<cr>
nnoremap <cr> :w<cr>	"普通模式自动保存
nnoremap <tab> :bn<cr>	"tab键切换buffer
nnoremap w /<\\|><cr>:noh<cr>	"跳到下一个标签里面
nnoremap b ?<\\|><cr>:noh<cr>	"跳到下一个标签里面
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
"解决<bs>键无法删除的问题
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
"设置行号
set number
set relativenumber
set nuw=1
hi LineNr guifg=red
hi matchparen guibg=#ad86da
"设置行号高亮
set incsearch
"设置gvim背景色
hi Normal GUIBG = #ffffff

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

autocmd GUIEnter * :MRU
set shortmess=atI

"我的vimscript脚本练习
inoremap <CR> <C-R>=Mylrh()<CR>


function! Mylrh()
    let charr = strpart(getline('.'), col('.')-1, 1)
    let charl = strpart(getline('.'), col('.')-2, 1)
    if (charr == '}' && charl == '{')
        return "\<CR>\<ESC>O"
    endif
    return "\<CR>"
endfunction
