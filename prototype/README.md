# fswebcam
This tool takes still image. It allows loop up to 1 second per image and can run in the background. Can't figure out how to take subsecond images using the tool itself. Perhaps we can use a python script to call the tool repeatedly but there will be overhead in starting the tool.

```
fswebcam -r 800x600 -d /dev/video2 --jpeg 85 -F 3 /tmp/cam/last.jpg --exec ./imagerename.sh
-r size of output
-d device name
--jpeg compression rate
-F number of frames to capture and combine for an image
--exec a shell script to execute after each capture, such as rename or move the file
```

# mjpg streamer
This one acts as a streamer to push jpeg images taken from other webcam devices or from the direct input_uvc plugin to the network. This tool embeds the image capturing and streaming function together and is very easy to setup and use. However, it is suggested that this tool (or the default implementation of HTTP streaming) is insecure and should not be directly exposed to the open internet. Though I found there is a -c flag for the http output plugin to allow credential. If used in a Docker container, it needs to have the port exposed.

```
mjpg_streamer -i "/usr/local/lib/input_uvc.so -d /dev/video2 -y" -o "/usr/local/lib/output_http.so -p 9000 -w /usr/local/www -c username:password"
-i input plugin to use. We use the input_uvc.so plugin to capture image directly
-d device name
-y use the yuv format instead of the mjpeg format (webcam may not support it)
-o output plugin to use. We use the output_http.so to stream image over the HTTP
-p the HTTP port for streaming
-w the root of the web directory for the HTTP streaming tool
-c user credential
```

# ffmpeg
This one is big, around 200 MB. It is really more than just taking a picture. It offers video capturing and we can grab frames from the video. So this allows multiple frames to be saved within a second. In this case, we can construct a smoother image feed.
```
ffmpeg -f video4linux2 -s 800x600 -i /dev/video2 -ss 0:0:1 -r 1 -frames 100 /tmp/cam/image-%03d.jpg
-f the format
-s size of output
-i device name
-ss offset before capture to let camera warm up
-r the capture rate in Hz, so inverse relationship. Higher Hz = smaller capture interval. 1Hz = 1 second. 10 Hz = 0.1 second
-frames number of frames to capture before exit
/tmp/cam/image-%03d.jpg output file pattern, %03d = 3 digit integer file name
```

# libav-tools (avconv)
Even bigger than ffmpeg, and it seems they share many of the same library. Again, this is a multimedia tool not just for image capture.
