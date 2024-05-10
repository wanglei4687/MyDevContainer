CONTEXT := docker
NODEIMAGE ?= wanglei4687/devcontainers:node20
NODEDOCKERFILE ?=  docker/node/Dockerfile
PLATFORM ?= linux/amd64
CROSSPLATFORM ?= linux/amd64,linux/arm64

.PHONY: node-load
node-load:
	$(info ===========================================)
	$(info Build Node Image, Load it to local...)
	$(info ===========================================)
	@docker buildx build --load -t ${NODEIMAGE} -f ${NODEDOCKERFILE} ${CONTEXT}

.PHONY: node-push
node-push:
	$(info ===========================================)
	$(info Push Node Image to Hub...)
	$(info ===========================================)
	@docker buildx build --platform ${CROSSPLATFORM} --push -t ${NODEIMAGE} -f ${NODEDOCKERFILE} ${CONTEXT} 