"-------------------- 编码 -----------------------
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set fileencoding=utf-8
set termencoding=utf-8
set encoding=utf-8

"-------------------- 标签页 -----------------------
"标签页窗口 保留+，添加标签页窗口数量，只显示文件名
function Deftablabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    "获取完整的缓冲区名（即完整路径和文件名）
    let full_path = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    "获取文件名
    let filename  = fnamemodify(full_path, ':t')
    "如果标签页的内容修改，则为标签添加“+”
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor
    "获取标签页里的窗口数量
    let wincnt = tabpagewinnr(v:lnum, '$')
    "如果标签页里的窗口数量大于1，则在label变量后显示数字
    if wincnt > 1
        let label .= wincnt
    endif
    "空一格
    if label != ''
        let label .= ' '
    endif
    "返回 label 和 filename 两个变量值
    return label . filename
"   return label . fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
endfunction
set guitablabel=%{Deftablabel()}

" %n 缓冲区号； %r 只读标志位； %m 修改标志位； %t 缓冲区的文件的文件名（尾部）
"set guitablabel=%n%r%m%t

"标签页数量
set tabpagemax=50

"-------------------- 自动补全 -----------------------
"使用映射
inoremap   (   ()<ESC>i
inoremap   [   []<ESC>i
inoremap   {   {}<ESC>i
inoremap   "   ""<ESC>i
"inoremap   '   ''<ESC>i

"设置跳出自动补全的括号
func SkipPair()  
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'  
        return "\<ESC>la"  
    else  
        return "\t"  
    endif  
endfunc  
" 将tab键绑定为跳出括号  
inoremap <TAB> <c-r>=SkipPair()<CR>


"-------------------- 缩进 -----------------------
"沿用上一行的缩进
"set    autoindent
"类似 autoindent，但是可以识别一些 C 语法以能在合适的地方增加 / 减少缩进
"set    smartindent
"C语法缩进
set     cindent

"-------------------- 制表符 -----------------------
"制表符宽度
set tabstop=4
"增加缩进
set shiftwidth=4
"混合使用空格和制表符
set softtabstop=4
"替换制表符为空格
set expandtab

"-------------------- 语法高亮 -----------------------
"激活，保持你当前的色彩设置
"syntax enable
"开启语法高亮， 用缺省值覆盖你自己的
syntax on
"只在支持彩色的终端中生效
if &t_Co > 1
syntax enable
endif

"文件类型检测
filetype on
"为特定的文件类型允许插件文件的载入，为特定的文件类型载入缩进文件
filetype plugin indent on

"-------------------- 兼容 -----------------------
"不兼容VI，使用VIM的新特性
set nocompatible
set backspace=indent,eol,start

"-------------------- 颜色主题 -----------------------
color desert

"-------------------- GUI 设置 -----------------------
"隐藏
"set go=
"隐藏GVIM工具栏
"set guioptions-=T
"隐藏GVIM菜单栏
"set guioptions-=m
"隐藏GVIM左滚动栏
"set guioptions-=l
"隐藏GVIM右滚动栏
"set guioptions-=r
"隐藏GVIM左滚动栏，当垂直分割窗口时
"set guioptions-=L
"隐藏GVIM右滚动栏，当水平分割窗口时
"set guioptions-=R
"隐藏所有GVIM的GUI元素
"set guioptions-=TmrlRL
"显示所有GVIM的GUI元素
set guioptions+=TmrlRL


"-------------------- statusline -----------------------
"总是不显示状态行
"set laststatus=0
"仅当窗口多于一个时，显示状态行
"set laststatus=1
"总是显示状态行
set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\
set statusline=%2*%n%m%r%h%w%*\ %F\ %1*[FORMAT=%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [TYPE=%2*%Y%1*]\ [COL=%2*%03v%1*]\ [ROW=%2*%03l%1*/%3*%L(%p%%)%1*]
hi User1 guifg=gray
hi User2 guifg=red
hi User3 guifg=white

"-------------------- 自动备份 -----------------------
"建立文件夹
if empty(glob("~/.vim/swapfile"))
    silent exec "!mkdir -p ~/.vim/swapfile"
endif
if empty(glob("~/.vim/backup"))
    silent exec "!mkdir -p ~/.vim/backup"
endif
if empty(glob("~/.vim/undofile"))
    silent exec "!mkdir -p ~/.vim/undofile"
endif

"内存交换区自动备份，防止突然断电等故障
set swapfile  " set swf
"set noswapfile  " set noswf
set directory=~/.vim/swapfile//

"自动文件备份
set backup
"set nobackup
"set backupext=.vibak   "自定义后缀
set backupdir=~/.vim/backup//

"存储撤销记录文件
set undofile  " set udf
"set noundofile  " set noudf
set undodir=~/.vim/undofile//

"-------------------- 历史记录 -----------------------
set history=1000

"-------------------- 当前行设置 -----------------------
set cursorline
set scrolloff=2

"-------------------- 当前行设置 -----------------------
"显示行数
set number

"-------------------- 鼠标支持 -----------------------
set mouse=a

"-------------------- 右下角显示光标位置的状态行 -------------
set ruler

"-------------------- 显示文本处理模式 -----------------------
set showmode

"-------------------- 搜索忽略大小写 -----------------------
set ignorecase

"-------------------- 自动切换运行目录 -----------------------
"set autochdir " set acd


"-------------------- 操作有误屏幕闪烁 -----------------------
set visualbell " set vb
"set novisualbell " set novb

"-------------------- 字体 ----------------------- 
"windows平台 
"set guifont=Mouse_YaHeiConsolas:h10:cANSI
"Linux平台
set guifont=YaHei\ Consolas\ Hybrid\ 10 "空格需要转义


"-------------- 搜索折叠 -----------------------
nnoremap zpr :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>:set foldmethod=manual<CR><CR>

"-------------------- alias ----------------------
nnoremap j jzz
nnoremap k kzz
nnoremap n nzz
nnoremap N Nzz
inoremap kj <Esc>


"-------------------- 添加版权信息 ----------------------
"创建新文件自动添加版权信息
autocmd BufNewFile *.v,*.sv,*.cpp,*.c,*.h exec ":call TitleDet()"

"快捷键 F4 手动添加或更新版权信息
map <F4> :call TitleDet()<CR>

"判断有没有版权信息
function TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        "if line =~ '^\#\s*\S*Last Modified :\s*\S*.*$'
        if line =~ '\#\s*\S*Last Modified :\s*\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

"添加版权信息
function AddTitle()
    call append(0,"/*=============================================================================")
    call append(1,"#")
    call append(2,"#          Author : yangl - 283145107@qq.com")
    call append(3,"#       What's Up : Keep on going never give up")
    call append(4,"#     Create Date : ".strftime("%Y-%m-%d %H:%M"))
    call append(5,"#   Last Modified : ".strftime("%Y-%m-%d %H:%M"))
    call append(6,"#        Filename : ".expand("%:t"))
    call append(7,"#     Description : ")
    call append(8,"#")
    call append(9,"=============================================================================*/")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction

"更新最近修改时间和文件名
function UpdateTitle_src()
    normal m'
    execute '/# *Last Modified :/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/# *Filename :/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
endfunction
function UpdateTitle()
    normal mt
    execute '1,10s@Last Modified :.*$@\=strftime("Last Modified : %Y-%m-%d %H:%M")@g'
    execute '1,10s@Filename :.*$@\="Filename : ".expand("%:t")@'
    execute "noh"
    normal `t
    echohl WarningMsg | echo "Successful in updating the copyright." | echohl None
endfunction


"------------------- verilog --------------------------
"生成时序逻辑框架块，输入 seqlogic + 回车/空格
:iab seqlogic always @(posedge clk or negedge rst_n<TAB> begin<Enter>if (!rst_n<TAB> begin<Enter>end<Enter>else begin<Enter>end<Enter>end<Enter><Up><Up><Up><Up><Up><End>

"生成组合逻辑框架块，输入 comlogic + 回车/空格
iabbr comlogic always @(*<TAB> begin<Enter>end<Enter><Up><Up><End>

"补全 begin ... end，输入 begin + 回车/空格
iab begin begin<Enter>end<Up><End>

"补全 case，输入 casem + 空格
iab casem case (<TAB><Enter>default: ;<Enter>endcase<Up><Up><End><Left>

"仿真 task，输入 simtf + 回车/空格
iabbr simtf <Enter>task simt(input [39:0<TAB> simt_multi, input [39:0<TAB> simt_delay<TAB>;<Enter>forever begin<Enter>#(simt_multi * simt_delay<TAB>;<Enter>$display("--------> simulation time:%d<TAB>, $time<TAB>;<Enter>end<Enter>endtask<Enter><Enter><Enter>task simf(input [39:0<TAB> simf_multi, input [39:0<TAB> simf_finish<TAB>;<Enter>begin<Enter>#(simf_multi * simf_finish<TAB>;<Enter>$display("--------> finish     time:%d<TAB>,$time<TAB>;<Enter>$finish;<Enter>end<Enter>endtask<Enter><Esc>8k<Home>i//--------------- simf ---------------<Esc>8k<Home>i//--------------- simt ---------------<Esc>16jA

"仿真 task 模板，输入 taskm + 空格
"iab task task (<TAB>;<Enter>fork<Enter>join<Enter>endtask<Enter><Up><Up><Up><Up><End><left><left><Left>
iab taskm <Enter>task (<TAB>;<Enter>fork<Enter>begin<Enter>end<Enter>simt(1000, 1000<TAB>;<Enter>simf(1000, 20_000<TAB>;<Enter>join<Enter>endtask<Enter><Esc>9k<Home>i//--------------- ---------------<Esc>j<End>3hi

"----------------------------------------------------
"Verilog 例化对齐
command! Alig :execute 's/\s*\(\.\w*\)\s*(\s*\(\w*\)\s*)\s*,/    \1( \2 ) ,/g | s/^\(.*\.\w*\s*\)\zs\ze(/\=repeat(" ",30-strlen(submatch(1)))/g | s/\((\s*\w*\s*\)\zs/\=repeat(" ",30-strlen(submatch(1)))/g'

map <F10> : call CodeAlignment()<CR>j

function CodeAlignment()
    "normal 
    "execute 's/\s*\(\.\w*\)\s*(\s*\(\w*\)\s*)\s*,/    \1( \2 ) ,/g | s/^\(.*\.\w*\s*\)\zs\ze(/\=repeat(" ",30-strlen(submatch(1)))/g | s/\((\s*\w*\s*\)\zs/\=repeat(" ",30-strlen(submatch(1)))/g'
    execute 's/\s*\(\.\w*\)\s*(\s*\(\S*\)\s*)\s*,/    \1( \2 ) ,/g | s/^\(.*\.\S*\s*\)\zs\ze(/\=repeat(" ",30-strlen(submatch(1)))/g | s/\((\s*\S*\s*\)\zs/\=repeat(" ",30-strlen(submatch(1)))/g'
endfunction

"-------------------------- 字体缩放 ----------------------
com! -nargs=0 LargeFont :let &gfn=substitute(&gfn,"\\(\\D*\\)\\(\\d\\+\\)", "\\=submatch(1).(submatch(2)+2)","")
com! -nargs=0 SmallFont :let &gfn=substitute(&gfn,"\\(\\D*\\)\\(\\d\\+\\)", "\\=submatch(1).(submatch(2)-2)","")
