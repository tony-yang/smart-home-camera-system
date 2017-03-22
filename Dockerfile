FROM ubuntu
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential tcl openssh-client vim

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y ruby ruby-dev ruby-bundler zlib1g-dev liblzma-dev nodejs mysql-server libmysqlclient-dev && \
  apt-get install -y apache2 libjpeg8-dev imagemagick libv4l-dev && \
  gem install rails


WORKDIR /root

ADD . /root/

COPY conf/ports.conf /etc/apache2/ports.conf
COPY conf/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN \
  a2enmod proxy && a2enmod proxy_http && a2enmod ssl && \
  a2ensite default-ssl && \
  mkdir /root/ssl && \
  openssl req -newkey rsa:2048 -nodes -keyout /root/ssl/ystpublic.camera.key -x509 -days 365 -out /root/ssl/ystpublic.camera.crt -subj "/C=CA/ST=Ontario/L=Toronto/O=ystpublic/CN=ystpublic" && \
  cd mjpg-streamer/mjpg-streamer && make USE_LIBV4L2=true clean install

EXPOSE 9000
EXPOSE 9999

CMD ["/root/camera-starter.sh"]
