PATH := bin:$(PATH)
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

BUILDX := devcontainer

include make/ml.mk

# bootstrap buildxdocker buildx ls | grep docker-container
.PHONY: bootstrap
bootstrap:
	$(info Create Buildx $(BUILDX))
	@docker buildx create --name $(BUILDX) --bootstrap

# build buildx default mybuilder
.PHONY: use
use:
	$(info Use Buildx $(BUILDX))
	@docker buildx use $(BUILDX)

.PHONY: cudev
cudev: bootstrap use
	

# clean docker by: docker system prune, docker image prune or docker container prune
# clean just stop buildx
.PHONY: clean
clean:
	$(info Stop Buildx $(BUILDX)...)
	@docker buildx stop $(BUILDX)
