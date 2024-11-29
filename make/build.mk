CONTEXT := docker
CUDADOCKERFILE ?= ${CONTEXT}/ml/Dockerfile.cuda
CUDAIMAGE ?= wanglei4687/devcontainers:cuda12
PLATFORM ?= linux/amd64
CROSSPLATFORM ?= linux/amd64,linux/arm64
NODEIMAGE ?= wanglei4687/devcontainers:node20
NODEDOCKERFILE ?=  docker/node/Dockerfile
KUBEIMAGE ?= wanglei4687/devcontainers:kube
KUBEDOCKERFILE ?= docker/kubernetes/Dockerfile

.PHONY: cuda-load
cuda-load:
	$(info ===========================================)
	$(info Build Cuda Image, Load it to local...)
	$(info ===========================================)
	@docker buildx build --load -t ${CUDAIMAGE} -f ${CUDADOCKERFILE} ${CONTEXT}

.PHONY: cuda-push
cuda-push:
	$(info ===========================================)
	$(info Push Cuda Image to Hub...)
	$(info ===========================================)
	@docker buildx build --platform ${PLATFORM} --push -t ${CUDAIMAGE} -f ${CUDADOCKERFILE} ${CONTEXT} 

.PHOONY: cuda-run
cuda-run:
	$(info ===========================================)
	$(info Start Cuda image local...)
	$(info ===========================================)
	@docker run --runtime=nvidia  --tty --gpus all -it ${CUDAIMAGE} /bin/zsh


.PHONY: cuda-clean
cuda-clean:
	$(info ===========================================)
	$(info Clean Cuda image)
	$(info ===========================================)
	@docker container prune --filter LABEL=NAME="MLCUDA"

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

.PHONY: kube-load
kube-load:
	$(info ===========================================)
	$(info Build k8s dev Image, Load it to local...)
	$(info ===========================================)
	@docker buildx build --load -t ${KUBEIMAGE} -f ${KUBEDOCKERFILE} ${CONTEXT}

.PHONY: kube-push
kube-push:
	$(info ===========================================)
	$(info Push k8s dev Image to Hub...)
	$(info ===========================================)
	@docker buildx build --platform ${PLATFORM} --push -t ${KUBEIMAGE} -f ${KUBEDOCKERFILE} ${CONTEXT} 

.PHONY: kube-run
kube-run:
	$(info ===========================================)
	$(info Run k8s dev image local...)
	$(info ===========================================)
	@docker run --tty -it ${KUBEIMAGE} /bin/zsh
