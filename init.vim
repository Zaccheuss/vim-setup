" =============================================================================
" ==== PLUGINS ====
" =============================================================================
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'
Plug 'phaazon/hop.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'embear/vim-localvimrc'
Plug 'preservim/nerdtree'
Plug 'APZelos/blamer.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kkharji/sqlite.lua'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
Plug 'tpope/vim-surround'
Plug 'sphamba/smear-cursor.nvim'

" avante setup
Plug 'stevearc/dressing.nvim'
Plug 'MunifTanjim/nui.nvim'

Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }
call plug#end()

autocmd! User avante.nvim 

lua << EOF
  require('avante_lib').load()
  require('avante').setup(
  {
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    provider = "claude", -- Recommend using Claude
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
    -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
    auto_suggestions_provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
      temperature = 0,
      max_tokens = 4096,
      },
    ---Specify the special dual_boost mode
    ---1. enabled: Whether to enable dual_boost mode. Default to false.
    ---2. first_provider: The first provider to generate response. Default to "openai".
    ---3. second_provider: The second provider to generate response. Default to "claude".
    ---4. prompt: The prompt to generate response based on the two reference outputs.
    ---5. timeout: Timeout in milliseconds. Default to 60000.
    ---How it works:
    --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
    ---Note: This is an experimental feature and may not work as expected.
    dual_boost = {
      enabled = false,
      first_provider = "openai",
      second_provider = "claude",
      prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
      timeout = 60000, -- Timeout in milliseconds
      },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      },
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
      },
      },
    hints = { enabled = true },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 30, -- default % based on available width
      sidebar_header = {
        enabled = true, -- true, false to enable/disable the header
        align = "center", -- left, center, right for title
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8, -- Height of the input window in vertical layout
      },
      edit = {
        border = "rounded",
        start_insert = true, -- Start insert mode when opening the edit window
      },
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = true, -- Start insert mode when opening the ask window
        border = "rounded",
        ---@type "ours" | "theirs"
        focus_on_apply = "ours", -- which diff to focus after applying
      },
      },
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = "DiffText",
        incoming = "DiffAdd",
      },
      },
    --- @class AvanteConflictUserConfig
    diff = {
      autojump = true,
      ---@type string | fun(): any
      list_opener = "copen",
      --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
      --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
      --- Disable by setting to -1.
      override_timeoutlen = 500,
      },
    suggestion = {
      debounce = 600,
      throttle = 600,
      },
    }
  )
EOF


" retired plugins
" Plug 'easymotion/vim-easymotion'
" Plug 'p00f/nvim-ts-rainbow'
" Plug 'sunjon/shade.nvim' ---- breaks CoC hover (e.g. when pressing Ctrl + K)

" enable treesitter syntax highlighting
lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "bash", "javascript", "json", "tsx", "typescript", "vim", "css", "scss"},
    sync_install = false,
    highlight = { 
      enable = true,
      additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
    rainbow = {
      enable = true,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
    }
  }
EOF

" enable smear
lua require('smear_cursor').enabled = true

" enable indent-blankline
lua << EOF
  require("ibl").setup {
    scope = { enabled = false }  
  }
EOF


" " nerdtree
" lua << EOF
"   require('nvim-tree').setup({
"     view = { relativenumber = true }
"   })
" EOF

" telescope
lua << EOF
  require('telescope').setup {
    pickers = {
      --buffers = {
      --  sort_lastused = true,
      --},
      --live_grep = {
      --  only_sort_text = true
      --}
    },
    defaults = {
      layout_config = {
        width = 0.95,
      },
      mappings = {
        n = { 
          -- Normal mode mappings go here
        },
        i = {
          ["<C-j>"] = {
            require("telescope.actions").move_selection_next, type = "action",
            opts = { nowait = true, silent = true }
          },
          ["<C-k>"] = {
            require("telescope.actions").move_selection_previous, type = "action",
            opts = { nowait = true, silent = true }
          },
          ["<Esc>"] = require("telescope.actions").close
        }
      }
    }
  }

  require('telescope').setup {
    defaults = {
      path_display = {"shorten"},
    },
    extensions = {
      fzf = {
        -- path_display = {"shorten"},
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      },
      frecency = {
        show_scores = false,
        show_unindexed = false,
        show_filter_column = {"mobile", "helios"},
        ignore_patterns = {"*.git/*", "*/tmp/*", "*/node_modules/*", "*/ios/*", "*.yarn/*", "/android/*"},
        workspaces = {
          ["mobile"] = "/Users/zfuller/milli/mino-mobile",
          ["helios"] = "/Users/zfuller/milli/mino-helios",
        }
      }
    }
  }
  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('frecency')
EOF

" initialize hop
lua << EOF
    require'hop'.setup()
EOF

" catppuccin color scheme
lua << EOF
    require("catppuccin").setup {
        flavour = "macchiato", -- mocha, macchiato, frappe, latte
        transparent_background = true,
        integrations = {
          treesitter = true,
          treesitter_context = true,
          hop = true,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "italic" },
          functions = { "italic" },
          keywords = {},
          strings = { "italic" },
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
    }
EOF

lua << EOF
  require('harpoon').setup()
EOF

" =============================================================================
" ==== SET VIM VARIABLES ====
" =============================================================================
set hidden 	       "open files in other buffers without saving
set number         "turn line numbers on
set colorcolumn=80 "show vertical line at 80 characters
set scrolloff=4    "scroll when cursor is within 4 lines of the end of screen
set termguicolors  "make color theme look correct, specifically bg color
set number relativenumber
set cursorline     "highlight the line the cursor is on
colorscheme catppuccin-macchiato

set autoindent     "indent size
set smartindent    "indent size
set expandtab      "indent size
set tabstop=2      "indent size
set shiftwidth=2   "indent size
set softtabstop=2  "indent size

set showmatch      "show matching brackets
set ignorecase     "case insensitive matching
set smartcase      "do case sensitive matching when a capital letter is typed
set incsearch	   "incremental search, show matches as you are typing

set signcolumn=yes "Show sign column and line number separately

"cursor fix in windows terminal
" let &t_SI.="\e[5 q"
" let &t_SR.="\e[4 q"
" let &t_EI.="\e[1 q"

"set default airline theme (for coloring the statusline)
let g:airline_theme='catppuccin'

"truncate branch namae
" let g:airline#extensions#branch#displayed_head_limit = 10
" let g:airline#extensions#branch#format = 1
"remove branch info and file encoding entirely
let g:airline_section_b=''
let g:airline_section_y=''

" blamer.nvim (git lens copycat)
let g:blamer_enabled=1
let g:blamer_delay=1000 "default=1000
let g:blamer_date_format='%m/%d/%y'
let g:blamer_show_in_visual_modes = 0

" All defaults except border & title
let g:gitgutter_floating_window_options= {
      \ 'title': 'Git',
      \ 'title_pos': 'center',
      \ 'border': 'rounded',
      \ 'relative': 'cursor',
      \ 'row': 1,
      \ 'col': 0,
      \ 'width': 42,
      \ 'height': &previewheight,
      \ 'style': 'minimal'
      \}

" Open nerdtree on the right and set max width higher (autosizes by default)
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 60
let NERDTreeShowLineNumbers = 1

" Increase size of fzf search window, messing around with colors
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_colors =
\ { 
  \ 'border':  ['fg', 'Conditional'],
  \ 'gutter':  ['bg', 'Normal'],
\}
" let g:fzf_colors =
" \ { 
"   \ 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'Statement'],
"   \ 'border':  ['fg', 'Conditional'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] 
" \}

" Make bat (cat alternative) the default fzf preview, which allows for syntax
" highlighting in the preview window
let g:fzf_files_options = '--preview "bat --theme="Dracula" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

" Shorter command for viewing git status files via Telescope
command! -nargs=0 Tg :Telescope git_status

hi LineNr guibg=none guifg=#71768f

" =============================================================================
" ==== REMAPS ====
" =============================================================================
" Set a second leader, disable space's default behavior
nnoremap <space> <Nop>
map <space> <leader>
map <space><space> <leader><leader>

nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>l <cmd>Telescope frecency<cr>
" nnoremap <leader>o <cmd>Telescope live_grep<cr> "Get rid of this for now,
" :Rg appears to be better for fuzzy searching text
nnoremap <leader>o :Rg<cr>

nnoremap <leader>gg :GitGutterPreviewHunk<cr>
nnoremap <leader>gn :GitGutterNextHunk<cr>
nnoremap <leader>gN :GitGutterPrevHunk<cr>
nnoremap <leader>gu :GitGutterUndoHunk<cr>
" Refresh signs
nnoremap <leader>gR :GitGutterAll<cr>
" Quickly switch between previous buffer
nnoremap <leader>s :b#<cr> 

" Map easymotion keybinds to hop plugin
nnoremap <leader><leader>w :HopWordAC<cr>
nnoremap <leader><leader>b :HopWordBC<cr>
nnoremap <leader><leader>j :HopLineStartAC<cr>
nnoremap <leader><leader>k :HopLineStartBC<cr>

" NERDTree keybinds
nnoremap <leader>t :NERDTreeToggle<cr>
" Find the current file location in the file tree and opens the nerdtree buf
nnoremap <leader><leader>t :NERDTreeFind<cr>

" Use tab to cycle through buffers
lua << EOF
 vim.keymap.set('n', '<Tab>', '<cmd>:bnext<cr>')
 vim.keymap.set('n', '<S-Tab>', '<cmd>:bprevious<cr>')
EOF

" Close buffer in split pane without closing split
nnoremap <leader>w :bp\|bd#<CR>

" Harpoon
lua << EOF
  local harpoon = require("harpoon")
  vim.keymap.set('n', '<leader><leader>y', function() harpoon:list():add() end)
  vim.keymap.set('n', '<leader><leader>u', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
EOF

" =============================================================================
" ==== AUTOCMDS & COMMANDS ====
" =============================================================================
" Wrap text when editing Markdown files
autocmd BufEnter *.md setlocal textwidth=119
autocmd BufEnter *.md setlocal colorcolumn=120

" =============================================================================
" ==== COC RECOMMENDED CONFIG ====
" =============================================================================
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>eN <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>en <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader><leader>a  :<C-u>CocList diagnostics<cr>

" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>

" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>

" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>

" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
