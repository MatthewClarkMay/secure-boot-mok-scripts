#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

cd /root/ &&
mkdir .MOK-keys &&
cd .MOK-keys &&

openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=`hostname`.local" &&

chmod 700 MOK.* &&

mokutil --import MOK.der &&

echo "Reboot the machine, and enter your password to complete MOK config"
