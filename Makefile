-include .env

PROJECTNAME?=$(shell basename "$(PWD)")

GOBIN?="$(shell which go)"
SH="$(shell which sh)"
DOCKER_COMPOSE_BIN="$(shell which docker-compose)"

# Go related variables.
GOBASE="$(shell pwd)"
GOBUILD="$(GOBASE)/builds"
VERSION?="development"

default:
	@echo "See in Makefile"

## Build server application
build-server: server
	@echo "Build application: server"
	$(GOBIN) \
		build \
		-ldflags="-s -w -X 'main.BuildVersion=$(VERSION)'" \
		-o $(GOBUILD)/server \
		$(PROJECTNAME)/$^

dev-start:
	@$(DOCKER_COMPOSE_BIN) \
		-p "$(PROJECTNAME)" \
		up -d

dev-stop:
	@$(DOCKER_COMPOSE_BIN) \
		-p "$(PROJECTNAME)" \
		down --remove-orphans

dev-restart: dev-stop dev-start

test:
	$(GOBIN) test -cover -race `go list ./... | grep -v '.gopath'`
