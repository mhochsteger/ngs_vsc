set -e

source setup_env.sh
echo "PREFIX = $PREFIX"

cd $PREFIX
git clone https://github.com/ngsolve/ngsolve.git src || true
cd src && git pull && git submodule update --init --recursive

rm -rf $PREFIX/install
rm -rf $PREFIX/build

python3 -m venv $PREFIX/install --copies

source $PREFIX/install/bin/activate

python3 -m pip install wheel
python3 -m pip install numpy scipy jupyter mpi4py ipyparallel webgui_jupyter_widgets

mkdir -p $PREFIX/build
cd $PREFIX/build

cmake  \
               -DCMAKE_PREFIX_PATH=$PREFIX/install \
	       -DCMAKE_INSTALL_PREFIX=$PREFIX/install \
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
	       -DUSE_HYPRE=OFF \
	       -DMUMPS_DIR=$MUMPS_DIR \
	       -DUSE_GUI=OFF \
	       -DUSE_CCACHE=ON \
	       -DMAX_SYS_DIM=6 \
	       $PREFIX/src
	       #-DOCC_INCLUDE_DIR=/opt/ohpc/pub/spack/linux-centos7-x86_64/gcc-8.2.0/oce-0.18.2-oxfhodc55vsf7vxpdowkbciiah66fl2j/include/oce \

make -j8 install

jupyter nbextension install webgui_jupyter_widgets --py --sys-prefix
jupyter nbextension enable webgui_jupyter_widgets --py --sys-prefix

jupyter serverextension enable --py ipyparallel
jupyter nbextension install --sys-prefix --py ipyparallel
jupyter nbextension enable --sys-prefix --py ipyparallel
