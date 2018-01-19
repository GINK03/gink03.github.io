---
layout: post
title:  "vimのsetup, molokai, bundle編"
date:   2017-04-02
excerpt: "自分向け資料"
project: false
config: true
tag:
- LagacyVim
- vim
comments: false
---
# vim設定
## 目次

**bundleのインストール**  
**vimrc**    

## bundleのインストール
```sh
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```
## vimrc

```sh
set nocompatible
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'cake.vim'
Bundle 'neocomplcache'
Bundle 'unite.vim'
Bundle 'surround.vim'
Bundle 'taglist.vim'
Bundle 'ZenCoding.vim'
Bundle 'ref.vim'
Bundle 'The-NERD-Commenter'
Bundle 'minibufexpl.vim'
Bundle 'Conque-Shell'
Bundle 'derekwyatt/vim-scala'
Bundle "git://github.com/vim-scripts/AutoComplPop.git"
Bundle 'git://github.com/vim-scripts/VimClojure.git'
Bundle 'git://github.com/tomasr/molokai.git'
Bundle 'fatih/vim-go'
Bundle 'git://github.com/leafgarland/typescript-vim.git'
Bundle 'git://github.com/othree/eregex.vim.git'
filetype plugin indent on
"nerd tree
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd VimEnter * NERDTree

colorscheme molokai
set t_Co=256
set number
syntax on
set hlsearch
set backspace=start,eol,indent
set expandtab
set ts=2
set tabstop=2
set directory=$HOME/vimbackup
set incsearch
set backspace=indent,eol,start
set shiftwidth=1
set nobackup
set history=100
set ignorecase
set wrapscan
set title
set ruler
set wildmenu
set wrap
set textwidth=0
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=
highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white
set encoding=utf-8
set termencoding=utf-8
set fenc=utf-8
```
