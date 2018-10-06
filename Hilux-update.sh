#!/bin/bash

COIN_PATH='/usr/bin/'
COIN_TGZ='https://github.com/swatchie-1/hilux/releases/download/v1.0.1/hilux-masternode.tar.gz'
COIN_ZIP=$(echo $COIN_TGZ | awk -F'/' '{print $NF}')

#!/bin/bash
# Hilux Update Script
# (c) 2018 by ETS5 for Hilux Coin 
#
# Usage:
# bash Hilux-update.sh 
#

#Color codes
RED='\033[0;91m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color



#Delay script execution for N seconds
function delay { echo -e "${GREEN}Sleep for $1 seconds...${NC}"; sleep "$1"; }

echo -e "${YELLOW}Hilux Update Script v0.1${NC}"

#KILL THE MFER
echo -e "${YELLOW}Killing deamon...${NC}"
    hulix-cli stop
    pkill hilux
    delay 20

#Delete .hiluxcore contents 
echo -e "${YELLOW}Scrapping .hiluxcore...${NC}"
cd 
cd ~/.hilux
rm -rf c* b* w* p* n* m* f* d* g*

#Delete OLD Binary
echo -e "${YELLOW}Deleting v1.3...${NC}"
cd ~
sudo rm -rf ~/hilux
sudo rm -rf ~/usr/bin/hilux*

#Install new Binaries
echo -e "${YELLOW}Installing v1.0.1...${NC}"
cd ~
mkdir hilux
wget $COIN_TGZ
tar xzf $COIN_ZIP >/dev/null 2>&1 
rm -r $COIN_ZIP >/dev/null 2>&1

sudo cp ~/hilux/hilux* $COIN_PATH
sudo chmod 755 -R ~/hilux
sudo chmod 755 /usr/bin/hilux*

#Restarting Daemon
echo -e "${YELLOW}Restarting Daemon...${NC}"
    hiluxd -daemon
echo -ne '[##                 ] (15%)\r'
sleep 6
echo -ne '[######             ] (30%)\r'
sleep 6
echo -ne '[########           ] (45%)\r'
sleep 6
echo -ne '[##############     ] (72%)\r'
sleep 10
echo -ne '[###################] (100%)\r'
echo -ne '\n'

echo -e "${GREEN}Your masternode is now up to date${NC}"
echo '==========================================================================='
echo 'Masternode Information:' && hilux-cli getinfo
echo '==========================================================================='
echo 'Masternode Status:' && hilux-cli masternode status
echo '==========================================================================='
# EOF
