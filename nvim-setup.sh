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

# TODO: Make sure C compiler is installed
# TODO: Make sure apt is up to date

# Install neovim and plugin manager
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt install neovim -y
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Create config file and copy over sample
mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim
cp ./init.vim  ~/.config/nvim/init.vim

# Install fzf binary
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install plugins
nvim +'PlugInstall --sync' +qall
nvim +'CocInstall -sync coc-json coc-tsserver' +qall
