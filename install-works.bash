#!/bin/bash

#mount disk. please make sure Guest additions is inserted
mount --source /dev/sr0 --target /media/cdrom0

#Deinstall stuff that I dont need.
apt-get purge -y -f \
	gnome-games \
	debian-reference-common \
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
	fcitx-* \
	konwert \
	mlterm \
	mlterm-* \
	thunderbird \
	libreoffice*

apt-get autoremove -y -f

#Update and install stuff that I want.
apt-get update

apt-get upgrade -y
apt-get install -y \
	net-tools \
	dnsutils \
	curl \
	wget \
	git \
	chromium \
	firefox-esr \
	build-essential \
	dkms \
	module-assistant \
	linux-headers-$(uname -r)
  
#add user to sudo
echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

#force color in terminal. In ssh it doesnt show color for the user unless this is applied.
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc

#Setting some gnome settings on user. disable automatic suspend, blank screen and also changing it to a dark theme so my eyes dont burn at night.
sudo -Hu user gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop' , 'firefox-esr.desktop','chromium.desktop', 'org.gnome.Nautilus.desktop']"
sudo -Hu user gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
sudo -Hu user gsettings set org.gnome.desktop.session idle-delay 0
sudo -Hu user gsettings set org.gnome.desktop.screensaver lock-enabled false
sudo -Hu user gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

#prepare and install Guest additions.
m-a prepare

cd /media/cdrom0
sh ./VBoxLinuxAdditions.run --nox11

#showing a message that is shown anyway at the end of installing Guest additions but I am stubborn so I need a extra reminder that I need to reboot
echo "Please reboot"
