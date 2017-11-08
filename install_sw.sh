################################################################################
# VARIABLES
################################################################################
export CYAN="\033[0;36m"
export RED="\033[0;31m"
export GREEN="\033[0;32m"
export NC="\033[0m" # No Color

export PY3=python3
export PY_PIP3=python3-pip
export PIP3=pip3
export PY3_VENV=python3-venv

export VENV_COMMON_NAME=${HOME}/dog-walk-srv
export FLASK_CMD="flask run"
export VENV_DIR_PREFIX=${HOME}/dog-walk-srv

export MONGO_ENV=mongo-env
export SERVER_ENV=server-env
export CONF=conf

export FLASK=${HOME}/.local/bin/flask

export SRV_PID_FILE=/tmp/dog-walk-srv-pid

################################################################################
# FUNCTIONS
################################################################################
function get_flask_pid()
{
    if [ ! $(ps -ef | grep -v grep | grep -c "$FLASK_CMD") -eq "0" ];
    then
        echo $(ps -ef | grep -v grep | grep "$FLASK_CMD" | awk '{print $2}')
    else
        echo "0"
    fi
}

function save_server_pid()
{
    echo $1 > ${SRV_PID_FILE}
}

function retrieve_server_pid()
{
    if [ -f ${SRV_PID_FILE} ]; then
        cat ${SRV_PID_FILE}
    else
        echo "0"
    fi
}

function error_exit()
{
    if [ $1 -ne 0 ];
    then
        echo -e $2
        exit -1
    fi
}

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
