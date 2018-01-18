FROM centos:latest

LABEL \
  maintainer="Kevin R. Keane <krkeane@buffalo.edu>" \
  build="docker build -t TAG ." \
  run="docker run --privileged -p 5901:5901 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d  TAG"
 
USER root

# systemd is included in centos:latest base containers, 
# but it is not active by default. 
#
# activate systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
	systemd-tmpfiles-setup.service ] || rm -f $i; done); \
	rm -f /lib/systemd/system/multi-user.target.wants/*;\
	rm -f /etc/systemd/system/*.wants/*;\
	rm -f /lib/systemd/system/local-fs.target.wants/*; \
	rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
	rm -f /lib/systemd/system/basic.target.wants/*;\
	rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

# install KEYs to authenticate packages
RUN rpm --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum install epel-release deltarpm -y && \
    rpm --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && \ 
    yum clean all

# install a window manager
RUN yum groupinstall "X Window system" -y && \
    yum groupinstall --skip-broken "Xfce" -y && \
    yum install xpdf -y && \
    yum clean all && \
    systemctl set-default graphical.target && \
    sed -i 's.}.    if [ -x /bin/xfce4-terminal ] ; then\n        exec /usr/bin/startxfce4\n    fi\n}.g' /etc/X11/xinit/Xclients

#  install a VNC server
RUN yum install -y tigervnc-server && \
    yum clean all 
EXPOSE 5901

# setup a user account and user VNC session
ENV DEMO_USER demoUser
ENV DEMO_PASSWORD demodemo
ENV DEMO_UID 1000
RUN useradd -m -s /bin/bash -N -u ${DEMO_UID} ${DEMO_USER} && \ 
    cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service && \
    sed -i 's/<USER>/'"${DEMO_USER}"'/g' /etc/systemd/system/vncserver@:1.service 

# set the VNC password
USER ${DEMO_USER}
RUN printf "${DEMO_PASSWORD}\n${DEMO_PASSWORD}\n" | vncpasswd

# back to root, put VNC in gear, and get ready to run /usr/sbin/init ...
USER root
RUN chown -R ${DEMO_USER}:users /opt && \
    systemctl enable vncserver@:1.service && \
    yum remove orage -y && \
    yum clean all
