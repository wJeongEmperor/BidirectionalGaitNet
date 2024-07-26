#!/usr/bin/env bash
ENVDIR=${ENVDIR:-~/pkgenv }

# If CentOS server, set C++ compiler manually
if [ -f /etc/redhat-release ]; then
    export CC=/opt/ohpc/pub/compiler/gcc/8.3.0/bin/gcc
    export CXX=/opt/ohpc/pub/compiler/gcc/8.3.0/bin/g++
fi


if [ ! -d "c3d" ]; then
    mkdir c3d
fi

mkdir -p build
pushd build
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$ENVDIR \
      -DCMAKE_INSTALL_PREFIX=$ENVDIR \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=TRUE \
      -DCMAKE_INSTALL_RPATH="$ENVDIR/lib:/usr/lib/x86_64-linux-gnu" \
      -DFCL_INCLUDE_DIRS=$ENVDIR/include/fcl \
      -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so \
      -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m \
      ..
popd