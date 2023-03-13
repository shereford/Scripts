#!/bin/bash

wget https://repo.protonvpn.com/fedora-36-stable/release-packages/protonvpn-stable-release-1.0.1-1.noarch.rpm

rpm -i protonvpn-stable-release-1.0.1-1.noarch.rpm

dnf update -y

dnf install protonvpn -y

dnf install python3-pip -y

pip3 install --user 'dnspython>=1.16.0'

dnf install libappindicator-gtk3 gnome-tweaks gnome-shell-extension-appindicator -y

dnf install gnome-extensions-app -y


