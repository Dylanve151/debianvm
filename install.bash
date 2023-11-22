#!/bin/bash

if [ $(whoami) == 'root' ]
then
	#mount disk. please make sure Guest additions is inserted
	if [ ! -f "/media/cdrom0/VBoxLinuxAdditions.run" ]
	then
		umount /media/cdrom0 > /dev/null 2>&1
		mount -o ro --source /dev/sr0 --target /media/cdrom0
		if [ ! -f "/media/cdrom0/VBoxLinuxAdditions.run" ]
		then
			umount /media/cdrom0 > /dev/null 2>&1
			echo "Please mount Guest additions!"
			exit 1
		fi
	fi


	#Deinstall stuff that I dont need.
	apt-get remove -y -f \
		gnome-games \
		gnome-weather \
		gnome-sound-recorder \
		gnome-todo \
		gnome-todo-common \
		gnome-video-effects \
		gnome-maps \
		gnome-music \
		gnome-documents \
		gnome-contacts \
		gnome-calendar \
		gnome-clocks \
		gnome-screenshot \
		gnome-characters \
		gnome-font-viewer \
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
		fcitx5 \
		fcitx5-* \
		transmission-common \
		xterm \
		synaptic \
		libreoffice* \
		hspell \
		hunspell \
		hunspell-* \
		aspell \
		cheese \
		shotwell \
		shotwell-common \
		rhythmbox \
		rhythmbox-* \
		totem \
		totem-* \
		evince \
		evince-* \
		eog \
		yelp \
		yelp-* \
		system-config-printer \
		system-config-printer-* \
		malcontent \
		malcontent-* \
		thunderbird

	apt-get autoremove -y -f

	#Update and install stuff that I want.
	apt-get update

	apt-get upgrade -y

	apt-get install -y \
		openssh-server \
		net-tools \
		dnsutils \
		curl \
		wget \
		git \
		nano \
		firefox-esr \
		build-essential \
		dkms \
		module-assistant \
		linux-headers-$(uname -r)
		
	#if user "user" doesnt exist create user
	userexist=$(grep -c '^user:' /etc/passwd)
	if [ $userexist == 0 ]
	then
		useradd user
	fi

	#add user to sudo
	echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	
	#set autologin
	sed -i 's/#AutomaticLoginEnable = true/AutomaticLoginEnable = true/g' /etc/gdm3/deamon.conf
	sed -i 's/#AutomaticLogin = user1/AutomaticLogin = user/g' /etc/gdm3/deamon.conf
	
	#force color in terminal. In ssh it doesnt show color for the user unless this is applied.
	sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' /home/user/.bashrc

	#Setting some gnome settings on user. disable automatic suspend, blank screen and also changing it to a dark theme so my eyes dont burn at night.
	if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
	  while read -r sessionId; do
	    grepVarMatch=$(grep -z "^DBUS_SESSION_BUS_ADDRESS=" /proc/$sessionId/environ)
	    if [[ "$grepVarMatch" != "" ]]; then
	      export DBUS_SESSION_BUS_ADDRESS="${grepVarMatch#*=}"
	    fi
	  done <<< "$(pgrep "gnome-session" -u "user")"
	fi
	runuser -u user gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop' , 'firefox-esr.desktop', 'org.gnome.Nautilus.desktop']"
	runuser -u user gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
	runuser -u user gsettings set org.gnome.desktop.session idle-delay 0
	runuser -u user gsettings set org.gnome.desktop.screensaver lock-enabled false
	runuser -u user gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

	#prepare and install Guest additions.
	m-a prepare

	cd /media/cdrom0
	sh ./VBoxLinuxAdditions.run --nox11

	#showing a message that is shown anyway at the end of installing Guest additions but I am stubborn so I need a extra reminder that I need to reboot
	echo "Please reboot"
else
	echo "Please run as root"
fi
