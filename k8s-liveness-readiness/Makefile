CONTAINER=containers.cisco.com/frjansso/nso-live-ready-test

.PHONY=image push run deploy undeploy

lr-test/load-dir/lr-test.fxs: lr-test/src/yang/lr-test.yang
	cd lr-test/src; make

image: lr-test/load-dir/lr-test.fxs
	docker build -t $(CONTAINER) .

push:
	docker push $(CONTAINER)

clean:
	docker rmi $(CONTAINER)

deploy: 
	kubectl create configmap nso-live-ready-test --from-file=ncs.conf
	kubectl create -f deployment.yml

undeploy:
	kubectl delete -f deployment.yml
	kubectl delete configmap nso-live-ready-test || true

run:
	docker run --rm --name nso-lr\
		--mount type=bind,source="$(CURDIR)",target=/app \
		--mount type=bind,source="$(CURDIR)/lr-test",target=/var/opt/ncs/packages/lr-test \
		$(CONTAINER)
