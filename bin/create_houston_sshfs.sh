#!/usr/bin/env bash
cd ~/Documents
rm -rf houston
mkdir houston
sshfs houston-tun:/home/s1687259 ./houston/
