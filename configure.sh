set -e

source setup_env.sh
echo "PREFIX = $PREFIX"

rm -rf $PREFIX
rm -rf *

python3 -m venv $PREFIX --copies

source $PREFIX/bin/activate

python3 -m pip install numpy scipy jupyter mpi4py ipyparallel webgui_jupyter_widgets

mkdir -p build
cd build

cmake  \
	       -DCMAKE_INSTALL_PREFIX=$PREFIX \
	       -DCMAKE_BUILD_TYPE=Release \
	       -DCMAKE_CXX_COMPILER=`which g++` \
	       -DCMAKE_C_COMPILER=`which gcc` \
               -DSCALAPACK_LIBRARY=$MKLROOT/lib/intel64/libmkl_scalapack_lp64.so \
	       -DUSE_MPI=ON \
	       -DUSE_MKL=ON \
	       -DMKL_SDL=OFF \
	       -DUSE_NUMA=OFF \
	       -DUSE_MUMPS=ON \
	       -DUSE_OCC=OFF \
	       -DUSE_HYPRE=ON \
	       -DMUMPS_DIR=$MUMPS_DIR \
	       -DUSE_GUI=OFF \
	       -DUSE_CCACHE=ON \
	       -DMAX_SYS_DIM=6 \
	       ~/src/ngsolve
	       #-DOCC_INCLUDE_DIR=/opt/ohpc/pub/spack/linux-centos7-x86_64/gcc-8.2.0/oce-0.18.2-oxfhodc55vsf7vxpdowkbciiah66fl2j/include/oce \

make -j8 install

jupyter nbextension install webgui_jupyter_widgets --py --sys-prefix
jupyter nbextension enable webgui_jupyter_widgets --py --sys-prefix

jupyter serverextension enable --py ipyparallel
jupyter nbextension install --sys-prefix --py ipyparallel
jupyter nbextension enable --sys-prefix --py ipyparallel
