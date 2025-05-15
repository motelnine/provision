#!/bin/ksh

# Echos Y/N prompt to sell
yn () {
  printf "Install '%s' [y/n] " "$1"
}

# nginx provision vars
NGINX_CONFIG_LOCATION="/etc/nginx.conf"


# Install nginx prompt
yn "nginx?"
read NGINX
if [ $NGINX == "y" ]
then
	pkg_add nginx
fi

# Fetch default nginx configuration
yn "default nginx.conf?"
read NGINXCONF
if [ $NGINXCONF == "y" ]
then

	# Copy nginx conf to /etc/nginx.conf
	cp defaults/nginx.conf $NGINX_CONFIG_LOCATION
	echo "nginx.conf copied to $NGINX_CONFIG_LOCATION"
	mkdir -p /etc/nginx/sites-available
	mkdir -p /etc/nginx/sites-enabled

	echo "restarting nginx..."
	/etc/rc.d/nginx restart

fi

