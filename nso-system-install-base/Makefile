
CONTAINER="containers.cisco.com/frjansso/nso-system-base"
VER=5.2.0.2

.PHONY=image push run-bash run

image:
	docker build --build-arg NSOVER=$(VER) -t $(CONTAINER):latest .
	docker tag $(CONTAINER):latest $(CONTAINER):$(VER)

push:
	docker push $(CONTAINER):$(VER)
	docker push $(CONTAINER):latest

run-bash:
	docker run -it --rm --name=nso-$(VER) $(CONTAINER):$(VER) bash

run:
	docker run -it --rm --name=nso-$(VER) $(CONTAINER):$(VER)
