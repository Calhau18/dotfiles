" =============================================================================
" Neovim configuration
"
" Layout of this file:
"   1. Leader keys
"   2. General keybindings
"   3. Editor options
"   4. Plugins (vim-plug)
"   5. Colorscheme and highlights
"   6. Plugin settings written in Vimscript (Undotree, Vimtex, UltiSnips,
"      vim-surround, Telescope keymaps)
"   7. Plugin settings written in Lua (Telescope, Cheatsheet, Lualine,
"      Treesitter, Zotcite, LSP, completion)
"
" Notation used in comments: <leader> is Space, <localleader> is \.
" =============================================================================


" -----------------------------------------------------------------------------
" 1. Leader keys
" -----------------------------------------------------------------------------
" <leader> starts general custom mappings (Space ff, Space u, ...).
" <localleader> starts filetype-specific mappings (Vimtex uses \l...).
" These must be set before any mapping that uses them.
let mapleader = ' '
let maplocalleader = '\'


" -----------------------------------------------------------------------------
" 2. General keybindings
" -----------------------------------------------------------------------------
" Ctrl-S saves the file, in normal and insert mode.
nnoremap <C-S> <Cmd>w<CR>
inoremap <C-S> <Cmd>w<CR>
" Ctrl-N / Ctrl-P go to the next / previous buffer.
nnoremap <C-N> <Cmd>bnext<CR>
nnoremap <C-P> <Cmd>bprev<CR>
" Ctrl-F n opens the current buffer in a new tab; Ctrl-F t closes the tab.
nnoremap <C-F>n :tab split<CR>
nnoremap <C-F>t :tabc<CR>
" Ctrl-Q closes the buffer but keeps the window open (bclose.vim).
nnoremap <C-Q> <Cmd>Bclose<CR>
" Esc leaves insert mode in a terminal buffer (the default is Ctrl-\ Ctrl-N).
tnoremap <Esc> <C-\><C-n>
" Copilot, in insert mode:
"   Ctrl-Alt-Y              accept the suggestion
"   Ctrl-Alt-N / Ctrl-Alt-P cycle through suggestions
" Copilot's default <Tab> accept is turned off so <Tab> stays with UltiSnips.
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-M-y> copilot#Accept("")
imap <C-M-n> <Plug>(copilot-next)
imap <C-M-p> <Plug>(copilot-prev)

" Git:
"   <leader>gs  Git status window (fugitive; press g? inside it for help)
"   <leader>gb  blame for the current file
"   <leader>gd  diff the file against the staged version
" gitgutter also provides, by default:
"   ]c / [c     next / previous changed hunk
"   <leader>hp  preview the hunk   <leader>hs stage it   <leader>hu undo it
nnoremap <leader>gs <Cmd>Git<CR>
nnoremap <leader>gb <Cmd>Git blame<CR>
nnoremap <leader>gd <Cmd>Gdiffsplit<CR>


" -----------------------------------------------------------------------------
" 3. Editor options
" -----------------------------------------------------------------------------
" Show the current line number, with relative numbers on the other lines
" (handy for jumps like 5j).
set number relativenumber
" Draw a vertical guide at column 80.
set colorcolumn=80
" Always keep 2 lines above/below and 5 columns left/right of the cursor
" visible when scrolling.
set scrolloff=2
set sidescrolloff=5
" Add extra indent after things like { in C-like code. (New lines already
" keep the previous line's indent: autoindent is on by default in Neovim.)
set smartindent

" Enable the mouse in all modes.
set mouse=a
" Yank, delete and paste use the system clipboard.
set clipboard=unnamedplus
" Save undo history to disk so undo still works after reopening a file.
set undofile

" Command-line shortcuts:
"   :vhelp <topic>  opens help in a vertical split
"   :vterm / :hterm open a zsh terminal in a vertical / horizontal split
cnoreabbrev vhelp vert help
cnoreabbrev vterm vsplit term://zsh
cnoreabbrev hterm split term://zsh

" Searches ignore case unless the pattern contains an uppercase letter.
set ignorecase smartcase

" Let Ctrl-A / Ctrl-X increment and decrement letters, hex (0x..) and
" binary (0b..) numbers as well as decimal ones.
set nrformats=alpha,hex,bin

" Swap , and ; so that , repeats an f/t/F/T jump forward and ; goes back.
noremap , ;
noremap ; ,

" Turn on filetype detection, filetype plugins and filetype indentation.
filetype plugin indent on


" -----------------------------------------------------------------------------
" 4. Plugins (vim-plug)
" -----------------------------------------------------------------------------
" Upstream at https://github.com/junegunn/vim-plug
" See the installation section there before using this config.
" Plugins are installed to stdpath('data') . '/plugged'
" (~/.local/share/nvim/plugged). Run :PlugInstall after adding one and
" :PlugUpdate to update them all.
call plug#begin()

  " --- Appearance -----------------------------------------------------------
  " Gruvbox colorscheme.
  Plug 'ellisonleao/gruvbox.nvim'

  " Treesitter: syntax-aware highlighting and indentation.
  " :TSUpdate runs after installing/updating to rebuild the parsers.
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Highlight other uses of the word under the cursor.
  Plug 'RRethy/vim-illuminate'
  " Highlight them immediately instead of after a short pause.
  let g:Illuminate_delay = 0

  " --- Languages and AI -----------------------------------------------------
  " GitHub Copilot inline suggestions.
  Plug 'github/copilot.vim'
  " SageMath syntax support.
  Plug 'petRUShka/vim-sage'

  " --- Searching ------------------------------------------------------------
  " Telescope fuzzy finder; plenary is a Lua helper library it needs.
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim'
  " Searchable cheatsheet of commands and keymaps (:Cheatsheet).
  Plug 'doctorfree/cheatsheet.nvim'

  " --- Buffers and history --------------------------------------------------
  " Visual tree of the undo history (<leader>u).
  Plug 'mbbill/undotree'
  " :Bclose deletes a buffer without closing its window (Ctrl-Q).
  Plug 'rbgrouleff/bclose.vim'

  " --- LaTeX ----------------------------------------------------------------
  " Vimtex: compiling, viewing, text objects and mappings for LaTeX.
  Plug 'lervag/vimtex'
  " UltiSnips snippet engine, plus a collection of LaTeX snippets for it.
  Plug 'sirver/ultisnips'
  Plug 'ckunte/latex-snippets-vim', { 'tag': '*' }
  " SyncTeX forward search to Evince (\lv jumps to the cursor's spot in the PDF).
  Plug 'peterbjorgensen/sved'

  " --- Zotero ---------------------------------------------------------------
  " Insert and look up citations from Zotero.
  " Depends on nvim-treesitter and telescope.nvim (loaded above).
  Plug 'jalvesaq/zotcite'

  " --- Editing helpers ------------------------------------------------------
  " Live Markdown preview in the browser (:MarkdownPreview).
  Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
  " Makes . repeat plugin commands (e.g. surround) and not only built-in ones.
  Plug 'tpope/vim-repeat'
  " Add, change and delete surrounding pairs: ys{motion}{char}, cs{old}{new},
  " ds{char}, and S{char} in visual mode.
  Plug 'tpope/vim-surround'
  " (Commenting is built into Neovim: gcc for a line, gc{motion} or gc in
  " visual mode.)
  " Detect indentation (tabs vs spaces, width) from the file automatically.
  Plug 'tpope/vim-sleuth'

  " --- Git ------------------------------------------------------------------
  " Keymaps are in section 2 (<leader>g..., <leader>h...).
  " Fugitive: Git commands inside Neovim (:Git, :Gdiffsplit, ...).
  Plug 'tpope/vim-fugitive'
  " Show added/changed/removed lines in the sign column.
  Plug 'airblade/vim-gitgutter'
  " Plug 'f-person/git-blame.nvim'

  " --- LSP (language servers) -----------------------------------------------
  " Default server configurations for vim.lsp.
  Plug 'neovim/nvim-lspconfig'
  " Mason installs language servers; mason-lspconfig enables them.
  Plug 'mason-org/mason.nvim'
  Plug 'mason-org/mason-lspconfig.nvim'

  " --- Autocompletion -------------------------------------------------------
  " nvim-cmp popup menu, with sources for LSP, words in open buffers,
  " file paths and Neovim's Lua API.
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lua'

  " --- Status line and icons ------------------------------------------------
  " Lualine status line and buffer/tab line.
  Plug 'nvim-lualine/lualine.nvim'
  " File-type icons used by Lualine and Telescope.
  Plug 'nvim-tree/nvim-web-devicons'

" Finish plugin setup: add the plugins to the runtimepath and load them.
call plug#end()


" -----------------------------------------------------------------------------
" 5. Colorscheme and highlights
" -----------------------------------------------------------------------------
" Use 24-bit colors instead of the terminal's 256-color palette.
set termguicolors
" Custom highlights, re-applied whenever a colorscheme loads (otherwise the
" colorscheme overwrites them). Uses gui* attributes since termguicolors is on.
"   Normal                  transparent background (shows the terminal's)
"   ColorColumn             color of the column-80 guide
"   YankHighlight           color of the flash after yanking
"   IlluminatedWord*        other uses of the word under the cursor in bold
augroup custom_highlights
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=none
        \ | highlight ColorColumn guibg=#504945
        \ | highlight YankHighlight guibg=#504945
        \ | highlight IlluminatedWordText gui=bold
        \ | highlight IlluminatedWordRead gui=bold
        \ | highlight IlluminatedWordWrite gui=bold
augroup END
colorscheme gruvbox


" -----------------------------------------------------------------------------
" 6. Plugin settings (Vimscript)
" -----------------------------------------------------------------------------

" --- Undotree ----------------------------------------------------------------
" <leader>u opens/closes the undo history tree.
nnoremap <leader>u :UndotreeToggle<CR>

" --- Vimtex ------------------------------------------------------------------
" Open compiled PDFs in Evince.
let g:vimtex_view_general_viewer = 'evince'
" Open the quickfix window for errors only, not for warnings.
let g:vimtex_quickfix_open_on_warning = 0
" Prefix for Vimtex's insert-mode math shortcuts (default is `).
let g:vimtex_imaps_leader='!'
" \lv jumps to the cursor's position in the Evince PDF (sved), replacing
" Vimtex's own \lv.
nnoremap <localleader>lv :call SVED_Sync()<CR>

" Turn off Vimtex's default insert-mode maps that start with j, so typing
" j quickly doesn't get intercepted.
let g:vimtex_imaps_disabled = ['jj', 'jJ', 'jh', 'jH', 'jk', 'jK', 'jl', 'jL']
" Extra insert-mode shortcuts for arrows and relations. They only expand
" inside math mode (the wrap_math wrapper); elsewhere they type normally.
" Note: Vimtex puts the leader (!) in front of each lhs itself, so an lhs
" of '!n' is actually typed as !!n, and '~' as !~.
"   n / N   left arrow  \leftarrow / \Leftarrow   (! also gives \leftarrow)
"   o / O   right arrow \rightarrow / \Rightarrow (õ / Õ do the same)
"   e / E   up arrow    \uparrow / \Uparrow
"   i / I   down arrow  \downarrow / \Downarrow
"   =       \Leftrightarrow
"   ~ < >   \approx, \le, \ge
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

" Don't add extra indentation inside delimiters like ( [ { or \left \right.
let g:vimtex_indent_delims = {}

" --- UltiSnips ---------------------------------------------------------------
" Tab expands a snippet; Ctrl-J / Ctrl-K jump to the next / previous field.
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" --- LaTeX text formatting (\b, \i, \e, \u) ---------------------------------
" In .tex files, \<key> wraps the word under the cursor (normal mode) or the
" selection (visual mode) in the matching LaTeX command, e.g. \b -> \textbf{}.
" To add a command, add a line to this table.
let s:tex_surrounds = {
      \ 'b': 'textbf',
      \ 'i': 'textit',
      \ 'e': 'emph',
      \ 'u': 'underline',
      \ }

" Runs in every .tex buffer. The wrapping itself is done by vim-surround
" (which also makes . repeat it), so each key is registered with surround
" for this buffer only (b:), leaving ysiwb, Sb, etc. untouched in all other
" files. \r marks where the wrapped text goes.
function! s:setup_tex_surrounds() abort
  for [l:key, l:cmd] in items(s:tex_surrounds)
    let b:surround_{char2nr(l:key)} = '\' . l:cmd . "{\r}"
    execute 'nmap <buffer> <localleader>' . l:key . ' ysiw' . l:key
    execute 'xmap <buffer> <localleader>' . l:key . ' S' . l:key
  endfor
endfunction

augroup tex_surround
  autocmd!
  autocmd FileType tex call s:setup_tex_surrounds()
augroup END

" --- Telescope keymaps -------------------------------------------------------
" Every Telescope picker starts with <leader>f.

" General: <leader>f + letter
"   ff files   fsl live grep (search text)   fsc grep word under cursor
"   fb buffers fc command history  fh search history  fr registers
"   fz spelling suggestions        fk keymaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fsl <cmd>Telescope live_grep<cr>
nnoremap <leader>fsc <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fc <cmd>Telescope command_history<cr>
nnoremap <leader>fh <cmd>Telescope search_history<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fz <cmd>Telescope spell_suggest<cr>
nnoremap <leader>fk <cmd>Telescope keymaps<cr>

" LSP: <leader>fl + letter
"   r references   ci incoming calls   co outgoing calls
"   s symbols in this file   w symbols in the workspace
"   i implementations   d definitions   t type definitions
nnoremap <leader>flr <cmd>Telescope lsp_references<cr>
nnoremap <leader>flci <cmd>Telescope lsp_incoming_calls<cr>
nnoremap <leader>flco <cmd>Telescope lsp_outgoing_calls<cr>
nnoremap <leader>fls <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>flw <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fli <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>fld <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>flt <cmd>Telescope lsp_type_definitions<cr>

" Git: <leader>fg + letter
"   c commits   b branches   s changed files (status)
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>

" Meta: fp list of all pickers, fo Neovim options, f? help pages
nnoremap <leader>fp <cmd>Telescope builtin<cr>
nnoremap <leader>fo <cmd>Telescope vim_options<cr>
nnoremap <leader>f? <cmd>Telescope help_tags<cr>


" -----------------------------------------------------------------------------
" 7. Plugin settings (Lua)
" -----------------------------------------------------------------------------
" Everything between `lua << END` and the closing `END` is Lua code.
lua << END
  ------------------------------ YANK HIGHLIGHT -------------------------------
  -- Briefly highlight text right after it is yanked, for 1 second (the
  -- same duration vim-highlightedyank used). The color is set in the
  -- custom_highlights group above.

  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.hl.on_yank({ higroup = 'YankHighlight', timeout = 1000 })
    end,
  })

  ---------------------------- TELESCOPE CONFIG -------------------------------

  require('telescope').setup{
    defaults = {
      -- "flex" puts the preview beside the results in wide windows and
      -- below them in narrow ones.
      layout_strategy = "flex",
      layout_config = {
	-- Use 90% of the editor width.
	width = 0.9,
	flex = {
	  horizontal = {
	    -- In the side-by-side layout, the preview takes 55% of the width.
	    preview_width = 0.55
	  }
	}
      },
      mappings = {
	-- In the prompt (insert mode), Ctrl-H lists Telescope's own keymaps.
	i = {
	  ["<C-h>"] = "which_key"
	}
      }
    },
    -- Per-picker settings (none yet).
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
    --   Alt-Enter  put the command on the command line without running it
    --   Enter      run the command
    --   Ctrl-Y     copy the command
    --   Ctrl-E     edit your own cheatsheet file
    telescope_mappings = {
        ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
        ['<CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
        ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
        ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
    }
})

  ----------------------------- LUALINE CONFIG --------------------------------
  -- The status line is split into sections a b c (left) and x y z (right).

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'material',
      -- No separator characters between components or sections.
      component_separators = {left = '', right = ''},
      section_separators = {left = '', right = ''},
      disabled_filetypes = {},
      -- Let the left sections use the middle space when they need it.
      always_divide_middle = false,
      -- One status line per window, not a single global one.
      globalstatus = false,
    },
    -- Status line of the focused window.
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      -- path=1 shows the file path relative to the working directory.
      lualine_c = { { 'filename', path=1 } },
      lualine_x = { 'filetype' },
      -- Percentage through the file, then line:column.
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    -- Status line of the other windows.
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    -- Top line of the screen: open buffers and tabs on the left, line-ending
    -- format and machine name on the right.
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
    -- Parsers installed automatically at startup.
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query" },
    -- Install them in the background instead of blocking startup.
    sync_install = false,
    -- Don't install parsers for other languages when opening their files.
    auto_install = false,
    highlight = {
      enable = true,
      -- Skip treesitter highlighting for LaTeX and Markdown (Vimtex and the
      -- regular syntax files handle those) and for files over 100 KB, where
      -- it can get slow.
      disable = function(lang, buf)
        if lang == 'latex' or lang == 'markdown' then
          return true
        end
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      -- Don't also run the old regex syntax highlighting where treesitter is on.
      additional_vim_regex_highlighting = false,
    },
    -- Use treesitter to compute indentation (the = operator).
    indent = {
      enable = true
    }
  }

  -- Force-stop Neovim's native treesitter highlighter for markdown/html,
  -- since nvim-treesitter's own `disable` above doesn't stop the built-in
  -- highlighter that Neovim 0.11+ can auto-attach independently.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "html" },
    callback = function(args)
      vim.treesitter.stop(args.buf)
    end,
  })

  ------------------------------ ZOTCITE CONFIG -------------------------------
  -- Load zotcite only if it is installed, so a missing plugin doesn't stop
  -- the rest of the config from loading.

  local ok_zotcite, zotcite = pcall(require, 'zotcite')
  if ok_zotcite then
    zotcite.setup({
      -- your options here (see :help zotcite)
    })
  end

  --------------------------------- LSP CONFIG --------------------------------

  -- Rounded borders on hover/signature/diagnostic popups.
  vim.o.winborder = 'rounded'

  -- Tell every server that nvim-cmp can handle its completion items.
  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  -- Make lua_ls understand Neovim's Lua API (for editing this config).
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
      },
    },
  })

  -- Mason installs the server programs; mason-lspconfig enables every
  -- server installed through Mason. Install more with :Mason.
  -- lua_ls is for Lua, basedpyright for Python, and texlab for LaTeX
  -- (completion of \ref and \cite labels, go to a label's definition,
  -- error checking). Vimtex still handles compiling and the PDF viewer.
  require('mason').setup()
  require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'basedpyright', 'texlab' },
    automatic_enable = true,
  })

  -- clangd (C/C++) comes from the system package, not Mason.
  vim.lsp.enable('clangd')

  -- Keymaps, set only in buffers where a language server is attached.
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      -- Shorthand for a buffer-local normal-mode mapping with a description
      -- (the description shows up in <leader>fk).
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { buffer = args.buf, desc = desc })
      end
      map('K',    vim.lsp.buf.hover,           'LSP hover docs')
      map('gd',   vim.lsp.buf.definition,      'LSP go to definition')
      map('gD',   vim.lsp.buf.declaration,     'LSP go to declaration')
      map('gi',   vim.lsp.buf.implementation,  'LSP go to implementation')
      map('go',   vim.lsp.buf.type_definition, 'LSP go to type definition')
      map('gr',   vim.lsp.buf.references,      'LSP references')
      map('gs',   vim.lsp.buf.signature_help,  'LSP signature help')
      map('gl',   vim.diagnostic.open_float,   'Show diagnostic')
      map('<F2>', vim.lsp.buf.rename,          'LSP rename')
      map('<F3>', function() vim.lsp.buf.format({ async = true }) end, 'LSP format')
      map('<F4>', vim.lsp.buf.code_action,     'LSP code action')
      -- [d / ]d (previous/next diagnostic) are Neovim defaults.
    end,
  })

  --------------------------------- CMP CONFIG --------------------------------

  local cmp = require('cmp')

  cmp.setup({
    -- Expand snippet-style LSP completions (e.g. function arguments) with
    -- Neovim's built-in snippet support. Your own snippets stay in UltiSnips.
    snippet = {
      expand = function(args) vim.snippet.expand(args.body) end,
    },
    -- Same keys lsp-zero gave you. <Tab> is deliberately left to UltiSnips.
    --   Ctrl-Y        accept the selected item (or the first one)
    --   Ctrl-E        close the menu
    --   Ctrl-D/Ctrl-U scroll the documentation window down / up
    --   Ctrl-N/Ctrl-P next / previous item, or open the menu if it's closed
    --   Down/Up       next / previous item
    mapping = {
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-n>'] = cmp.mapping(function()
        if cmp.visible() then cmp.select_next_item() else cmp.complete() end
      end),
      ['<C-p>'] = cmp.mapping(function()
        if cmp.visible() then cmp.select_prev_item() else cmp.complete() end
      end),
      ['<Down>'] = cmp.mapping.select_next_item(),
      ['<Up>'] = cmp.mapping.select_prev_item(),
    },
    -- Give the documentation popup a border.
    window = {
      documentation = cmp.config.window.bordered(),
    },
    -- Where suggestions come from, highest priority first: file paths,
    -- the language server, Neovim's Lua API (only in Lua code), then words
    -- from open buffers (only after typing 3 characters).
    sources = {
      {name = 'path'},
      {name = 'nvim_lsp'},
      {name = 'nvim_lua'},
      {name = 'buffer', keyword_length = 3},
    }
  })

END
