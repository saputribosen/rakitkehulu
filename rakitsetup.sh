#!/bin/ash
# Installation script by ARYO.

DIR=/usr/bin
CONF=/etc/config
MODEL=/usr/lib/lua/luci/model/cbi
CON=/usr/lib/lua/luci/controller
URL=https://raw.githubusercontent.com/saputribosen/rakitkehulu/main



finish(){
clear
    echo ""
    echo ""
    echo "INSTALL RAKITAN MONITOR SUCCESSFULLY ;)"
    echo ""
    sleep 5
    clear
    echo "Youtube : ARYO BROKOLLY"
    echo ""
    echo ""
}

download_files()
{
    	clear
  	echo "Downloading file rakitan monitor from repo.."
   	wget -O $MODEL/rakitan.lua $URL/model/rakitan.lua
	clear
	sleep 1
 	wget -O $DIR/rakitan $URL/rakitan.sh && chmod +x $DIR/rakitan
        clear
	sleep 1
 	wget -O $CONF/rakitanconf $URL/rakitanconf
        clear
        sleep 1
  	wget -O $CON/rakitan.lua $URL/controller/rakitan.lua && chmod +x $CON/rakitan.lua
        sleep 2
 	finish
}


echo ""
echo ""
echo "Install Script code from repo aryo."

while true; do
    read -p "This will download the files. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) download_files; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done
