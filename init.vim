call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Raimondi/delimitMate'
Plug 'preservim/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'blueyed/vim-diminactive'
Plug 'tpope/vim-fugitive'
Plug 'dahu/vim-fanfingtastic'
Plug 'preservim/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'hail2u/vim-css3-syntax'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'

call plug#end()


" Syntax Highlighting
if has("syntax")
    syntax on
endif

" vim code dark
colorscheme codedark
set background=dark

" spaces, tabs, indent
set smartindent
set tabstop=2
set expandtab
set softtabstop=2
set autoindent
set shiftwidth=2

" fo" line number
set nu
set relativenumber
 
" cursor highlight
set cursorline

" searching ignoring case
set ignorecase
set smartcase

" 마지막으로 수정된 곳에 커서를 위치함
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" NERDTree ON 단축키를 "\nt"로 설정
map <Leader>nt <ESC>:NERDTreeToggle<CR>
" NT로 파일 열고 NT 자동 닫기
let NERDTreeQuitOnOpen=1
" 숨김 파일 표시
let NERDTreeShowHidden=1

" 상태바 표시를 항상한다
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" for vim-airline
" let g:airline#extensions#tabline#enabled = 1 " turn on buffer list
" set laststatus=1 " turn on bottom bar

" for emmet.vim, tutorial https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL
let g:user_emmet_leader_key='<C-e>'

" like zsh, Ex command autocomplete
set wildmenu 
set wildmode=full
set wildignorecase

" search option
set hlsearch
set incsearch
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = 'V' . substitute(escape(@s, a:cmdtype.''), '\n', '\\n', 'g')
  let @s = temp
endfunction

" cmd line mode history
set history=200

" indent guide 
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_guide_size=1

" buffer key mapping
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"insert newline without entering insertmode
nmap <CR> i<CR><Esc>

" ycm, not pop up preview
set completeopt-=preview

" apply vim-jsx to .js file
let g:jsx_ext_required = 0

" turn off hls result
nnoremap <Esc><Esc> :silent! nohls<CR>

" for matchit plugin
set nocompatible
filetype plugin on
runtime macros/matchit.vim

" substitute
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" fanfingtastic
let g:fanfingtastic_ignorecase = 1

" nerd commenter" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" gutentags
set statusline+=%{gutentags#statusline()}

" syntasitc
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" lightline
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" run js directly through nvim > :RunJS %
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

command! -complete=file -nargs=* RunJS call s:RunShellCommand('node '.<q-args>)

" coc c-space
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" using multiple argdo, bufdo
set hidden

" %:h to %%
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" 한글일 때도 단축키 가능하도록
set langmap=ㅇa,ㅜb,ㅔc,ㅣd,ㅕe,ㅏf,ㅡg,ㄴh,ㅁi,ㅇj,ㄱk,ㅈl,ㅎm,ㅅn,ㅊo,ㅍp,ㅅq,ㅐr,ㄴs,ㅓt,ㄷu,ㅗv,ㄹw,ㄱx,ㄹy,ㅁz

"vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 0 " default 0

