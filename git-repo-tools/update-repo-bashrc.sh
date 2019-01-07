YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

switch_to_master()
{
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    if [ ! "$BRANCH" = "master" ];
    then
        CHANGES=`git status -s | wc -l`
        if [ ! $CHANGES = 0 ];
        then
            echo -e "${YELLOW}==> Stash $BRANCH${NC}"
            git stash
        fi
        echo -e "${YELLOW}==> Switch from $BRANCH to master${NC}"
        git checkout master
    fi
}

switch_back()
{
    if [ ! "$BRANCH" = "master" ];
    then
        echo -e "${YELLOW}==> Switch from master to $BRANCH${NC}"
        git checkout $BRANCH
        if [ ! "$CHANGES" = "0" ];
        then
            echo -e "${YELLOW}==> Restore stash on $BRANCH${NC}"
            git stash pop
        fi
    fi
}

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
        switch_to_master
        git pull
        switch_back
        cd ..
    done
    cd $cur
}
