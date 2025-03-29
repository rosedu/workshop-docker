NAME ?= perpetual-writer
IMAGE_NAME = $(NAME)
CONTAINER_NAME = $(NAME)

build:
	docker build -f Dockerfile -t $(IMAGE_NAME) .

run: build
	docker run -d --name $(CONTAINER_NAME) -t $(IMAGE_NAME)

stop:
	-docker stop $(CONTAINER_NAME)

clean: stop
	docker rm $(CONTAINER_NAME)

.PHONY: build run stop clean
