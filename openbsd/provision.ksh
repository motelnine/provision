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
		if doas pkg_add "$package_name"; then
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


# Enable doas if not enabled
if [[ -e "/etc/doas.conf" ]]; then
	echo "/etc/doas.conf exists. Assuming doas is enabled."
else
	echo -n "Enabling doas..."
	echo 'permit nopass keepenv :wheel' > /etc/doas.conf
	echo "done."
fi

# Install neovim
yn "neovim editor?"
read NEOVIM
if [ $NEOVIM == "y" ]
then
	doas pkg_add neovim
	doas ln -s /usr/local/bin/nvim /usr/local/bin/vim
fi


# Install bash and fish
yn "shells: bash,fish?"
read BASH
if [ $BASH == "y" ]
then
	doas pkg_add bash fish
fi


# Install htop
yn "htop"
read HTOP
if [ $HTOP == "y" ]
then
	doas pkg_add htop
fi


# Disable sendmail/smtp bullshit
echo "Disabling sendmail..."
doas rcctl stop sendmail
doas rcctl disable sendmail

echo "Disableing smtp..."
doas rcctl stop smtpd
doas rcctl disable smtpd


echo "Done please refer to hardening documentation to enhance security."
