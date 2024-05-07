set clipboard+=unnamedplus  " use the clipboards of vim and win
set go+=a               " Visual selection automatically copied to the clipboard

" set tw=79              " set the tab width
set whichwrap+=<,>,h,l
set autoindent         " autoindent
set timeoutlen=400     " time to wait for a mapped sequence to complete (in milliseconds)
set nocp                    " Sets Vim to not be compatible with Vi, enabling all Vim's features
filetype off                " Turns off filetype detection (often before re-enabling it later for plugin management)
set nu                      " Enables line numbering

set nrformats=              " Sets number formats for increment/decrement operations to be empty (affects <C-a> and <C-x> in normal mode)
syntax on                   " Turns syntax highlighting on
set encoding=utf-8          " Sets the encoding of the buffer to UTF-8, the most common text encoding
filetype plugin indent on   " Enables detection of file types and loads related plugins and indentation schemes
set tabstop=4               " Sets the number of spaces that a tab character represents
set shiftwidth=4            " Sets the number of spaces to use for each step of (auto)indent
" On pressing tab, insert 4 spaces
set mouse=a                 " Enables mouse support in all modes (normal, insert, command-line, and visual)
set expandtab               " Converts tabs to spaces
set background=light        " Sets background theme to light, which affects color schemes
autocmd vimenter * ++nested colorscheme solarized8  " Sets the color scheme to 'solarized8' when Vim starts



" Check if running on Unix (Linux included)
if has('unix')
     " Get the user's home directory
    let user_home = expand('~')
    " Construct the full path to the Conda environment
    let conda_env_path = user_home . '/miniconda3'
    let g:python3_host_prog = conda_env_path . '/bin/python'
endif

" let g:python3_host_prog = '/home/sergeyadmin/miniconda3/bin/python'
call plug#begin()

    Plug 'scrooloose/nerdtree'               " Enables a file tree explorer for navigating the filesystem
    Plug 'luc-tielen/telescope_hoogle'                " Enables fuzzy searching of Haskell functions
    Plug '907th/vim-auto-save'                " Automatically saves changes to your buffer frequently
    Plug 'rust-lang/rust.vim'                 " Provides Rust language support, including syntax and indent plugins
    Plug 'Yggdroot/indentLine'                " Visually displays indent levels with vertical lines
    Plug 'lyokha/vim-xkbswitch'               " Automatically switches keyboard layout for normal and insert modes
    Plug 'mfussenegger/nvim-dap'              " Debug Adapter Protocol client implementation for Neovim
    Plug 'rcarriga/nvim-dap-ui'               " A UI for nvim-dap
    Plug 'mrcjkb/haskell-tools.nvim'          " Adds Haskell language tools and features to Neovim
    Plug 'nvim-telescope/telescope.nvim'      " A highly extendable fuzzy finder over lists
    Plug 'nvim-lua/plenary.nvim'              " A Lua functions library required by many Neovim plugins
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Neovim treesitter configurations and abstraction layer
    Plug 'lifepillar/vim-solarized8'          " Provides the Solarized 8 color scheme, optimized for Vim
    Plug 'tpope/vim-commentary'               " Enables easy commenting of code blocks
    Plug 'rcarriga/nvim-notify'               " A fancy, configurable notification manager for Neovim
    Plug 'dinhhuy258/vim-local-history', {'branch': 'master', 'do': ':UpdateRemotePlugins'}  " Manages local history of files
    Plug 'Vimjas/vim-python-pep8-indent'      " Python indentation plugin to comply with PEP8
    Plug 'github/copilot.vim'                 " GitHub Copilot integration for auto-completion and suggestions
    Plug 'lambdalisue/suda.vim'               " Edit files for which sudo is required
    Plug 'christoomey/vim-tmux-navigator'     " Seamless navigation between tmux panes and Vim splits
    Plug 'farmergreg/vim-lastplace'           " Intelligently jumps to the last place in a file when it's reopened

call plug#end()
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
let g:XkbSwitchEnabled = 1

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Hybrid mode for line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
"

nnoremap HH :LocalHistoryToggle<CR>
nnoremap QQ :q!<CR>
nnoremap vv V
cnoremap <C-A> <Home>
" Convinient exit from insert mode
imap fj <esc>
imap jf <esc>

set wildmenu
set wildmode=full

"Searching
set incsearch          " Incremental search
set ignorecase         " Search case insensitive
set smartcase          " Search case sensitive if query has uppercase characters
set hlsearch           " Highlight search results
"Buffer 
set hidden             " Hide buffers instead of closing them
set autoread           " Automatically read files when changed from the outside
nnoremap <TAB> :bnext<CR>  " Use Tab to navigate through buffers
nnoremap <S-TAB> :bprevious<CR> " Shift-Tab for previous buffer
"History
set history=10000      " Store 1000 commands in history


" Full-screen toggle for the current window (like 'Ctrl-b z' in tmux)
" nmap <C-w>z :only<CR> --does not work for some reason, fix me later

" Split window vertically (like 'Ctrl-b %' in tmux)
nnoremap <C-w>v :vsplit<CR>

" Split window horizontally (like 'Ctrl-b "' in tmux)
nnoremap <C-w>s :split<CR>

" Restore the previous window configuration (no direct tmux equivalent)
" This requires the 'session' feature of Vim to be enabled
" Save the current session with a name like 'current', and restore it later
nnoremap <C-w><C-r> :source Session.vim<CR>
"" Telescope experimental
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>hh <cmd>Telescope hoogle<cr>
luafile ~/.config/nvim/config.lua
if exists('g:vv')
  VVset fontsize=16
endif 
"Enable automatically switch a buffer name when the target file is not readable or writable.
let g:suda#noninteractive = 1
