#!/bin/sh

# author : mingjian_hou
# desc : shut down the tomcat, clear the cache and startup it, please put this script in /tomcat/bin/

# DEFINE
tomcat_name="tomcat";
war_name="xxxxx"

# get tomcat pid and judge should shutdown or not
tomcat_id=$(ps -aux | grep -w .*"$tomcat_name".*Bootstrap.* | grep -v 'grep' | awk '{print $2}')

if [ ! -n "$tomcat_id" ]; then
    echo "===== not found tomcat's pid, tomcat already close complete ====="
else 
    # run shut down 
    ./shutdown.sh
    echo "===== closing the tomcat, waiting ... ====="
    sleep 3
    
    # recheck the tomcat pid exist or not
    tomcat_id=$(ps -aux | grep -w .*"$tomcat_name".*Bootstrap.* | grep -v 'grep' | awk '{print $2}')
    if [ -n "$tomcat_id" ]; then 
        echo "===== found tomcat's pid:"$tomcat_id", kill it.. ======"
        kill -9 $tomcat_id
    fi
fi

# remove the tomcat cache
rm -rf ../webapps/$war_name
rm -rf ../work/Catalina/*
rm -rf ../temp/*
# restart tomcat
./startup.sh

# tail the log
tail -f ../logs/catalina.out
