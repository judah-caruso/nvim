call plug#begin()
   Plug 'caenrique/nvim-toggle-terminal'
   Plug 'jansedivy/jai.vim'
   Plug 'jdonaldson/vaxe'
   Plug 'mbbill/undotree'
   Plug 'mg979/vim-visual-multi', {'branch': 'master'}
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   Plug 'nvim-lua/plenary.nvim'
   Plug 'nvim-telescope/telescope.nvim'
   Plug 'preservim/nerdtree'
   Plug 'projekt0n/github-nvim-theme'
   Plug 'tek256/simple-dark'
   Plug 'tpope/vim-commentary'
   Plug 'tpope/vim-fugitive'
call plug#end()

if exists("g:neovide")
   set guifont=SF\ Mono:h14

   let g:neovide_transparency                   = 1
   let g:neovide_refresh_rate                   = 144
   let g:neovide_remember_window_size           = v:true
   let g:neovide_cursor_animation_length        = 0.005
   let g:neovide_cursor_trail_length            = 0
endif

let mapleader=","
let g:VM_leader=","

colorscheme github_dimmed

set autowrite
set clipboard=unnamed
set cmdheight=2
" set completeopt=menuone,noinsert,noselect
set expandtab
set expandtab
set exrc
set hidden
set incsearch
set mouse=niv
set nobackup
set nowritebackup
set noerrorbells
set nohlsearch
set noshowmode
set noswapfile
set nowrap
set scrolloff=8
" set shell=pwsh
" set shellcmdflag=-c
set shiftwidth=3
set shortmess+=c
set signcolumn=yes
set smartindent
set tabstop=3 softtabstop=3
set termguicolors
set updatetime=50

" Edit init.vim
nnoremap <Leader>ev :e $VIMRC<cr>

" Auto-reload init.vim
if !exists("*ReloadInitVim")
   fun! ReloadInitVim()
      let cursor_pos = getcurpos()
      source $VIMRC
      call setpos(".", cursor_pos)
   endfun
endif

autocmd! BufWritePost $VIMRC call ReloadInitVim()

augroup CustomHighlights
   autocmd!
   autocmd WinEnter,VimEnter * :silent! call matchadd('DiffChange', '\(\([@]\)\?\(Todo\|Revise\)\)'           , -1)
   autocmd WinEnter,VimEnter * :silent! call matchadd('DiffAdd'   , '\(\([@]\)\?\(Note\|Optimize\|Fix\)\)'    , -1)
   autocmd WinEnter,VimEnter * :silent! call matchadd('DiffDelete', '\(\([@]\)\?\(Hack\|XXX\|Temp\|Remove\)\)', -1)
augroup END

" Movement binds
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" Trim whitespace
fun! TrimWhitespace()
   let l:save = winsaveview()
   keeppatterns %s/\s\+$//e
   call winrestview(l:save)
endfun

augroup Judah
   autocmd!
   autocmd BufWritePre * :call TrimWhitespace()
augroup END


" --- Plugins

" Commentary
autocmd FileType jai setlocal commentstring=//\ %s

" Nerd Tree
noremap <Leader>t :NERDTreeToggle<cr>

" Coc
nmap <Leader>o :CocOutline<cr>
xmap <Leader>a <Plug>(coc-codeaction-selected)<cr>
nmap <Leader>a <Plug>(coc-codeaction-selected)<cr>
nmap <Leader>cl <Plug>(coc-codelense-action)<cr>

nnoremap <Leader>d :call ShowDocumentation()<cr>
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent><Leader>, <Plug>(coc-diagnostic-prev)
nmap <silent><Leader>. <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function ShowDocumentation()
   if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
   else
      call feedkeys(',d', 'in')
   endif
endfunction

" Terminal
nnoremap <silent> <C-z> :ToggleTerminal<cr>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<cr>

" Telescope
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ") })<CR>

" UndoTree
nnoremap <leader>u :UndotreeToggle<Cr>

" Vaxe
let g:vaxe_default_parent_search_glob="*.hxml"
