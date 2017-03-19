FROM ubuntu
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential tcl openssh-client vim python3 python3-pip && \
  apt-get install -y apache2 libjpeg8-dev imagemagick libv4l-dev && \
  pip3 install --upgrade pip setuptools && \
  ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /root

ADD . /root/

COPY conf/ports.conf /etc/apache2/ports.conf
COPY conf/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN \
  a2enmod proxy && a2enmod proxy_http && a2enmod ssl && \
  a2ensite default-ssl && \
  mkdir /root/ssl && \
  openssl req -newkey rsa:2048 -nodes -keyout /root/ssl/ystpublic.camera.key -x509 -days 365 -out /root/ssl/ystpublic.camera.crt -subj "/C=CA/ST=Ontario/L=Toronto/O=ystpublic/CN=ystpublic" && \
  service apache2 restart

EXPOSE 9000
