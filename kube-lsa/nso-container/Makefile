.PHONY: all clean

all: .docker

.docker:
	docker build -t containers.cisco.com/frjansso/nso-lsa .
	docker tag containers.cisco.com/frjansso/nso-lsa containers.cisco.com/frjansso/nso-lsa:1.0
	touch .docker

clean:
	@rm -f .docker > /dev/null || true
	@docker rmi -f containers.cisco.com/frjansso/nso-lsa > /dev/null || true
	@docker rmi -f containers.cisco.com/frjansso/nso-lsa:1.0 > /dev/null || true

