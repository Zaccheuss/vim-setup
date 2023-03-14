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
Plug 'embear/vim-localvimrc'
Plug 'preservim/nerdtree'
Plug 'APZelos/blamer.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
call plug#end()

" retired plugins
" Plug 'easymotion/vim-easymotion'
" Plug 'p00f/nvim-ts-rainbow'
" Plug 'sunjon/shade.nvim' ---- breaks CoC hover (e.g. when pressing Ctrl + K)

" enable treesitter syntax highlighting
lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "javascript", "json", "tsx", "typescript", "vim", "css", "scss"},
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

" telescope
lua << EOF
  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    },
    defaults = {
      layout_config = {
        width = 0.90
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

  require('telescope').load_extension('fzf')
EOF

" initialize hop
lua << EOF
    require'hop'.setup()
EOF

" catppuccin color scheme
lua << EOF
    require("catppuccin").setup {
        flavour = "macchiato", -- mocha, macchiato, frappe, latte
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

" testing out blamer.nvim (git lens copycat)
let g:blamer_enabled=1
let g:blamer_delay=1000 "default=1000

" All defaults except border & title
let g:gitgutter_floating_window_options= {
      \ 'title': 'Git',
      \ 'border': 'single',
      \ 'relative': 'cursor',
      \ 'row': 1,
      \ 'col': 0,
      \ 'width': 42,
      \ 'height': &previewheight,
      \ 'style': 'minimal'
      \}

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
nnoremap <leader>o <cmd>Telescope live_grep<cr>
nnoremap <leader>g :GitGutterPreviewHunk<cr>

" Map easymotion keybinds to hop plugin
nnoremap <leader><leader>w :HopWordAC<cr>
nnoremap <leader><leader>b :HopWordBC<cr>
nnoremap <leader><leader>j :HopLineStartAC<cr>
nnoremap <leader><leader>k :HopLineStartBC<cr>

" NERDTree keybinds
nnoremap <leader>t :NERDTreeToggle<cr>
" Find the current file location in the file tree and opens the nerdtree buf
nnoremap <leader><leader>t :NERDTreeFind<cr>

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
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
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
