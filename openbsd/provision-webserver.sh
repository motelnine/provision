#!/bin/ksh

# Echos Y/N prompt to sell
yn () {
  printf "Install '%s' [y/n] " "$1"
}

yn "Install [neovim] editor?"
read NGINX
if [ $NGINX == "y" ]
then
	echo "pkg_add nginx"
fi

