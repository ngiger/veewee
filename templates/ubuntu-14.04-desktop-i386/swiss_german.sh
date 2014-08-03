#!/bin/bash

sudo apt-get install --yes locales-all
sudo update-locale LANG=de_CH.UTF-8 LANGUAGE=de_CH
sudo loadkeys ch

cat <<EOF > /etc/default/keyboard 
# KEYBOARD CONFIGURATION FILE
# Consult the keyboard(5) manual page.
XKBMODEL="pc105"
XKBLAYOUT="ch"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
EOF

