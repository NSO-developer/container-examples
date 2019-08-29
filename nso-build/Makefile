
CONTAINER="containers.cisco.com/frjansso/nso-build"

.PHONY=image push run-bash run

image:
	docker build --build-arg NSOVER=$(VER) -t $(CONTAINER):$(VER) .

push:
	docker push $(CONTAINER):$(VER)

run-bash:
	docker run -it --rm --name=nso-$(VER) $(CONTAINER):$(VER) bash
