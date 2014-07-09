#!/bin/bash

#	WARNING WARNING WARNING WARNING WARNING
#	This script is NOT finished
#	Use at your own risk
#	It has been barely tested
#	Made by the Unity3D-Wine-Support team
#	https://github.com/Unity3D-Wine-Support
#	Script licence : GPL v.2

#	Add the Wine ppa and enable source
sudo add-apt-repository -s -y ppa:ubuntu-wine/ppa
#	Enable the source ppa (not needed anymore)
#	sudo sed -i '/ deb-src /s/^# //' /etc/apt/source.list.d/ubuntu-wine-ppa-trusty.list

#	Update packages
sudo apt-get update

#	Install dependencies
sudo apt-get install -y wget git g++ gcc-multilib g++-multilib

#	Install build dependencies 
sudo apt-get build-dep -y wine1.7

#	Install build dependencies with official script if previous command failed
cd

if [ -f ./install-wine-deps.sh ]
then
	rm ./install-wine-deps.sh
fi

wget http://winezeug.googlecode.com/svn/trunk/install-wine-deps.sh
chmod +x ./install-wine-deps.sh
sudo ./install-wine-deps.sh

#	Add 2 symlinks (these symlinks are usually already there, but just to be sure)
cd /usr/lib/i386-linux-gnu
sudo ln -s libfreetype.so.6 libfreetype.so
sudo ln -s libOSMesa.so.6 libOSMesa.so

#	Clone the Wine GitHub repo with the source code
git clone git://source.winehq.org/git/wine.git ~/wine-git
cd ~/wine-git
#	Checkout to specific version
#	You may want to change the version (the newest one usually works best)
#	You may also comment out this line if you want the newest git wine(may cause problems)
git checkout wine-1.7.21

#	Download and apply the patch we are doing all this for
wget https://raw.githubusercontent.com/Unity3D-Wine-Support/Unity3D-on-Wine/master/Compile-Wine/WGL-ShareList-Hack.patch
cat ./WGL-ShareList-Hack.patch | patch -p1

#	Congfigure the patched Wine
./configure
#	And actually start the build
make
#	havent't tried this yet:
# make install
#	I have no idea what it will do. It might even break your system. Use at your own risk.

#	Now you should have a working (although enormous) patched Wine in your home directory
#	Mine has a whopping 1.2 GB
#	This Wine should be able to launch the Unity3D Editor or any Unity game in OpenGL mode
#	This makes the rendering MUCH faster.
#	To launch Unity with OpenGL rendering, add a -force-opengl argument at the end.
#	You can also edit the desktop file

#	HOWEVER YOU MUST USE ~/wine-git/wine INSTEAD OF wine OR IT WON'T WORK

#	Remember, half of the stuff in this script might not work.
#	You can always make a pull request if you've got something better.
