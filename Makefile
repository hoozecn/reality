REPO ?= hoozecn/reality
TAG ?= v1.0.0
XRAY_VERSION ?= v1.8.1

build:
	docker buildx build --progress plain --push --platform linux/amd64,linux/arm64 \
		--label GIT_VERSION=$(git rev-parse --abbrev-ref HEAD) \
		--label XRAY_VERSION=$(XRAY_VERSION) \
		--build-arg XRAY_VERSION=$(XRAY_VERSION) \
		 -t $(REPO):$(TAG) .
