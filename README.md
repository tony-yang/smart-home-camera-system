# Smart Home Camera System

A simple and inexpensive home camera security system. It uses existing commodity components to build an online image streaming application, which allows users to see live (motion) images of the monitored area. This system takes no more than a Linux (Ubuntu) system and a regular webcam.


## User Guide (Run under the Production environment)
At the project root, run `make start`. This will start a docker container with all the required device mapped into the container. We assume the webcam is mount on `/dev/video0`.

The container will build and start all the necessary dependency tools. Run the following steps before using the system:
- Create a new MySQL root password
- Create a MySQL database for the system
```
create database cameraweb_production;
grant all privileges on cameraweb_production.* to 'cameraweb'@'localhost' identified by '<some password>';
```
- Add the password to the environment variable for MySQL `export CAMERAWEB_DATABASE_PASSWORD=<some password>`
- Go to `cameraweb` and run `bundle install`
- Run the db migration `rails db:migrate RAILS_ENV="production"`
- Add an admin user to the database through the Rails console `rails c production` for the prod environment
- Add the path to the SSL private key and SSL certificate `export SSL_KEY_PATH=<path to private key>` and `export SSL_CERT_PATH=<path to SSL certificate>`

Start the server with a new secret and profit! `export SECRET_KEY_BASE=$(rails secret) && puma -e production` and restart the apache server


## Dev Guide
At the project root, run `make start`. This will start a docker container with all the required device mapped into the container. We assume the webcam is mount on `/dev/video0`.

The container will build and start all the necessary dependency tools. Add the following before using the system:
- Create a new MySQL root password
- Create a MySQL database for the system
```
create database cameraweb_development;
grant all privileges on cameraweb_development.* to 'cameraweb'@'localhost' identified by '<some password>';
```
- Add the password to the environment variable for MySQL `export CAMERAWEB_DATABASE_PASSWORD=<some password>`
- Go to `cameraweb` and run `bundle install`
- Run the db migration `rails db:migrate`
- Add an admin user to the database through the Rails console `rails c` for the dev environment
- Add the path to the SSL private key and SSL certificate `export SSL_KEY_PATH=<path to private key>` and `export SSL_CERT_PATH=<path to SSL certificate>`

Start the dev server and profit! `rails server -b 'ssl://127.0.0.1:3000?key='$SSL_KEY_PATH'&cert='$SSL_CERT_PATH` and restart the apache server


## Reference Links
http://www.netinstructions.com/automating-picture-capture-using-webcams-on-linuxubuntu/
http://man.cx/fswebcam(1)
http://martin-denizet.com/timelapse-movie-with-raspberry-pi/
https://blog.miguelgrinberg.com/post/how-to-build-and-run-mjpg-streamer-on-the-raspberry-pi
http://www.linuxcircle.com/2013/02/06/faster-video-streaming-on-raspberry-media-server-with-mjpg-streamer/
http://dirisala.net/blog/2013/08/securing-mjpg-streamer/
