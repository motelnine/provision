#!/bin/ksh

# Echos Y/N prompt to sell
yn () {
  printf "Install '%s' [y/n] " "$1"
}

# nginx provision vars
NGINX_CONFIG_URL="https://raw.githubusercontent.com/motelnine/provision/refs/heads/master/openbsd/defaults/nginx.conf"
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
	# fetch default nginx.conf from NGINX_CONFIG_URL
	echo "wget -O /tmp/provision-nginx-config-tmp.conf $NGINX_CONFIG_URL"

	if [ $? == 0 ]; then
		# Copy nginx conf to /etc/nginx.conf
		cp /tmp/provision-nginx-config-tmp.conf $NGINX_CONFIG_LOCATION
		echo "nginx.conf copied to $NGINX_CONFIG_LOCATION"
		mkdir /etc/nginx/sites-available
		mkdir /etc/nginx/sites-enabled
		/etc/rc.d/nginx restart

	else
		# report default nginx.conf fetch error
		echo "[ERR!] - Unable to fetch nginx.conf! Manual intervention required."
    fi
fi

