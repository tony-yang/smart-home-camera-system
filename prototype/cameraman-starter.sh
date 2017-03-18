#!/bin/bash

sleep 15s

while :
do
  cameraman_process=$(ps aux | grep -v grep | grep fswebcam)
  if [ -z "$cameraman_process" ]
  then
    fswebcam -c fswebcam.conf --exec imagerename.sh
  fi
  sleep 15s
done
