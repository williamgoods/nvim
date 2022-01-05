let $PATH = "C:\Users\m1735\scoop\apps\git\current\bin;" . $PATH

lua << EOF
    require("core")

    -- this is for telescope plugin

    local actions = require "telescope.actions"
    local config = require "telescope.config"

    local telescope = require("telescope")

    telescope.setup{
      pickers = {
        find_files = {
          theme = "ivy",
        }
      }
    }

    require('telescope').setup{
      defaults = {
        mappings = {
          i = {
            ["<CR>"] = actions.select_tab,
        }
      }
    }
    }
EOF

set timeoutlen=200

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map =  {}

let g:which_key_map.f = {
    \"f" : ["Telescope find_files", "find files"],
    \"b" : ["Telescope buffers", "change buffers"],
    \"h" : ["Telescope help_tags", "get help tags"]
    \}

" Set <LEADER> as <SPACE>, ; as :
" let mapleader=" "

inoremap jj <esc>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <A-t> :tabnew +term<CR>

" nnoremap <A-Left> :tabprevious<CR>                                                                            
" nnoremap <A-Right> :tabnext<CR>
" nnoremap <A-j> :tabprevious<CR>                                                                            
" nnoremap <A-k> :tabnext<CR>
" inoremap <A-j> <esc>:tabprevious<CR>                                                                            
" inoremap <A-k> <esc>:tabnext<CR>

nnoremap <A-Left> :BufferPrevious<CR>                                                                            
nnoremap <A-Right> :BufferNext<CR>
nnoremap <A-j> :BufferPrevious<CR>                                                                            
nnoremap <A-k> :BufferNext<CR>

tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <A-1> :BufferGoto 1<CR>
nnoremap <silent> <A-2> :BufferMovePrevious<CR>
nnoremap <silent> <A-3> :BufferMoveNext<CR>

set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ignorecase

set termguicolors

set mouse=a

let &shell = 'pwsh'
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
set shellquote= shellxquote=

