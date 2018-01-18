# pydesk

This repository provides Dockerfiles to build a CentOS / Python 3 
based image capable of running demonstrations from the 
[pyprobml](https://github.com/probml/pyprobml) repository.

You must have docker installed; then, 

`
make
`

If you want to see what will go on first, 

`
make -n
`

will display the commands to be executed, without actually executing.

To launch the pydesk container, 
`
docker run --privileged -p nnnn:5901 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d pydesk
`

You may access your pydesk container using a VNC viewer.  
*  If you are running the VNC viewer on the same machine running the docker container, the VNC server is reached at _localhost:nnnn_.
*  If you are running the container elsewhere, setup a ssh tunnel from the vncviewer machine to the docker machine. With a tunnel from port _mmmm_ on your local machine to port _nnnn_ on the docker machine, the VNC server is reached at _localhost:mmmm_.
*  The user name is _demoUser_.  The password is _demodemo_.

One you are in your VNC viewer desktop, 
*  right mouse / Applications / Settings / Display to set your desired resolution
*  open a terminal; `cd ~/git/probml`, and follow the [README.md](https://github.com/probml/pyprobml) instructions.  85+ demos will work fairly well.  A few kick up dust.  If you clean up the code, please send a pull request (either to this repository or to the probml/pyprobml repository).

Enjoy!

For cleanup, there is

`
make clean
`

It aggressively eliminates docker artifacts, so don't do this if you want to keep the contents of a container or keep an image on your docker machine. To see what will happen, without actually doing anything, 

`
make -n clean
`

