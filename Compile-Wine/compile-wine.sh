#!/bin/bash

#	WARNING WARNING WARNING WARNING WARNING
#	This script is NOT finished
#	Use at your own risk
#	It has been barely tested
#	Made by the Unity3D-Wine-Support team
#	https://github.com/Unity3D-Wine-Support
#	Script licence : GPL v.2

#	Add the Wine ppa
sudo add-apt-repository -s -y ppa:ubuntu-wine/ppa
#	Enable the source ppa (not needed anymore)
#	sudo sed -i '/ deb-src /s/^# //' /etc/apt/source.list.d/ubuntu-wine-ppa-trusty.list

#	Update packages
sudo apt-get update

#	Install dependencies (I have now idea what most of these packages are for
sudo apt-get -y install git g++ gcc-multilib g++-multilib libc6-dev-i386 lib32z1-dev lib32bz2-dev xserver-xorg-dev:i386 libfreetype6-dev:i386 libmirclient-dev:i386 libosmesa6:i386 libosmesa-dev libjpeg-turbo8-dev:i386 libgl1-mesa-dev:i386 libglu1-mesa-dev:i386 libxcursor-dev:i386 libxi-dev:i386 libxrandr-dev:i386 libxinerama-dev:i386 libxcomposite-dev:i386 libdbus-1-dev:i386 libgnutls-dev:i386 libncurses5-dev:i386 libsane-dev:i386 libv4l-dev:i386 libgphoto2-6-dev:i386 liblcms2-dev:i386 liblcms1-dev:i386 gstreamer0.10-plugins-base:i386 libcapi20-dev:i386 libcups2-dev:i386 libfontconfig1-dev:i386 libgsm1-dev:i386 libtiff5-dev:i386 libmpg123-dev:i386 libopenal-dev:i386 libxrender-dev:i386 libxml2-dev:i386 libxslt1-dev:i386 libpng12-dev:i386 libssl-dev:i386 libldap2-dev:i386 unixodbc-dev:i386

#	Build dependencies (again?)
sudo apt-get -y build-dep wine1.7

#	Add 2 symlinks (I think this prevents a crash)
cd /usr/lib/i386-linux-gnu
sudo ln -s libfreetype.so.6 libfreetype.so
sudo ln -s libOSMesa.so.6 libOSMesa.so

#	Clone the Wine GitHub repo with the source code
git clone git://source.winehq.org/git/wine.git ~/wine-git
cd ~/wine-git

#	Download and apply the patch we are doing all this for
wget https://raw.githubusercontent.com/Unity3D-Wine-Support/Unity3D-on-Wine/master/Compile-Wine/WGL-ShareList-Hack.patch
cat ./WGL-ShareList-Hack.patch | patch -p1

#	Congfigure the patched Wine
./configure
#	And actually start the build
make

#	Now you should have a working (although enormous) patched Wine in your home directory
#	Mine has a whopping 1.2 GB
#	This Wine should be able to launch the Unity3D Editor or any Unity game in OpenGL mode
#	This makes the rendering MUCH faster.
#	To launch Unity with OpenGL rendering, add a -force-opengl argument at the end.
#	You can also edit the desktop file

#	HOWEVER YOU MUST USE ~/wine-git/wine INSTEAD OF wine OR IT WON'T WORK

#	Remember, half of the stuff in this script might not work.
#	You can always make a pull request if you've got something better.
