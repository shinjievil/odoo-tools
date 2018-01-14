#!/bin/bash

wk32="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-i386.deb"
wk64="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb"

# Update and install Postgresql
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install postgresql -y
sudo su - postgres -c "createuser -s $USER"

mkdir ~/Developments
cd ~/Developments
# Download Odoo from git source
git clone https://github.com/odoo/odoo.git -b 11.0 --depth 10

# Install python3 and dependencies for Odoo
sudo apt-get -y install python3 python3-pip python-pip
sudo pip3 install vobject qrcode num2words

# Install nodejs and less
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less

# Download & install WKHTMLTOPDF
rm wkhtml*
if [ "`getconf LONG_BIT`" == "32" ];

then
	wget $wk32
else
	wget $wk64
fi

sudo dpkg --force-depends -i wkhtmltox*.deb
sudo ln -s /usr/local/bin/wkhtml* /usr/bin

# install python requirements file (Odoo)
sed -i '/pyldap/d' ~/Developments/odoo/requirements.txt
sudo pip3 install -r ~/Developments/odoo/requirements.txt


