FROM centos:7
MAINTAINER Michael Wimmer <m.t.wimmer@tudelft.nl>

RUN cd
RUN yum install -y wget
RUN yum install -y gcc gcc-c++ gcc-gfortran
RUN yum install -y zlib-devel
RUN yum install -y bzip2
RUN wget https://repo.continuum.io/archive/Anaconda3-2.5.0-Linux-x86_64.sh
RUN /bin/bash Anaconda3-2.5.0-Linux-x86_64.sh -b
RUN echo 'export PATH="/root/anaconda3/bin:$PATH"' > /root/.bashrc
ENV PATH /root/anaconda3/bin:$PATH

RUN mkdir /conda-recipes
ADD mkl_seq /conda-recipes/mkl_seq
ADD numpy_mkl_seq /conda-recipes/numpy_mkl_seq
ADD scipy_mkl_seq /conda-recipes/scipy_mkl_seq

WORKDIR /conda-recipes
RUN conda build mkl_seq numpy_mkl_seq scipy_mkl_seq

VOLUME ["/home/shared"]
