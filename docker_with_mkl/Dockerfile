FROM centos:7
MAINTAINER Michael Wimmer <m.t.wimmer@tudelft.nl>

RUN cd
RUN yum install -y wget
RUN yum install -y gcc gcc-c++ gcc-gfortran make
RUN yum install -y zlib-devel
RUN yum install -y bzip2
RUN yum install -y which
RUN yum install -y man
RUN wget https://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
RUN /bin/bash Anaconda3-4.0.0-Linux-x86_64.sh -b
RUN echo 'export PATH="/root/anaconda3/bin:$PATH"' > /root/.bashrc
ENV PATH /root/anaconda3/bin:$PATH

ADD l_mkl_11.3.2.181.tgz /
WORKDIR /l_mkl_11.3.2.181

