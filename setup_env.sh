
module purge
module load ohpc
module load mkl gnu8/8.3.0 autotools cmake openmpi3

PREFIX=/opt/ohpc/pub/libs/gnu8/openmpi3/ngsolve/nightly
PATH=$PREFIX/bin:$PATH
