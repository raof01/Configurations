#!/usr/bin/env bash

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

update_repo()
{
    cur=$(pwd)
    cd $1
    for d in $(ls)
    do
        if [ ! -d $d ];
        then
            continue
        fi
        cd $d
        echo -e "${GREEN}=> Updating $(basename $d) ...${NC}"
        git pull
        cd ..
    done
    cd $cur
}

update_repo /home/frao/workspace/code-repos
/opt/opengrok/bin/OpenGrok index >/dev/null 2>&1
