.PHONY: build up down restart test shell
build:
	docker-compose build
up:
	docker-compose up -d
restart:
	docker-compose restart
shell:
	docker-compose exec bot bash
down:
	docker-compose down
test:
	docker-compose exec bot dart test
