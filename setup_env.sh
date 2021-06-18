module purge
module load \
	       gcc/10.2.0-gcc-9.1.0-2aa5hfe \
	       python/3.9.4-gcc-10.2.0-y355ixy \
	       cmake/3.17.3-gcc-9.1.0-tsjr5x6 \
	       openmpi/4.1.0-gcc-9.1.0-2cmze2s \
	       intel-mkl/2020.4 \
	       opencascade/7.5.0-gcc-10.2.0-6nsvk3o 

PREFIX=~/ngs_vsc
export PATH=$PREFIX/install/bin:$PATH

