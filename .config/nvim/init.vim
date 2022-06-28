" Setting mouse option
set mouse=a

" Setting Ctrl-S to save as in other contexts.
map <C-S> <Cmd>w<CR>

" Setting buffer configuration
set number relativenumber
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray
set nowrap

" Always show lines below/above the cursor
set scrolloff=2
set sidescrolloff=5

" Set indentation rules
set autoindent
set smartindent

" Set buffer configuration
set hidden
set splitbelow splitright
if maparg('<C-N>', 'n') ==# ''
	nnoremap <C-N> :bnext<CR>
endif
if maparg('<C-P>', 'n') ==# ''
	nnoremap <C-P> :bprev<CR>
endif

" Set search configurations.
set ignorecase smartcase
if maparg('<C-L>', 'n') ==# ''
	nnoremap <C-L> :noh<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Preserve undo history
set undofile
set undodir=/tmp//

" Use clipboard for all operations
set clipboard=unnamedplus

" Define number formats for <Ctrl>-A and <Ctrl>-X commands
set nrformats=alpha,hex,bin

" Define mapleader
let mapleader = '\'

" Change command for , and ;
noremap , ;
noremap ; ,

" Enable command-line completion
set wildmenu

filetype plugin on

" vim-plug section. 
" Upstream at https://github.com/junegunn/vim-plug
call plug#begin()
" The default plugin directory will be:
"   - stdpath('data') . '/plugged'
	
	" Highlighter.
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" Highlight yanked text.
	Plug 'machakann/vim-highlightedyank'
	highlight HighlightedyankRegion ctermbg=DarkGray

	" Language Server Protocol support.
	Plug 'neovim/nvim-lspconfig'
	" XXX: Is this working?

	" Enable completion.
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	" XXX: Configure 
	" XXX: Compare with other completion engines

	" Latex plugin.
	Plug 'lervag/vimtex'
	" function! ZathuraOpenPdf()
	" 	let fullPath = expand("%:p")
	" 	let pdfFile = substitute(fullPath, \".tex\", \".pdf\", \"\")
	" 	execute \"silent !zathura '\" . pdfFile . \"' &\"
	" endfunction

	" Live preview of LaTeX files.
	" Plug 'donRaphaco/neotex'

	" Markdown live preview.
	Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}

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

	" Devicons for many plugins
	Plug 'ryanoasis/vim-devicons'
	" Always load this module as the very last one.

" Initialize plugin system
call plug#end()

" TODO change mouse movement delay
"
" Maybe add this later:
" Plug 'rbgrouleff/bclose.vim'
