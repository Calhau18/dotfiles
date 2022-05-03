set number relativenumber

filetype plugin on

" Adding vim-plug section. 
" Upstream at https://github.com/junegunn/vim-plug
call plug#begin()
" The default plugin directory will be:
"   - stdpath('data') . '/plugged'

	" File system explorer.
	Plug 'preservim/nerdtree'

	" Automatic pair of parens, brackets, quotes, etc.
	Plug 'jiangmiao/auto-pairs'

	" Easily delete, change and add surroundings in pairs.
	Plug 'tpope/vim-surround'

	" Automatic identer.
	Plug 'tpope/vim-sleuth'

	" Git plugin.
	Plug 'tpope/vim-fugitive'

	" Configuer status bar.
	Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()
