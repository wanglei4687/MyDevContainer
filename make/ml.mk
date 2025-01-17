CUDADOCKERFILE ?= ${CONTEXT}/ml/Dockerfile.cuda
CUDAIMAGE ?= wanglei4687/devcontainers:cuda12

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



