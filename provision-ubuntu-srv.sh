#!/usr/bin/env bash

function error_exit()
{
    if [ $1 -ne 0 ];
    then
        echo -e $2
        exit -1
    fi
}

LOG_FILE=/tmp/provision-ubuntu-server-$(date +%Y-%m-%d-%H-%M-%S).log

CYAN="\033[0;36m"
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m" # No Color

function print_start_install()
{
    echo -e "${CYAN}-> Installing $1${NC} ..."
}

function print_done_install()
{
    echo -e "${GREEN}-> Succeeded to install $1${NC}"
}

function install_pkg()
{
    print_start_install $1
    apt-get --assume-yes --fix-missing install $1 # >> $LOG_FILE 2>&1
    error_exit $? "${RED}-> Failed to install $1${NC}"
    print_done_install $1
}

function install_google_chrome()
{
    print_start_install "google chrome"
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    apt-get update
    apt-get --assume-yes --fix-missing install google-chrome-stable
    error_exit $? "${RED}-> Failed to install google chrome${NC}"
    print_done_install "google chrome"
}

function update_mongo_conf()
{
    MONGOD_CONF="/etc/mongod.conf"
    NEW_CONF=${MONGOD_CONF}.new
    BAK_CONF=${MONGOD_CONF}.bak

    sed 's/bindIp:.*$/bindIp: 0.0.0.0/g' < ${MONGOD_CONF} > ${NEW_CONF}
    mv ${MONGOD_CONF} ${BAK_CONF}.$(date +%Y%m%d-%H-%M-%S)
    mv ${NEW_CONF} ${MONGOD_CONF}
    service mongod start
    systemctl enable mongod.service
    python3 -m pip install pymongo
}

function install_mongo_db()
{
    print_start_install "mongo db"
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
    echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
    apt-get update
    apt-get --assume-yes --fix-missing install -y mongodb-org
    update_mongo_conf
    print_done_install "mongo db"
}

function install_mqtt()
{
    print_start_install "mosquitto (mqtt)"
    apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
    apt-get update
    apt-get --assume-yes --fix-missing install mosquitto mosquitto-clients mosquitto-auth-plugin mosquitto-dbg mosquitto-dev
    systemctl enable mosquitto.service
    wget -O ${HOME}/Downloads/mqtt-spy-1.0.0.jar https://github.com/eclipse/paho.mqtt-spy/releases/download/1.0.0/mqtt-spy-1.0.0.jar
    print_done_install "mosquitto (mqtt)"
}

function download_anaconda()
{
    echo -e "${CYAN}-> Downloading anaconda${NC}"
    wget -O ${HOME}/Downloads/Anaconda3-4.4.0-Linux-x86_64.sh https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
	chown ${USER}:${USER} ~/Dowanloads/Anaconda3-4.4.0-Linux-x86_64.sh
    echo -e "${GREEN}-> Dowanload done: anaconda${NC}"
}

function download_pycharm()
{
    echo -e "${CYAN}-> Downloading pycharm${NC}"
    wget -O ${HOME}/Downloads/pycharm-community-2017.2.tar.gz https://download.jetbrains.com/python/pycharm-community-2017.2.tar.gz
	chown ${USER}:${USER} ~/Downloads/Anaconda3-4.4.0-Linux-x86_64.sh
    echo -e "${GREEN}-> Dowanload done: pycharm${NC}"
}


PKGS="lxde git gitk meld emacs24 g++ gcc cmake zsh octave vim-gnome vsftpd haskell-platform"

for P in $PKGS
do
    install_pkg "$P"
done

mkdir ${HOME}/Downloads

install_google_chrome
install_mongo_db
install_mqtt
chown ${USER}:${USER} ${HOME}/Downloads
download_anaconda
download_pycharm

systemctl set-default multi-user.target
