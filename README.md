# Conda recipes for a channel of kwant + sequential mkl for centos 7

## Docker image with anaconda and mkl

Copy the intel mkl tar file  (l_mkl_11.3.2.181.tgz) you download from the
intel website to docker_with_mkl. Run

    docker build -t centos7_anaconda_mkl docker_with_mkl

To install MKL, we need to do some things by hand (MKL wants license
number, etc.). Run

    docker run -it centos7_anaconda_mkl bash

and run in docker

    bash install.sh

to install MKL. You will be asked for license number, etc. For some reason,
intel warns you that the destination directory already exists (it did make it
itself when the license number is entered). Just agree to overwrite the
directory. MKL is then installed to /opt/intel/.

Now we need to save these changes to the container. Find out the container
id you just were running using docker ps -a, and do

   sudo docker commit container-id centos7_anaconda_mkl

Then run

   docker build -t centos7_build .

to build the recipes.

# Conda-recipes for my [binstar](http://binstar.org/basnijholt)

In order to install [Kwant](kwant-project.org/) I made some recipes to compile it and its dependencies.

My recipes
  - [MUMPS](mumps.enseeiht.fr) Sequential version, with SCOTCH and Metis (non-python)
  - [SCOTCH](https://www.labri.fr/perso/pelegrin/scotch/) (non-python)
  - Tinyarray
  - Kwant
  - lapack


For Mac OS X you need to have X-Code installed, do with `xcode-select --install`

For Linux it should work out of the box.



To make the build as reproducible as possible I created a Docker image (also in this repo) where I build the linux-64 packages.

### Installation
Clone this repo and don't `cd` into it.

You need to have Docker installed:

```sh
docker build --tag="build" conda-recipes/docker_build/
docker run -v /path/to/conda-recipes/:/conda-recipes/ -it build
```
After you enter your new Docker image:
```sh
conda build /conda-recipes/scotch/
conda install -y scotch --use-local
conda build /conda-recipes/metis/
conda install -y metis --use-local
conda build /conda-recipes/lapack/
conda install -y lapack --use-local
conda build /conda-recipes/mumps_seq/
conda install -y mumps --use-local
conda build /conda-recipes/tinyarray/
conda install -y tinyarray --use-local
conda build /conda-recipes/kwant/
conda install -y kwant --use-local
```
