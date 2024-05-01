.PHONY: cuda-load
cuda-load:
	$(info Build Cuda Image, Load it to local...)
	@docker buildx build --platform linux/amd64 --load -t wanglei4687/dev-container:cuda12 -f docker/ml/Dockerfile.cuda docker

.PHONY: cuda-push
cuda-push:
	$(info Push Cuda Image to Hub...)
	@docker buildx build --platform linux/amd64 --push -t wanglei4687/dev-container:cuda12 -f docker/ml/Dockerfile.cuda docker
