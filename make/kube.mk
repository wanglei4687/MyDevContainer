
KUBEIMAGE ?= wanglei4687/devcontainers:kube
KUBEDOCKERFILE ?= docker/kubernetes/Dockerfile

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
