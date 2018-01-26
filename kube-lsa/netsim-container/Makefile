.PHONY: all clean

all: .docker

.docker:
	docker build -t containers.cisco.com/frjansso/nso-lsa-netsim .
	docker tag containers.cisco.com/frjansso/nso-lsa-netsim containers.cisco.com/frjansso/nso-lsa-netsim:1.0
	touch .docker

clean:
	@rm -f .docker > /dev/null || true
	docker rmi containers.cisco.com/frjansso/nso-lsa-netsim || true
	docker rmi containers.cisco.com/frjansso/nso-lsa-netsim:1.0 || true

