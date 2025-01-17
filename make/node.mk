NODEIMAGE ?= wanglei4687/devcontainers:node20
NODEDOCKERFILE ?=  docker/node/Dockerfile

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
	@docker buildx build --platform ${PLATFORM} --push -t ${NODEIMAGE} -f ${NODEDOCKERFILE} ${CONTEXT} 

.PHONY: node-clean
node-clean:
	$(info ===========================================)
	$(info Clean Node image...)
	$(info ===========================================)
	@docker container prune --filter LABEL=NAME="NODE"