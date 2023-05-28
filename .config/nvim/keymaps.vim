
" backspace in Visual mode deletes selection
vnoremap <BS> d

" The C-g u sets an undo point, so this has the effect of letting me type for a while and have undo just revert one sentence at a time, instead of everything I've typed since entering insert mode.
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap : :<C-g>u

" make Y like C/D
nnoremap Y y$

" more intuitive j/k
" nnoremap j gj
" nnoremap k gk

" map <silent> <leader><cr> :noh<cr>
iab DATE <c-r>=strftime("%d/%m/%y")<cr>
"imap <C-F><C-F> <ESC>*i
imap <C-Space> <C-x><C-o>
map <C-F10> :TaskList<CR>
map <C-F9> :TlistToggle<CR>
map <C-F6> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"Arrow selections (insert)
imap <S-left> <esc>v
imap <S-C-left> <esc>v<right><S-C-left>

imap <S-right> <esc><right>v
imap <S-C-right> <esc><right>v<S-C-right>

imap <S-up> <esc><right>v<up>
imap <S-down> <esc><right>v<down>

"Arrow selections (normal + visual)
nmap <S-left> v<left>
nmap <S-C-left> v<S-C-left>
vmap <S-left> <left>

nmap <S-Up> V<Up>
vmap <S-Up> <Up>

nmap <S-Down> V<Down>
vmap <S-Down> <Down>

nmap <S-Right> v<Right>
nmap <S-C-Right> v<S-C-Right>
vmap <S-Right> <Right>

"Clipboard copy+paste
vmap <C-x> "+d
vmap <S-del> "+d
vmap <C-c> "+y
vmap <C-insert> "+y
nmap <C-v> "+P
nmap <S-insert> "+P
imap <C-v> <C-r>+
imap <S-insert> <C-r>+

" Save file
imap <C-s> <esc>:w<cr>
nmap <C-s> :w<cr>

" Trouble bindings
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" bindings for WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
nmap <leader>tld  <Plug>(toggle-lsp-diag)
nmap <leader>tlv <Plug>(toggle-lsp-diag-vtext)


"
" nnoremap <C-left> <C-w><left>
" nnoremap <C-right> <C-w><right>
" nnoremap <C-up> <C-w><up>
" nnoremap <C-down> <C-w><down>
"
"quick edit in same directory
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>
