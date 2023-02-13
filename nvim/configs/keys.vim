let mapleader = ' '

" Telescope
nnoremap <leader>fs <cmd>Telescope find_files<cr>
nnoremap <leader>, <cmd>Telescope buffers<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<CR>
nnoremap <leader>fb <cmd>Telescope current_buffer_fuzzy_find theme=get_ivy<CR>
nnoremap <leader>fS <cmd>Telescope lsp_dynamic_workspace_symbols<CR>

" incremental selection
vmap m grn
vmap M grm

" Go to start of line
noremap - _
noremap _ -

" Fold
nnoremap za zA
nnoremap zA za

" Git
nmap <leader>gg :Gitsigns toggle_signs<CR>
nmap <leader>gb :Gitsigns blame_line<CR>
nmap <leader>gn :Gitsigns next_hunk<CR>
nmap <leader>gN :Gitsigns prev_hunk<CR>
nmap <leader>grb :Gitsigns reset_buffer<CR>
nmap <leader>gsb :Gitsigns stage_buffer<CR>
nmap <leader>gsh :Gitsigns stage_hunk<CR>
nmap <leader>gsH :Gitsigns undo_stage_hunk<CR>

" Hoogle
nnoremap <silent> <leader>oh :Hoogle<CR>

" Hlint
" let g:hlintRefactor#disableDefaultKeybindings = 1
" map <silent><leader>hla :call ApplyOneSuggestion()<CR>
" map <silent><leader>hlA :call ApplyAllSuggestions()<CR>

" File Tree
nnoremap <silent><leader><space> :NvimTreeToggle<CR>

" Visual Mode from Insert
imap <S-Left> <C-\><C-n>vb
imap <S-Right> <C-\><C-n>lve
imap <A-S-Right> <C-\><C-n>lv$
imap <A-S-Left> <C-\><C-n>v0

" Window
nmap <leader>w <C-w>
nmap <leader>w= :vertical resize +7<CR>
" nmap <leader>w+ :resize +3<CR>
nmap <leader>w+ :vertical resize +33<CR>
nmap <leader>w- :vertical resize -7<CR>
" nmap <leader>w_ :resize -3<CR>
nmap <leader>w_ :vertical resize -33<CR>
nmap <leader>wc :q<CR>

" Visual-multi-mode
vmap v <C-N>

" Toggle <t> and Open <o>
map <leader>ou :UndotreeToggle<CR>
map <leader>owf :term python -m http.server<CR>:!firefox -new-window http://127.0.0.1:8000/ &<CR>
map <leader>owc :term python -m http.server<CR>:!google-chrome-stable http://127.0.0.1:8000/ &<CR>
" Comments
vmap <leader>/ gc
nmap <leader>/ gcc<Esc>

" Format code
nmap <leader>cf :FormatWrite<CR>

" Opening terminals
nmap <leader>ot :!kitty &<CR><Enter>

" Buffers
nmap <leader>- :bp<CR>
nmap <leader>= :bn<CR>
nmap <leader>bk :Bdelete!<CR>
nmap <leader>br :write<space>\|<space>edit<space>\|<space>TSBufEnable<space>highlight<CR>

" Tabs
nmap <leader>tt :tabe %<CR>
nmap <leader>[ :tabprev<CR>
nmap <leader>] :tabnext<CR>
nmap <leader>tk :tabclose<CR>

" new file
nmap <leader>np :!touch composer.json<CR>
nmap <leader>ng :!touch .gitignore<CR>

" Other
nmap <Enter> o
nmap <S-Enter> O
" map <tab> %
" imap <A-Tab> <S-Tab>
" map - ^
" autocmd TermOpen * nnoremap <buffer> <Esc> :Bdelete!<CR>
tnoremap <Esc> <C-\><C-n>
map # #``
vmap # *
imap <C-d> <C-o><C-w>o

" Code runner
nmap <leader>rr :w<CR>:lua require("betterTerm").send(require("code_runner.commands").get_filetype_command(), 1, false)<CR>
nmap <leader>rR :w<CR>:lua require("betterTerm").send(require("code_runner.commands").get_project_command().command, 1, false)<CR>
" nmap <leader>rk :w<CR>:RunClose<CR>
nmap <leader>rs :e ~/.config/nvim/lua/codeRunnerConf.lua<CR>

" Terminal
nnoremap <leader>1 :lua require("betterTerm").open(1)<CR>
nnoremap <leader>2 :lua require("betterTerm").open(2)<CR>
nnoremap <leader>3 :lua require("betterTerm").open(3)<CR>
nnoremap <leader>4 :lua require("betterTerm").open(4)<CR>
nmap <leader>Tt :lua require("betterTerm").select()<CR>

" Nvim lsp
nmap gr :Telescope lsp_references theme=get_ivy<CR>
nmap <leader>ce :Telescope diagnostics theme=get_ivy<CR>

" Snippets
nmap <leader>cs :!kitty -e vim ~/.config/nvim/snippets &; disown<CR>

" Spelling (Splunker)
nmap <leader>ss z=
nmap <leader>sa zg
" nmap <leader>sf ZC
" nmap <leader>sa Zg
" nmap <leader>ts ZT
" nmap <leader>sn ZN
" nmap <leader>sN ZP
