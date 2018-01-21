#!/bin/bash

ODOOVERSION=9.0
DEPTH=10
PATHBASE=~/Developments
PATHREPOS=~/Developments/addons


wk32="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-i386.deb"
wk64="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb"

# Update and install Postgresql
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install postgresql -y
sudo su - postgres -c "createuser -s $USER"

mkdir $PATHBASE
mkdir $PATHREPOS

# Download Odoo from git source
cd $PATHBASE
git clone https://github.com/odoo/odoo.git -b $ODOOVERSION --depth=$DEPTH0

# Download repos OCA
cd $PATHREPOS
git clone https://github.com/OCA/l10n-spain.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/partner-contact.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/bank-payment.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/account-financial-reporting.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/account-financial-tools.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/reporting-engine.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/web.git -b $ODOOVERSION --depth=$DEPTH
#git clone https://github.com/treytux/odoo-product.git --depth=$DEPTH
git clone https://github.com/OCA/account-invoicing.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/account-payment.git -b $ODOOVERSION --depth=$DEPTH
#git clone https://github.com/treytux/odoo-security.git --depth=$DEPTH
#git clone https://github.com/odoomrp/odoomrp-wip -b $ODOOVERSION --depth=$DEPTH
#git clone https://github.com/OCA/pos.git -b $ODOOVERSION --depth=$DEPTH
#git clone https://github.com/yelizariev/pos-addons.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/purchase-workflow.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/server-tools.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/account-fiscal-rule.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/bank-statement-import.git -b $ODOOVERSION --depth=$DEPTH
git clone https://github.com/OCA/sale-workflow.git -b $ODOOVERSION --depth=$DEPTH

# Odoo Connector PS Dependencies
git clone https://github.com/OCA/connector.git -b 9.0 --depth=$DEPTH 
git clone https://github.com/OCA/connector-prestashop.git -b 9.0 --depth=$DEPTH 
git clone https://github.com/OCA/connector-ecommerce.git -b 9.0 --depth=$DEPTH 
git clone https://github.com/OCA/e-commerce.git -b 9.0 --depth=$DEPTH 
git clone https://github.com/OCA/product-attribute.git -b 9.0 --depth=$DEPTH
git clone https://github.com/OCA/product-variant.git -b 9.0 --depth=$DEPTH 
git clone https://github.com/OCA/server-tools.git -b 9.0 --depth=$DEPTH

# Install python3 and dependencies for Odoo
sudo apt-get -y install python-pip
sudo pip install qrcode

# Install nodejs and less
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less

# Download & install WKHTMLTOPDF
cd $PATHBASE
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
sed -i '/ldap/d' $PATHBASE"/odoo/requirements.txt"
sed -i '/lxml/d' $PATHBASE"/odoo/requirements.txt"
sudo pip install -r $PATHBASE"/odoo/requirements.txt"


