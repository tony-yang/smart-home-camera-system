#!/bin/bash

sleep 15s

while :
do
  camera_process=$(ps aux | grep -v grep | grep mjpg)
  if [ -z "$cameraman_process" ]
  then
    mjpg_streamer -i "/usr/local/lib/input_uvc.so -d /dev/video0 -y" -o "/usr/local/lib/output_http.so -p 9999 -w /usr/local/www" -b
    service apache2 start
  fi
  sleep 60s
done
