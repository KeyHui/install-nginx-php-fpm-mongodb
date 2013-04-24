#!/usr/bin/env bash

# add 10gen package GPG key and repository
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list

# add latest nginx package PGP key and repository
apt-key adv --keyserver keyserver.ubuntu.com --recv C300EE8C
echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu $(lsb_release -cs) main" >> /etc/apt/sources.list

# update apt and install
apt-get update 
apt-get install -y --force-yes build-essential libcurl4-gnutls-dev php5-fpm php5-dev php-pear php5-cli php5-curl php5-mcrypt php5-gd nginx mongodb-10gen git

# install php-fpm pecl extensions
pecl install pecl_http
pecl install mongo

# enable extensions
echo "extension=mongo.so" >> /etc/php5/fpm/php.ini
echo "extension=http.so" >> /etc/php5/fpm/php.ini

# remove default nginx server conf
rm /etc/nginx/sites-enabled/default
service nginx restart