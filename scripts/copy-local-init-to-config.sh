#!/bin/bash
if ! command -v nvim &> /dev/null
then
	echo "neovim installation not found"
  exit
fi

if [ -d ~/.config/nvim/ ]; then
  cp ./init.vim  ~/.config/nvim/init.vim
  echo "local init.vim copied to ~/.config/nvim/init.vim"
else
  echo "Could not find ~/.config/nvim/"
fi
