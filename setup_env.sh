module purge
module load \
	       gcc/11.2.0-gcc-11.2.0-5i4t2bo\
	       python/3.8.12-gcc-11.2.0-a5hqrgs \
	       cmake/3.21.4-gcc-11.2.0-fmwwhz6 \
	       openmpi/4.1.4-gcc-11.2.0-nxdafup \
	       intel-oneapi-mkl/2022.0.2-gcc-11.2.0-2ugv2zs

PREFIX=~/ngs_vsc
export PATH=$PREFIX/install/bin:$PATH

