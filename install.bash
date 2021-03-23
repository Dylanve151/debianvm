#!/bin/bash

#Deinstall stuff that I dont need
apt-get purge -y -f \
	gnome-games \
	debian-reference-common \
	firefox-esr \
	evolution \
	mozc-* \
	anthy \
	anthy-* \
	khmerconverter \
	xiterm+thai \
	myspell-* \
	libhdate1 \
	goldendict \
	fcitx \
	fcitx-*
	konwert \
	
apt-get autoremove -y -f

#Update and install stuff that I want (yes, I like chromium)
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

#add user to sudo
echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

#prepare and install Guest additions
m-a prepare

cd /media/cdrom
sh ./VBoxLinuxAdditions.run --nox11

#Setting some gnome settings on user
sudo -Hu user gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop' ,'chromium.desktop', 'org.gnome.Nautilus.desktop']"
sudo -Hu user gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
sudo -Hu user gsettings set org.gnome.desktop.session idle-delay 0
sudo -Hu user gsettings set org.gnome.desktop.screensaver lock-enabled false
sudo -Hu user gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

echo "Please reboot"

