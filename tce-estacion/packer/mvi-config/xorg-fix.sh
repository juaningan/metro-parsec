#!/bin/sh

# Increase base size
TSIZE=`echo $MRSIZE | sed s:M::`
TSIZE=$(($TSIZE+70))
MRSIZE=${TSIZE}M

cat > etc/X11/xorg.conf <<EOF
Section "Files"
    FontPath "/usr/share/fonts/X11/misc"
    FontPath "/usr/share/fonts/X11/misc-ISO8859-1"
    FontPath "/usr/share/fonts/X11/75dpi"
    FontPath "/usr/share/fonts/X11/75dpi-ISO8859-1"
    FontPath "/usr/share/fonts/X11/100dpi"
    FontPath "/usr/share/fonts/X11/100dpi-ISO8859-1"
EndSection

Section "InputDevice"
    Identifier  "Keyboard1"
    Driver      "Keyboard"
    Option "AutoRepeat" "500 30"
    Option "XkbRules"   "xorg"
    Option "XkbModel"   "pc105"
    Option "XkbLayout"  "es"
    Option "Device"     "/dev/kbd"
EndSection

Section "InputDevice"
    Identifier  "Mouse1"
    Driver      "mouse"
    #Option "Protocol"    "ImPS/2"
    Option "Protocol"    "VUID"
    Option "Device"      "/dev/mouse"
EndSection

Section "Monitor"
    Identifier  "Monitor1"
    HorizSync   31.5 - 60
    VertRefresh 50 - 70
EndSection

Section "Device"
    Identifier  "intel"
    Driver      "vesa"
EndSection

Section "Screen"
    Identifier  "Screen 1"
    Device      "intel"
    Monitor     "Monitor1"
    DefaultDepth 24 
    Subsection "Display"
        Depth       24
        Modes       "1024x768"
        ViewPort    0 0
    EndSubsection
EndSection

Section "ServerLayout"
    Identifier  "Simple Layout"
    Screen      "Screen 1"
    InputDevice "Mouse1"         "CorePointer"
    InputDevice "Keyboard1"      "CoreKeyboard"
    Option      "AutoAddDevices" "Off"
EndSection
EOF
