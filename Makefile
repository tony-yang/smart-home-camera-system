.DEFAULT_GOAL := start

start:
	sudo docker-compose build camerasystem
	sudo docker-compose up -d

stop:
	sudo docker-compose down
