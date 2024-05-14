PATH := bin:$(PATH)
MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

BUILDX := devcontainers

include make/ml.mk
include make/node.mk

# create buildx
.PHONY: create
create:
	$(info ===========================================)
	$(info Create Buildx $(BUILDX))
	$(info ===========================================)
	@docker buildx create --name $(BUILDX)

# build buildx default mybuilder
.PHONY: use
use:
	$(info ===========================================)
	$(info Use Buildx $(BUILDX))
	$(info ===========================================)
	@docker buildx use $(BUILDX)
	
# clean docker by: docker system prune, docker image prune or docker container prune
# clean just stop buildx
.PHONY: clean
clean:
	$(info ===========================================)
	$(info Stop Buildx $(BUILDX)...)
	$(info ===========================================)
	@docker buildx stop $(BUILDX)

.PHONY: prune
prune:
	$(info ===========================================)
	$(info Clean devcontainers container...)
	$(info ===========================================)
	@docker container prune --filter LABEL=SCOPE="DEVCONTAINERS"