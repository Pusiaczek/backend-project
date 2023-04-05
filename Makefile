# dev environment as a default value
ENV := $(if $(ENV),$(ENV),dev)

build:
	$(info Make: Building "$(ENV)" environment)
	docker-compose --env-file=.env -f docker/docker-compose.yml -f docker/docker-compose.$(ENV).yml build

start:
	$(info Make: Starting "$(ENV)" environment)
	docker-compose --env-file=.env -f docker/docker-compose.yml -f docker/docker-compose.$(ENV).yml up -d

stop:
	$(info Make: Stopping "$(ENV)" environment)
	docker-compose --env-file=.env -f docker/docker-compose.yml -f docker/docker-compose.$(ENV).yml down

# test:
# 	$(info Make: Testing)
# 	docker-compose --env-file=.env -f docker/docker-compose.yml -f docker/docker-compose.test.yml up --build --exit-code-from admin

# prune:
# 	$(info Make: Stopping and removing data "$(ENV)" environment)
# 	docker-compose --env-file=.env -f docker/docker-compose.yml -f docker/docker-compose.$(ENV).yml down -v

# restart:
# 	$(info Make: Restarting "$(ENV)" environment)
# 	ENV=$(ENV) make stop
# 	ENV=$(ENV) make start
