" Setting mouse option
set mouse=a

" Setting buffer configuration
set number relativenumber
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray
set nowrap

" TODO change mouse movement delay

" Set split direction
set splitbelow
set splitright

" Set buffer configuration
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Set case policy for search
set ignorecase smartcase

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Preserve undo history
set undofile
set undodir=/tmp//

" Use clipboard for all operations
set clipboard=unnamedplus

" Set spellchecking options
" set spell 
" set spelllang=en

" Set indentation rules
set autoindent
set smartindent

" Always show lines below/above the cursor
set scrolloff=2
set sidescrolloff=5

" Define number formats for <Ctrl>-A and <Ctrl>-X commands
set nrformats=alpha,hex,bin

" Enable command-line completion
set wildmenu

filetype plugin on

" vim-plug section. 
" Upstream at https://github.com/junegunn/vim-plug
call plug#begin()
" The default plugin directory will be:
"   - stdpath('data') . '/plugged'

	" Highlight yanked text.
	Plug 'machakann/vim-highlightedyank'
	highlight HighlightedyankRegion ctermbg=DarkGray

	" Enhanced C++ highlighting.
	Plug 'octol/vim-cpp-enhanced-highlight'

	" Language Server Protocol support.
	Plug 'neovim/nvim-lspconfig'

	" Latex plugin.
	Plug 'lervag/vimtex'
	" function! ZathuraOpenPdf()
	" 	let fullPath = expand("%:p")
	" 	let pdfFile = substitute(fullPath, \".tex\", \".pdf\", \"\")
	" 	execute \"silent !zathura '\" . pdfFile . \"' &\"
	" endfunction

	" Live preview of LaTeX files.
	" Plug 'donRaphaco/neotex'

	" File system explorer.
	Plug 'preservim/nerdtree'
	:command NT NERDTreeToggle

	" Automatic pair of parens, brackets, quotes, etc.
	" Plug 'jiangmiao/auto-pairs'
	
	" Package plugin commands for repetition
	Plug 'tpope/vim-repeat'

	" Easily delete, change and add surroundings in pairs.
	Plug 'tpope/vim-surround'

	" Automatic indenter.
	Plug 'tpope/vim-sleuth'

	" Comment/uncomment lines.
	Plug 'tpope/vim-commentary'

	" Ease usage of some UNIX shell commands.
	Plug 'tpope/vim-eunuch'

	" Git plugin.
	Plug 'tpope/vim-fugitive'

	" More git stuff.
	" Plug 'airblade/vim-gitgutter'
	" Plug 'mhinz/vim-signify'

	" Highlighting other uses of the word under the cursor.
	Plug 'RRethy/vim-illuminate'
	let g:Illuminate_delay = 0
	augroup illuminate_augroup
		autocmd!
		autocmd VimEnter * hi illuminatedWord cterm=bold
	augroup END

	" Add tabline
	Plug 'ap/vim-buftabline'

	" Configure status bar.
	Plug 'itchyny/lightline.vim'

	" Github Copilot.
	Plug 'github/copilot.vim'

" Initialize plugin system
call plug#end()
