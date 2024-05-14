CONTEXT := docker
CUDADOCKERFILE ?= docker/ml/Dockerfile.cuda
CPUDOCKERFILE ?= docker/ml/Dockerfile.cpu
CUDAIMAGE ?= wanglei4687/devcontainers:cuda12
CPUIMAGE ?= wanglei4687/devcontainers:mlcpu
PLATFORM ?= linux/amd64
CROSSPLATFORM ?= linux/amd64,linux/arm64

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
	@docker run -it ${CUDAIMAGE} /bin/zsh


.PHONY: cuda-clean
cuda-clean:
		$(info ===========================================)
	$(info Start Cuda image local...)
	$(info ===========================================)
	@docker container prune --filter LABEL=NAME="MLCUDA"

.PHONY: mlcpu-load
mlcpu-load:
	$(info ===========================================)
	$(info Build ML CPU Image, Load it to local...)
	$(info ===========================================)
	@docker buildx build --load -t ${CPUIMAGE}  -f ${CPUDOCKERFILE} ${CONTEXT}

.PHONY: mlcpu-push
mlcpu-push:
	$(info ===========================================)
	$(info Push ML CPU Image to hub...)
	$(info ===========================================)
	@docker buildx build --platform ${CROSSPLATFORM} --push -t ${CPUIMAGE} -f ${CPUDOCKERFILE} ${CONTEXT}

.PHONY: mlcpu-run
mlcpu-run:
	$(info ===========================================)
	$(info Start ML CPU Image local...)
	$(info ===========================================)
	@docker run -it ${CPUIMAGE} /bin/zsh

.PHONY: mlcpu-clean
mlcpu-clean:
	$(info ===========================================)
	$(info Clean mlcpu container...)
	$(info ===========================================)
	@docker container prune --filter LABEL=NAME="MLCPU" 
