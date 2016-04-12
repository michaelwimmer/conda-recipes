FROM centos7_anaconda_mkl
MAINTAINER Michael Wimmer <m.t.wimmer@tudelft.nl>

RUN yum install -y make

RUN mkdir /conda-recipes
ADD mkl_seq /conda-recipes/mkl_seq
ADD numpy_mkl_seq /conda-recipes/numpy_mkl_seq
ADD scipy_mkl_seq /conda-recipes/scipy_mkl_seq

WORKDIR /conda-recipes

RUN /bin/bash -c "source /opt/intel/compilers_and_libraries/linux/mkl/bin/mklvars.sh intel64 && conda build mkl_seq"
RUN conda build numpy_mkl_seq
RUN conda build scipy_mkl_seq

WORKDIR /

ADD tinyarray /conda-recipes/tinyarray
ADD metis /conda-recipes/metis
ADD scotch /conda-recipes/scotch
ADD mumps_seq /conda-recipes/mumps_seq
ADD kwant_mkl_seq /conda-recipes/kwant_mkl_seq

WORKDIR /conda-recipes

RUN yum install -y cmake
RUN conda build tinyarray
RUN conda build metis
RUN conda build scotch
RUN conda build mumps_seq
RUN yum install -y git
RUN conda build kwant_mkl_seq


#VOLUME ["/home/shared"]
