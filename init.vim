call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'Yggdroot/indentLine'
Plug 'dahu/vim-fanfingtastic'
Plug 'preservim/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'preservim/tagbar'
Plug 'digitaltoad/vim-pug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Syntax Highlighting
if has("syntax")
    syntax on
endif

" color scheme
colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_bold=0
set background=dark
" cursor highlight
set cursorline
hi CursorLine term=underline ctermbg=237 guibg=#3c3836
hi Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
" hi CursorLine guibg=White guifg=White

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
 
" searching ignoring case
set ignorecase
set smartcase

" 마지막으로 수정된 곳에 커서를 위치함
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" 상태바 표시를 항상한다
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

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

" indentLine
let g:indentLine_char = '│'
" let g:indentLine_setColors = 0
" let g:indentLine_color_term = 239


" buffer key mapping
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"insert newline without entering insertmode
nmap K i<CR><Esc>

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

" tagbar
nmap <Leader>tg :TagbarToggle<CR>

" syntasitc
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['java'] }

" lightline
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
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
set noshowmode

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
" set langmap=ㅇa,ㅜb,ㅔc,ㅣd,ㅕe,ㅏf,ㅡg,ㄴh,ㅁi,ㅇj,ㄱk,ㅈl,ㅎm,ㅅn,ㅊo,ㅍp,ㅅq,ㅐr,ㄴs,ㅓt,ㄷu,ㅗv,ㄹw,ㄱx,ㄹy,ㅁz

"vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 0 " default 0

" enable true color in nvim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 
" ag is better
" change grep to ack
" set grepprg=ack\ --nogroup\ --column\ $*
" set grepformat=%f:%l:%c:%m

" fzf
map <Leader>fz <ESC>:Files<CR>
map <Leader>ag <ESC>:Ag<CR>

" source vimrc (reload init)
nnoremap <Leader>sv :source $MYVIMRC<CR>

" coc explorer
:nnoremap <Leader>ex :CocCommand explorer<CR>

" quick write
map <Leader>ww :w<CR>
