
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
nnoremap j gj
nnoremap k gk

map <silent> <leader><cr> :noh<cr>
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

