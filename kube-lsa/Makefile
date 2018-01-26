LSA=$(NCS_DIR)/examples.ncs/getting-started/developing-with-ncs/22-layered-service-architecture

all: nso-projects
	(cd nso-projects/22-layered-service-architecture; make all)
	(cd netsim-container; make all)
	(cd nso-container; make all)

nso-projects:
	mkdir -p nso-projects
	cp -r $(LSA) nso-projects/.
	cp -r $(LSA)/../packages nso-projects/.
	# Enable SSH
	sed -in-place=bak '/<ssh>/,/<ip>/{s/false/true/g}' nso-projects/22-layered-service-architecture/upper-nso/ncs.conf

clean:
	sudo rm -rf nso-projects
	(cd netsim-container; make clean)
	(cd nso-container; make clean)
YAML=nso-upper.yaml nso-lower-1.yaml nso-lower-2.yaml netsim.yaml

start:
	$(foreach desc, $(YAML), kubectl create -f $(desc);)

stop:
	$(foreach desc, $(YAML), kubectl delete -f $(desc);)

