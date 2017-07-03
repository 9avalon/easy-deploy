#!/bin/sh

# author : mingjian_hou
# desc : shut down the tomcat, clear the cache and startup it, please put this script in /tomcat/bin/
# args : 
#        -s : save(not delete) the webapps/xxx(unzip war) when run this script.

# DEFINE
tomcat_name="tomcat";
war_name="xxxxx"

# THE ARGS
isDeleteUnzipWar=true

# INIT ARGS, DEAL THE -s ARGS
while getopts s opt
do 
    case "$opt" in
    s)
        isDeleteUnzipWar=false
    ;;
    \?)
        echo "Invalid option: -$OPTARG"
        exit
    ;;
    esac
done

# get tomcat pid and judge should shutdown or not
tomcat_id=$(ps -aux | grep -w .*"$tomcat_name".*Bootstrap.* | grep -v 'grep' | awk '{print $2}')

if [ ! -n "$tomcat_id" ]; then
    echo "===== not found tomcat's pid, tomcat already close complete ====="
else 
    # run shut down 
    ./shutdown.sh
    echo "===== closing the tomcat, waiting ... ====="
    sleep 6
    
    # recheck the tomcat pid exist or not
    tomcat_id=$(ps -aux | grep -w .*"$tomcat_name".*Bootstrap.* | grep -v 'grep' | awk '{print $2}')
    if [ -n "$tomcat_id" ]; then 
        echo "===== found tomcat's pid:"$tomcat_id", kill it.. ======"
        kill -9 $tomcat_id
    fi
fi

# remove the tomcat cache
if [ $isDeleteUnzipWar = true ]; then
    rm -rf ../webapps/$war_name
    echo "===== delete the unzip war file ====="
    sleep 1
fi
rm -rf ../work/Catalina/*
rm -rf ../conf/Catalina/*
rm -rf ../temp/*
# restart tomcat
./startup.sh

# tail the log
cur_date=$(date +%F)
# tail -f ../logs/catalina.out
tail -f ../logs/catalina.out.${cur_date}
