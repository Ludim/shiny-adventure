#!/bin/bash
##### Description: Update Native Postman on Ubuntu
#### Written by: Ludim Salo on Jun-2018
#### Inspired: https://calliditasblog.wordpress.com/author/calliditasblog/
####           https://gist.github.com/aviskase/e642248c35e400b56e2489430952369f

POSTMAN_FOLDER='postman-linux.tar.gz'

if [ ! -d "Postman" ]; then
    echo "Download Postman"
    wget -O $POSTMAN_FOLDER https://dl.pstmn.io/download/latest/linux64
fi

if [ -f $POSTMAN_FOLDER ]; then
    echo "Extract Postman"
    tar -xzf $POSTMAN_FOLDER
    rm $POSTMAN_FOLDER
fi

if [ -d "/opt/Postman" ]; then
    echo "Installing to opt"
    sudo rm -rf /opt/Postman
    sudo mv Postman /opt/
fi

ICON_LOCATION=`find /opt/Postman -name 'icon.png' 2>/dev/null`
echo "Update icon location, path" $ICON_LOCATION

if [ -z "$ICON_LOCATION" ]; then
    echo "Icon cannot be found"
    echo "Try to create icon lauch"
    exit 1
fi

if [ ! -f '~/.local/share/applications' ]; then
    mkdir -p ~/.local/share/applications
fi

cat > ~/.local/share/applications/postman.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=$ICON_LOCATION
Terminal=false
Type=Application
Categories=Development;
EOF
