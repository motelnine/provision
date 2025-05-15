#!/bin/ksh

# Echos Y/N prompt to sell
yn () {
  printf "Install '%s' [y/n] " "$1"
}

# Checks if package is installed and installs it if not
check_and_install_package () {
	package_name="$1"
	command_name="$2"

	# If command_name is not provided, use package_name
	if [ -z "$command_name" ]; then
		command_name="$package_name"
	fi

	echo -n "Checking for [$package_name]..."

	# Check if the command exists in the PATH
	if ! command -v "$command_name" >/dev/null 2>&1; then
		 print "Not Found"

		 # Attempt installation using pkg_add
		print "Attempting to install $package_name using pkg_add..."
		if pkg_add "$package_name"; then
			print "$package_name installed successfully."
		else
			print "Error: Failed to install $package_name."
			 exit 1
		fi
	else
		print "Found"
	fi
}


check_and_install_package "wget"
check_and_install_package "git"
check_and_install_package "curl"

yn "Install neofetch?"
read NEOVIM
if [ $NEOVIM == "y" ]
then
	sudo pkg_add neofetch
fi

yn "Configure neovim"
read CONFNEOVIM
if [ $CONFNEOVIM == "y" ]
then

	# Create NeoVim config directories
	mkdir -p ~/.config/nvim/autoload
	mkdir -p ~/.config/nvim/bundle
	mkdir -p ~/.config/nvim/colors

	# Install vim-plug (modern alternative to pathogen for NeoVim)
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# Download plugins
	git clone https://github.com/maximbaz/lightline-ale ~/.config/nvim/bundle/lightline-ale
	git clone https://github.com/itchyny/lightline.vim ~/.config/nvim/bundle/lightline
	git clone https://github.com/scrooloose/nerdtree ~/.config/nvim/bundle/nerdtree
	git clone https://github.com/VundleVim/Vundle.vim ~/.config/nvim/bundle/Vundle.vim
	git clone https://github.com/editorconfig/editorconfig-vim.git ~/.config/nvim/bundle/editorconfig-vim
	git clone https://github.com/mxw/vim-jsx.git ~/.config/nvim/bundle/vim-jsx
	git clone https://github.com/ryanoasis/vim-devicons ~/.config/nvim/bundle/vim-devicons
	git clone https://github.com/airblade/vim-gitgutter ~/.config/nvim/bundle/vim-gitgutter
	git clone https://github.com/fatih/vim-go.git ~/.config/nvim/bundle/vim-go
	git clone https://github.com/dense-analysis/ale.git ~/.config/nvim/bundle/ale
	git clone https://github.com/isRuslan/vim-es6.git ~/.config/nvim/bundle/vim-es6

	# Download colorscheme
	wget https://raw.githubusercontent.com/Reewr/vim-monokai-phoenix/master/colors/monokai-phoenix.vim -O ~/.config/nvim/colors/monokai-phoenix.vim 

	# Copy default neovim config file
	cp defaults/init.vim ~/.config/nvim/init.vim

	echo "IMPORTANT: Run ':PlugInstall' the first time you open NeoVim to install plugins."
fi









