#!/bin/ksh


# Echos Y/N prompt to sell
yn () {
  printf "Install '%s' [y/n] " "$1"
}

# nginx provision vars
NGINX_CONFIG_LOCATION="/etc/nginx.conf"


# Install nginx prompt
yn "nginx webserver?"
read NGINX
if [ $NGINX == "y" ]
then
	doas pkg_add nginx
fi


# Fetch default nginx configuration
yn "default nginx.conf?"
read NGINXCONF
if [ $NGINXCONF == "y" ]
then

	# Copy nginx conf to /etc/nginx.conf
	doas cp $NGINX_CONFIG_LOCATION /tmp/nginx.conf.backup
	doas cp defaults/nginx.conf $NGINX_CONFIG_LOCATION
	echo "nginx.conf copied to $NGINX_CONFIG_LOCATION"
	echo "nginx.conf backup placed in /tmp/nginx.conf.backup"

	doas mkdir -p /etc/nginx/sites-available
	doas mkdir -p /etc/nginx/sites-enabled

	echo "restarting nginx..."
	doas /etc/rc.d/nginx restart
fi


# Install nginx prompt
yn "Hugo CDN?"
read HUGO
if [ $HUGO == "y" ]
then
	doas pkg_add hugo
fi


# Install golang
yn "Golang?"
read GOLANG
if [ $GOLANG == "y" ]
then
	doas pkg_add go
fi


# Install rsync
yn "rsync?"
read RSYNC
if [ $RSYNC == "y" ]
then
	doas pkg_add rsync
fi


# Install wkhtmltopdf
yn "wkhtmltopdf?"
read HTMLTOPDF
if [ $HTMLTOPDF == "y" ]
then
	doas pkg_add wkhtmltopdf
fi

echo "Done please refer to hardening documentation to enhance security."
