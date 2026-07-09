" Define mapleader
let mapleader = ' '
let maplocalleader = '\'

" Set some bindings
nnoremap <C-S> <Cmd>w<CR>
inoremap <C-S> <Cmd>w<CR>
nnoremap <C-N> <Cmd>bnext<CR>
nnoremap <C-P> <Cmd>bprev<CR>
nnoremap <C-F>n :tab split<CR>
nnoremap <C-F>t :tabc<CR>
nnoremap <C-Q> <Cmd>Bclose<CR>
nnoremap <C-M> <Cmd>!make > /dev/null &<CR><CR>
nnoremap <C-L> :noh<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
tnoremap <Esc> <C-\><C-n>
inoremap <C-M-n> <Plug>(copilot-next)
inoremap <C-M-p> <Plug>(copilot-prev)

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

filetype plugin indent on

" vim-plug section. 
" Upstream at https://github.com/junegunn/vim-plug
" See the instalation section before using this config.
call plug#begin()
" The default plugin directory will be:
"   - stdpath('data') . '/plugged'

  " Themes
  Plug 'ellisonleao/gruvbox.nvim'

  " Highlighter.
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
  " Sage
  Plug 'petRUShka/vim-sage'

  " Fuzzy finder.
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim'
  " NeoVim Cheatsheet
  Plug 'doctorfree/cheatsheet.nvim'

  " Undotree
  Plug 'mbbill/undotree'
  " Delete a buffer in Vim without closing the window
  Plug 'rbgrouleff/bclose.vim'

  " LaTeX
  Plug 'lervag/vimtex'
  Plug 'sirver/ultisnips'
  Plug 'ckunte/latex-snippets-vim', { 'tag': '*' }
  Plug 'peterbjorgensen/sved'

  " Markdown live preview.
  Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
  " Package plugin commands for repetition
  Plug 'tpope/vim-repeat'
  " Easily delete, change and add surroundings in pairs.
  Plug 'tpope/vim-surround'
  " Comment/uncomment lines.
  Plug 'tpope/vim-commentary'
  " Automatically adjust identation.
  Plug 'tpope/vim-sleuth'

  " Git plugins. TODO: configure keymaps
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  " Plug 'f-person/git-blame.nvim'

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
  " Plug 'github/copilot.vim'

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
colorscheme gruvbox
highlight Normal guibg=none   

" Undotree remap
nnoremap <leader>u :UndotreeToggle<CR>

" Vimtex configurations
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_imaps_leader='!'
nnoremap <localleader>lv :call SVED_Sync()<CR>

let g:vimtex_imaps_disabled = ['jj', 'jJ', 'jh', 'jH', 'jk', 'jK', 'jl', 'jL']
call vimtex#imaps#add_map({'lhs': '!n', 'rhs': '\leftarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!N', 'rhs': '\Leftarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!!', 'rhs': '\leftarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!o', 'rhs': '\rightarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!O', 'rhs': '\Rightarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!õ', 'rhs': '\rightarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!Õ', 'rhs': '\Rightarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!e', 'rhs': '\uparrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!E', 'rhs': '\Uparrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!i', 'rhs': '\downarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!I', 'rhs': '\Downarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '!=', 'rhs': '\Leftrightarrow', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '~', 'rhs': '\approx', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '<', 'rhs': '\le', 'wrapper': 'vimtex#imaps#wrap_math'})
call vimtex#imaps#add_map({'lhs': '>', 'rhs': '\ge', 'wrapper': 'vimtex#imaps#wrap_math'})
" See mappings with :VimtexImapsList

" LaTeX snippets configuration
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

let g:vimtex_indent_delims = {}

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
      -- fzf = {
      --   fuzzy = true,
      --   override_generic_sorter = true,
      --   override_file_sorter = true,
      --   case_mode = "smart_case"
      -- }
    }
  }

  -- require('telescope').load_extension('fzf')

  --------------------------- CHEATSHEET CONFIG -------------------------------

require("cheatsheet").setup({
    -- Whether to show bundled cheatsheets

    -- For generic cheatsheets like default, unicode, nerd-fonts, etc
    bundled_cheatsheets = {
        enabled = { "default" },
        disabled = {},
    },
    -- bundled_cheatsheets = true,

    -- For plugin specific cheatsheets
    -- bundled_plugin_cheatsheets = {
    --     enabled = {},
    --     disabled = {},
    -- }
    bundled_plugin_cheatsheets = true,

    -- For bundled plugin cheatsheets, do not show a sheet if you
    -- don't have the plugin installed (searches runtimepath for
    -- same directory name)
    include_only_installed_plugins = true,

    -- Key mappings bound inside the telescope window
    telescope_mappings = {
        ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
        ['<CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
        ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
        ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
    }
})

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
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = { "latex" },
      disable = function(lang, buf)
       	if lang == 'latex' then
       	  return true
       	end
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
