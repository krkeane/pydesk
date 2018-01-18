# pydesk

This repository provides Dockerfiles to build a CentOS / Python 3 
based image capable of running demonstrations from the 
[pyprobml](https://github.com/probml/pyprobml)

You must have docker installed; then, 
`
make
`

To launch the pydesk container, 
`
docker run --privileged -p nnnn:5901 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d pydesk
`

You may access your pydesk container using a VNC viewer.  
*  If you are running the VNC viewer on the same machine running the docker container, the VNC server is reached at _localhost:nnnn_.
*  If you are running the container elsewhere, setup a ssh tunnel from the vncviewer machine to the docker machine. With a tunnel from port _mmmm_ on your local machine to port _nnnn_ on the docker machine, the VNC server is reached at _localhost:mmmm_.
*  The user name is _demoUser_.  The password is _demodemo_.
