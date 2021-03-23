#!/bin/bash

apt-get purge -y -f \
	gnome-games \
	debian-reference-common \
	firefox-esr \
	xiterm+thai
	
apt-get autoremove -y -f

apt-get update

apt-get upgrade -y

apt-get install -y \
	net-tools \
	curl \
	wget \
	git \
	chromium \
	build-essential \
	dkms \
	module-assistant \
	linux-headers-$(uname -r)
	
echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

m-a prepare

cd /media/cdrom
sh ./VBoxLinuxAdditions.run --nox11

echo "Please reboot"
