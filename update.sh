source setup_env.sh

cd $PREFIX/src
git pull
git submodule update --init --recursive

source $PREFIX/install/bin/activate

cd $PREFIX/build

make -j8 install
