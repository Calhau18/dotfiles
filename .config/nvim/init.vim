" Define mapleader
let mapleader = ' '

" Set some bindings
nnoremap <C-S> <Cmd>w<CR>
inoremap <C-S> <Cmd>w<CR>
nnoremap <C-N> <Cmd>bnext<CR>
nnoremap <C-P> <Cmd>bprev<CR>
nnoremap <C-Q> <Cmd>Bclose<CR>
nnoremap <C-L> :noh<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
tnoremap <Esc> <C-\><C-n>

" Setting buffer configuration
set number relativenumber
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray
" Always show lines below/above the cursor
set scrolloff=2
set sidescrolloff=5
" Set indentation rules
set autoindent smartindent

" Enable command-line completion
set wildmenu
" Set mouse option
set mouse=a
" Use clipboard for all operations
set clipboard=unnamedplus
" Preserve undo history
set undofile
set undodir=/tmp//

ab vhelp vert help
ab vterm vsplit term://zsh
ab hterm split term://zsh

" Set search configurations.
set ignorecase smartcase

" Define number formats for <Ctrl>-A and <Ctrl>-X commands
set nrformats=alpha,hex,bin

" Change command for , and ;
noremap , ;
noremap ; ,

filetype plugin on

" vim-plug section. 
" Upstream at https://github.com/junegunn/vim-plug
" See the instalation section before using this config.
call plug#begin()
" The default plugin directory will be:
"   - stdpath('data') . '/plugged'

  " Themes
  Plug 'gruvbox-community/gruvbox'

  " Highlighter. TODO: explore treesitter playground plugin.
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Highlight yanked text.
  Plug 'machakann/vim-highlightedyank'
  highlight HighlightedyankRegion ctermbg=DarkGray
  " Highlighting other uses of the word under the cursor.
  Plug 'RRethy/vim-illuminate'
  let g:Illuminate_delay = 0
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=bold
  augroup END

  " Fuzzy finder.
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'}
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

  " NeoVim Cheatsheet
  Plug 'doctorfree/cheatsheet.nvim'
  " Undotree
  Plug 'mbbill/undotree'
  " Delete a buffer in Vim without closing the window
  Plug 'rbgrouleff/bclose.vim'
  " Markdown live preview.
  Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
  " Package plugin commands for repetition
  Plug 'tpope/vim-repeat'
  " Easily delete, change and add surroundings in pairs.
  Plug 'tpope/vim-surround'
  " Comment/uncomment lines.
  Plug 'tpope/vim-commentary'

  " Git plugins. TODO: configure keymaps
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'f-person/git-blame.nvim'

  " LSP Support
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

  " Autocompletion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'saadparwaiz1/cmp_luasnip'

  "  Snippets
  Plug 'L3MON4D3/LuaSnip'
  Plug 'rafamadriz/friendly-snippets'

  " Github Copilot.
  Plug 'github/copilot.vim'

  " Configure status bar.
  Plug 'nvim-lualine/lualine.nvim'
  " Icons for lualine
  Plug 'kyazdani42/nvim-web-devicons'
  " Devicons for many plugins
  Plug 'ryanoasis/vim-devicons'
  " Always load this module as the very last one.

" Initialize plugin system
call plug#end()

" Colorscheme
set termguicolors
colorscheme desert
highlight Normal guibg=none   

" Undotree remap
nnoremap <leader>u :UndotreeToggle<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fsl <cmd>Telescope live_grep<cr>
nnoremap <leader>fsc <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>
nnoremap <leader>fh <cmd>Telescope search_history<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fz <cmd>Telescope spell_suggest<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>

nnoremap <leader>flr <cmd>Telescope lsp_references<cr>
nnoremap <leader>flci <cmd>Telescope lsp_incoming_calls<cr>
nnoremap <leader>flco <cmd>Telescope lsp_outgoing_calls<cr>
nnoremap <leader>fls <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>flw <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fli <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>fld <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>flt <cmd>Telescope lsp_type_definitions<cr>

nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>

nnoremap <leader>fp <cmd>Telescope builtin<cr>
nnoremap <leader>fo <cmd>Telescope vim_options<cr>
nnoremap <leader>f? <cmd>Telescope help_tags<cr>

lua << END
  ---------------------------- TELESCOPE CONFIG -------------------------------

  require('telescope').setup{
    defaults = {
      layout_strategy = "flex",
      layout_config = {
	width = 0.9,
	flex = {
	  horizontal = {
	    preview_width = 0.55
	  }
	}
      },
      mappings = {
	i = {
	  ["<C-h>"] = "which_key"
	}
      }
    },
    pickers = { },
    extensions = {
      -- TODO: sorting criteria (frecency) ?
      -- TODO: octo.nvim ?
      -- TODO: couldn't get media_files to work
      -- TODO: couldn't get env to work
      fzf = {
	fuzzy = true,
	override_generic_sorter = true,
	override_file_sorter = true,
	case_mode = "smart_case"
      }
    }
  }

  require('telescope').load_extension('fzf')

  ----------------------------- LUALINE CONFIG --------------------------------

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'material',
      component_separators = {left = '', right = ''},
      section_separators = {left = '', right = ''},
      disabled_filetypes = {},
      always_divide_middle = false,
      globalstatus = false,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path=1 } },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
      lualine_a = { 'buffers' },
      lualine_b = { 'tabs' },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'fileformat', 'hostname' }
    },
    extensions = {}
  }

  ----------------------------- TREESITTER CONFIG -----------------------------

  require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
	  return true
	end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
    }
  }

  --------------------------------- LSP CONFIG --------------------------------

  local lsp = require('lsp-zero').preset({})

  lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({buffer = bufnr})
  end)

  lsp.setup()

  --------------------------------- CMP CONFIG --------------------------------

  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()

  cmp.setup({
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp'},
      {name = 'buffer', keyword_length = 3},
      {name = 'luasnip', keyword_length = 2},
    }
  })

END
