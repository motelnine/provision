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
		if sudo pkg_add "$package_name"; then
			print "$package_name installed successfully."
		else
			print "Error: Failed to install $package_name."
			 exit 1
		fi
	else
		print "Found"
	fi
}


yn "PostgreSQL"
read PGSQL
if [ $PGSQL == "y" ]
then
	echo "Installing PostgreSQL..."
	sudo pkg_add postgresql-server

	echo "Initializing PostgreSQL database..."
	sudo -u _postgresql initdb -D /var/postgresql/data -U postgres -W -A scram-sha-256 -E UTF8 --locale=en_US.UTF-8

	echo "Enabling PostgreSQL service..."
	sudo rcctl start postgresql
	sudo rcctl enable postgresql

	echo "[NOTE]: The PosrgreSQL super user is _postgresql"
	echo "[....]: To test, as this user execute: psql -U postgres"
fi


# TODO PostgreSQL default configuration:
#   /var/postgresql/data/pg_hba.conf
#   /var/postgresql/data/postgresql.conf

echo "Done please refer to hardening documentation to enhance security."
