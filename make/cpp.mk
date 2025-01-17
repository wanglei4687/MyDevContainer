CPPDOCKERFILE ?= ${CONTEXT}/cpp/Dockerfile.cpp
CPPIMAGE ?= wanglei4687/devcontainers:cpp

.PHONY: cpp-load
cpp-load:
	$(info ===========================================)
	$(info Build CPP Image, Load it to local...)
	$(info ===========================================)
	@docker buildx build --load -t ${CPPIMAGE} -f ${CPPDOCKERFILE} ${CONTEXT}

.PHONY: cpp-push
cpp-push:
	$(info ===========================================)
	$(info Push CPP Image to Hub...)
	$(info ===========================================)
	@docker buildx build --platform ${PLATFORM} --push -t ${CPPIMAGE} -f ${CPPDOCKERFILE} ${CONTEXT} 

.PHOONY: cpp-run
cpp-run:
	$(info ===========================================)
	$(info Start CPP image local...)
	$(info ===========================================)
	@docker run --runtime=nvidia  --tty --gpus all -it ${CPPIMAGE} /bin/zsh


.PHONY: cpp-clean
cpp-clean:
	$(info ===========================================)
	$(info Clean CPP image)
	$(info ===========================================)
	@docker container prune --filter LABEL=NAME="CPP"
