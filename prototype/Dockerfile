FROM ubuntu
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential tcl openssh-client vim git python3 && \
  apt-get install -y fswebcam && \
  apt-get install -y libjpeg8-dev imagemagick libv4l-dev && \
  ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /root

ADD . /root/

EXPOSE 9000
