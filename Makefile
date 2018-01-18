IMAGES=base pydesk
.PHONY: $(IMAGES) all clean

all:	$(IMAGES)

pydesk:	base
	cd pydesk; docker build -t pydesk .

base:
	cd base; docker build -t base .

# this is destructive; you may not want to do this
clean:
	@-docker stop `docker ps -a -q`
	@-docker rm `docker ps -a -q`
	@-docker rmi -f `docker images -a -q`
	@-docker images
	@-docker ps -a -q
