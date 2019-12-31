" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
"source $VIMRUNTIME/mswin.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
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
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"-------------------- ���� -----------------------
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set fileencoding=utf-8
set termencoding=utf-8
set encoding=utf-8

"------------- ����˵�����?-----------------------
" �˵�����
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" ��ʾ��Ϣ����
language messages zh_CN.utf-8

"-------------------- ��ǩҳ -----------------------
"��ǩҳ���� ����+����ӱ�ǩҳ����������ֻ��ʾ�ļ���
function Deftablabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    "��ȡ�����Ļ���������������·�����ļ�����
    let full_path = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    "��ȡ�ļ���
    let filename  = fnamemodify(full_path, ':t')
    "�����ǩҳ�������޸ģ���Ϊ��ǩ��ӡ�+��
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor
    "��ȡ��ǩҳ��Ĵ�������
    let wincnt = tabpagewinnr(v:lnum, '$')
    "�����ǩҳ��Ĵ�����������1������label��������ʾ����
    if wincnt > 1
        let label .= wincnt
    endif
    "��һ��
    if label != ''
        let label .= ' '
    endif
    "���� label �� filename ��������ֵ
    return label . filename
"   return label . fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
endfunction
set guitablabel=%{Deftablabel()}

" %n �������ţ� %r ֻ����־λ�� %m �޸ı�־λ�� %t ���������ļ����ļ�����β����
"set guitablabel=%n%r%m%t

"��ǩҳ����
set tabpagemax=50

"-------------------- �Զ���ȫ -----------------------
"ʹ��ӳ��
"inoremap   (   ()<ESC>i
"inoremap   [   []<ESC>i
"inoremap   {   {}<ESC>i
"inoremap   "   ""<ESC>i
"inoremap   '   ''<ESC>i

"���������Զ���ȫ������
func SkipPair()  
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'  
        return "\<ESC>la"  
    else  
        return "\t"  
    endif  
endfunc  
" ��tab����Ϊ��������  
inoremap <TAB> <c-r>=SkipPair()<CR>


"-------------------- ���� -----------------------
"������һ�е�����
"set    autoindent
"���� autoindent�����ǿ���ʶ��һЩ C �﷨�����ں��ʵĵط����� / ��������
"set    smartindent
"C�﷨����
set     cindent

"-------------------- �Ʊ�� -----------------------
"�Ʊ�����
set tabstop=4
"��������
set shiftwidth=4
"���ʹ�ÿո���Ʊ��
set softtabstop=4
"�滻�Ʊ��Ϊ�ո�
set expandtab

"-------------------- �﷨���� -----------------------
"��������㵱ǰ��ɫ������
"syntax enable
"�����﷨������ ��ȱʡֵ�������Լ���
syntax on
"ֻ��֧�ֲ�ɫ���ն�����Ч
if &t_Co > 1
syntax enable
endif

"�ļ����ͼ��
filetype on
"Ϊ�ض����ļ������������ļ������룬Ϊ�ض����ļ��������������ļ�
filetype plugin indent on

"-------------------- ���� -----------------------
"������VI��ʹ��VIM��������
set nocompatible

"-------------------- ��ɫ���� -----------------------
color desert

"-------------------- GUI ���� -----------------------
"����
"set go=
"����GVIM������
"set guioptions-=T
"����GVIM�˵���
"set guioptions-=m
"����GVIM�������
"set guioptions-=l
"����GVIM�ҹ�����
"set guioptions-=r
"����GVIM�������������ֱ�ָ��ʱ
"set guioptions-=L
"����GVIM�ҹ���������ˮƽ�ָ��ʱ
"set guioptions-=R
"��������GVIM��GUIԪ��
"set guioptions-=TmrlRL
"��ʾ����GVIM��GUIԪ��
set guioptions+=TmrlRL

"-------------------- ��ʼ�����趨 -----------------------
"���ó�ʼ����λ��
winpos 300 50 
"���ó�ʼ�����С
set lines=45 columns=150 
"���(��������windowsƽ̨)
"autocmd GUIEnter * simalt ~x

"-------------------- statusline -----------------------
"���ǲ���ʾ״̬��
"set laststatus=0
"�������ڶ���һ��ʱ����ʾ״̬��
"set laststatus=1
"������ʾ״̬��
set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\
set statusline=%2*%n%m%r%h%w%*\ %F\ %1*[FORMAT=%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [TYPE=%2*%Y%1*]\ [COL=%2*%03v%1*]\ [ROW=%2*%03l%1*/%3*%L(%p%%)%1*]
hi User1 guifg=gray
hi User2 guifg=red
hi User3 guifg=white

"-------------------- �Զ����� -----------------------
"�ڴ潻�����Զ����ݣ���ֹͻȻ�ϵ�ȹ���
set swapfile  " set swf
"set noswapfile  " set noswf
set directory=D:/Project/Gvim/_swp//

"�Զ��ļ�����
set backup
"set nobackup
"set backupext=.vibak   "�Զ����׺
set backupdir=D:/Project/Gvim/_backupdir//

"�洢������¼�ļ�
set undofile  " set udf
"set noundofile  " set noudf
set undodir=D:/Project/Gvim/_undodir//

"-------------------- ��ʷ��¼ -----------------------
set history=1000

"-------------------- ��ǰ������ -----------------------
set cursorline
set scrolloff=2

"-------------------- ��ǰ������ -----------------------
"��ʾ����
set number

"-------------------- ���֧�� -----------------------
set mouse=a

"-------------------- ���½���ʾ���λ�õ�״̬�� -------------
set ruler

"-------------------- ��ʾ�ı�����ģʽ -----------------------
set showmode

"-------------------- �������Դ�Сд -----------------------
set ignorecase

"-------------------- �Զ��л�����Ŀ¼ -----------------------
"set autochdir " set acd


"-------------------- ����������Ļ��˸ -----------------------
set visualbell " set vb
"set novisualbell " set novb

"ʹ�����İ����ĵ�
set helplang=cn

"-------------------- ���� ----------------------- 
"windowsƽ̨ 
set guifont=Mouse_YaHeiConsolas:h10:cANSI
"Linuxƽ̨
"set guifont=YaHei\ Consolas\ Hybrid\ 10 "�ո���Ҫת��


"-------------- �����۵� -----------------------
nnoremap zpr :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>:set foldmethod=manual<CR><CR>

"-------------------- alias ----------------------
nnoremap j jzz
nnoremap k kzz
nnoremap n nzz
nnoremap N Nzz
inoremap kj <Esc>


"-------------------- ��Ӱ�Ȩ��Ϣ ----------------------
"�������ļ��Զ���Ӱ�Ȩ��Ϣ
autocmd BufNewFile *.v,*.sv,*.cpp,*.c,*.h exec ":call TitleDet()"

"��ݼ� F4 �ֶ���ӻ���°�Ȩ��Ϣ
map <F4> :call TitleDet()<CR>

"�ж���û�а�Ȩ��Ϣ
function TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~ '^\#\s*\S*Last Modified :\s*\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

"��Ӱ�Ȩ��Ϣ
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

"��������޸�ʱ����ļ���
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


"-------------------- ���ע�� ----------------------
"ӳ��F11��ݼ������ɺ���ת�����У�Ȼ��ʹ��O����vim�Ĳ���ģʽ
map <F11> :call SetComment()<CR>j<CR>O  
func SetComment()
    call append(line(".")  , '//---------------------------------------------------')
    call append(line(".")+1, '//---------------------------------------------------')
endfunc


"------------------- verilog --------------------------
"����ʱ���߼���ܿ飬���� seqlogic + �س�/�ո�
:iab seqlogic always @(posedge clk or negedge rst_n) begin<Enter>if (!rst_n) begin<Enter>end<Enter>else begin<Enter>end<Enter>end<Enter><Up><Up><Up><Up><Up><End>

"��������߼���ܿ飬���� comlogic + �س�/�ո�
iabbr comlogic always @(*) begin<Enter>end<Enter><Up><Up><End>

"��ȫ begin ... end������ begin + �س�/�ո�
iab begin begin<Enter>end<Up><End>

"��ȫ case������ casem + �ո�
iab casem case ()<Enter>default: ;<Enter>endcase<Up><Up><End><Left>

"���� task������ simtf + �س�/�ո�
iabbr simtf <Enter>task simt(input [39:0] simt_multi, input [39:0] simt_delay);<Enter>forever begin<Enter>#(simt_multi * simt_delay);<Enter>$display("--------> simulation time:%d", $time);<Enter>end<Enter>endtask<Enter><Enter><Enter>task simf(input [39:0] simf_multi, input [39:0] simf_finish);<Enter>begin<Enter>#(simf_multi * simf_finish);<Enter>$display("--------> finish     time:%d",$time);<Enter>$finish;<Enter>end<Enter>endtask<Enter><Esc>8k<Home>i//--------------- simf ---------------<Esc>8k<Home>i//--------------- simt ---------------<Esc>16jA

"���� task ģ�壬���� taskm + �ո�
"iab task task ();<Enter>fork<Enter>join<Enter>endtask<Enter><Up><Up><Up><Up><End><left><left><Left>
iab taskm <Enter>task ();<Enter>fork<Enter>begin<Enter>end<Enter>simt(1000, 1000);<Enter>simf(1000, 20_000);<Enter>join<Enter>endtask<Enter><Esc>9k<Home>i//--------------- ---------------<Esc>j<End>3hi

