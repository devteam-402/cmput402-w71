ifeq ($(shell id -u),0)
	$(warning "WARNING: Do not run as root")
	exit 0
endif

DJANGO_CONTAINER := apiserver

DEFAULT_DOCKER_MACHINE_NAME := default

build: DOCKER_COMPOSE_OPTS = $(if $(filter $(CACHE),0),--no-cache,)
build: clean
	docker-compose build $(DOCKER_COMPOSE_OPTS)

clean: stop
	docker-compose rm -v -f

ps:
	docker-compose ps

stop:
	docker-compose stop

logs:
	docker-compose logs

bash-shell:
	docker exec -it $(DJANGO_CONTAINER) bash

manage:
	docker exec -it $(DJANGO_CONTAINER) python manage.py $(ARG)

python-shell:
	make manage ARG=shell

db-shell:
	make manage ARG=dbshell

migrate:
	make manage ARG=migrate

flushdb:
	make manage ARG=flush

test:
	make manage ARG=test

run:
	docker-compose up --no-recreate --abort-on-container-exit || true

env:
	@docker-machine start $(DEFAULT_DOCKER_MACHINE_NAME) || true
	@docker-machine env $(DEFAULT_DOCKER_MACHINE_NAME)

makemigrations:
	docker exec -it $(CONTAINER) python manage.py makemigrations

collectstatic:
	docker exec -it $(CONTAINER) python manage.py collectstatic
