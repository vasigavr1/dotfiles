#!/usr/bin/env bash
cd ~/Documents
rm -rf cloudlab
mkdir cloudlab
sshfs n1:/users/vasigavr ./cloudlab/
