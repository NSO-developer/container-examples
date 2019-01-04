CONTAINER=containers.cisco.com/frjansso/nso-live-ready-test

.PHONY=image push run

lr-test/load-dir/lr-test.fxs: lr-test/src/yang/lr-test.yang
	cd lr-test/src; make

image: lr-test/load-dir/lr-test.fxs
	docker build -t $(CONTAINER) .

push:
	docker push $(CONTAINER)

clean:
	docker rmi $(CONTAINER)

config-map:
	kubectl delete configmap nso-live-ready-test || true
	kubectl create configmap nso-live-ready-test --from-file=ncs.conf
run:
	docker run --rm --name nso-lr\
		--mount type=bind,source="$(CURDIR)",target=/app \
		--mount type=bind,source="$(CURDIR)/lr-test",target=/var/opt/ncs/packages/lr-test \
		$(CONTAINER)
