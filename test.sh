#!/bin/sh

echo haha;

# is need to delete the webapps/war
isDeleteWar=false

# init the args config
while getopts d opt 
do
  case "$opt" in
  d)
    isDeleteWar=true
  \?)  
    echo "Invalid option: -$OPTARG"   
    ;;
  esac
done

echo $isDeleteWar