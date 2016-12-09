set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'erezsh/erezvim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'ehamberg/vim-cute-python'
Plugin 'davidhalter/jedi-vim'
Plugin 'klen/python-mode'

call vundle#end()            " required
filetype plugin indent on    " required
