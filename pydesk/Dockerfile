FROM base

LABEL \
  maintainer="Kevin R. Keane <krkeane@buffalo.edu>" \
  build="docker build -t TAG ." \
  run="docker run --privileged -p 5901:5901 -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d  TAG"

RUN yum -y update \
    && yum group install -y "Development Tools" \
    && yum -y install curl bzip2 git \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local/ \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && conda clean --all --yes \
    && rpm -e --nodeps curl bzip2 \
    && yum clean all

# install Firefox browser for Jupyter notebooks
RUN yum update -y && \
    yum install -y wget firefox && \
    yum clean all && \
    mkdir -p /usr/share/doc/HTML

COPY index.html /usr/share/doc/HTML

# install matplotlib
RUN conda install -c conda-forge matplotlib

RUN conda install -y scipy keras pandas \
      scikit-learn networkx patsy \
      statsmodels sympy pystan && \
    pip install autograd utils 

USER ${DEMO_USER}
RUN cd /home/${DEMO_USER} && \
    mkdir git && \
    cd git && \
    git clone https://github.com/probml/pyprobml
USER root


