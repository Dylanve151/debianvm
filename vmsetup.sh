#!/bin/bash

tempdir=$(mktemp -d)

curl -s https://raw.githubusercontent.com/LostByteSoft/Debian-10/master/remove%20ALL%20deb%2012.0%20excep%20zzz.sh | sed "s/read name/#read name/g" | sed "s/read -n 1/#read -n 1/g" | sed "s/noquit=1/noquit=0/g" > $tempdir/remove-all.sh
curl -s https://raw.githubusercontent.com/LostByteSoft/Debian-10/master/remove%20zzz%20evince.sh | sed "s/read name/#read name/g" | sed "s/read -n 1/#read -n 1/g" | sed "s/noquit=1/noquit=0/g" > $tempdir/remove-evince.sh
curl -s https://raw.githubusercontent.com/LostByteSoft/Debian-10/master/remove%20zzz%20gimp.sh | sed "s/read name/#read name/g" | sed "s/read -n 1/#read -n 1/g" | sed "s/noquit=1/noquit=0/g" > $tempdir/remove-gimp.sh
curl -s https://raw.githubusercontent.com/LostByteSoft/Debian-10/master/remove%20zzz%20libreoffice.sh | sed "s/read name/#read name/g" | sed "s/read -n 1/#read -n 1/g" | sed "s/noquit=1/noquit=0/g" > $tempdir/remove-libreoffice.sh
curl -s https://raw.githubusercontent.com/LostByteSoft/Debian-10/master/remove%20zzz%20rhythmbox.sh | sed "s/read name/#read name/g" | sed "s/read -n 1/#read -n 1/g" | sed "s/noquit=1/noquit=0/g" > $tempdir/remove-rhythmbox.sh

