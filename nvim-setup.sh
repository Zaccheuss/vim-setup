#!/bin/bash
if ! command -v nvim &> /dev/null
then
	echo "neovim installation not found, proceeding with automated setup"
	echo "=============================================================="
	echo ""
else
	echo "existing neovim installation found, aborting automated setup"
	exit
fi

# Install neovim and plugin manager
sudo apt install neovim -y
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Create config file and copy over sample
mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim
cat ./sample.vimrc > ~/.config/nvim/init.vim

# Install plugins
nvim +'PlugInstall --sync' +qall
