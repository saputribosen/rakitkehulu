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
  	echo "Downloading files from repo.."
   	wget -O $MODEL/huawey.lua $URL/cbi_model/huawey.lua
	clear
        sleep 1
 	wget -O $DIR/huawei.py $URL/huawei.py && chmod +x $DIR/huawei.py
        clear
	sleep 1
 	wget -O $DIR/huawei $URL/huawei.sh && chmod +x $DIR/huawei
        clear
	sleep 1
 	wget -O $CONF/huawey $URL/huawey
        clear
        sleep 1
  	wget -O $CON/huawey.lua $URL/controller/huawey.lua && chmod +x $CON/huawey.lua
 		finish
}


echo ""
echo "Install prerequisites."
read -p "Do you want to install prerequisites (y/n)? " yn
case $yn in
    [Yy]* ) install_update;;
    [Nn]* ) echo "Skipping prerequisites installation...";;
    * ) echo "Invalid input. Skipping prerequisites installation...";;
esac

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
