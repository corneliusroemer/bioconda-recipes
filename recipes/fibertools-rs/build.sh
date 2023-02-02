#!/bin/bash -e

if [[ ${target_platform} =~ linux.* ]]; then
    #curl https://download.pytorch.org/libtorch/cpu/libtorch-shared-with-deps-1.13.0%2Bcpu.zip \
    curl https://download.pytorch.org/libtorch/cu116/libtorch-shared-with-deps-1.13.0%2Bcu116.zip \
        --output ${PREFIX}/libtorch.zip
    export LIBTORCH_CXX11_ABI=0
elif [[ ${target_platform} =~ osx.* ]]; then
    curl https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.13.0.zip \
        --output ${PREFIX}/libtorch.zip
fi
#mkdir -p ${CONDA_PREFIX}/share
#unzip libtorch.zip -d ${CONDA_PREFIX}/share

#export LIBTORCH=${CONDA_PREFIX}/share/libtorch
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LIBTORCH}/lib
#export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${LIBTORCH}/lib

pushd ${PREFIX}
unzip libtorch.zip
rm libtorch.zip

mkdir -p ${PREFIX}/share ${PREFIX}/lib ${PREFIX}/include
mv ${PREFIX}/libtorch/lib/* ${PREFIX}/lib/.
mv ${PREFIX}/libtorch/include/* ${PREFIX}/include/.
mv ${PREFIX}/libtorch/share/* ${PREFIX}/share/.

#export LIBTORCH=${PREFIX}/libtorch
export LIBTORCH=${PREFIX}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LIBTORCH}/lib
export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${LIBTORCH}/lib
export RPATH=${RPATH}:${LIBTORCH}/lib
popd

echo ""
HOME=$(pwd)
echo "MY PWD ${HOME}"
ls ${HOME}
echo ""
echo "MY PREFIX: ${PREFIX}"
ls ${PREFIX}
echo ""
echo "MY LIBTORCH: ${LIBTORCH}"
echo "MY LD_LIBRARY_PATH: ${LD_LIBRARY_PATH}"
echo "MY DYLD_LIBRARY_PATH: ${DYLD_LIBRARY_PATH}"
echo "MY RPATH: ${RPATH}"
echo ""

# get the flags from the pytorch build
#export CFLAGS="$CFLAGS -I${LIBTORCH}/include"
#export CPPFLAGS="$CFLAGS -I${LIBTORCH}/include"
#export LDFLAGS="$LDFLAGS -L${LIBTORCH}/lib"

# TODO: Remove the following export when pinning is updated and we use
#       {{ compiler('rust') }} in the recipe.
export \
    CARGO_NET_GIT_FETCH_WITH_CLI=true \
    CARGO_HOME="${BUILD_PREFIX}/.cargo"
export BINDGEN_EXTRA_CLANG_ARGS="${CFLAGS} ${CPPFLAGS} ${LDFLAGS}"

# maybe add this becuase of this: https://twitter.com/nomad421/status/1619713549668065280
if [[ -n "$OSX_ARCH" ]]; then
    # Set this so that it doesn't fail with open ssl errors
    export RUSTFLAGS="-C link-arg=-undefined -C link-arg=dynamic_lookup"
fi

pushd ${PREFIX}
cargo install --all-features --no-track --verbose --root "${PREFIX}" --path ${HOME}
popd
ft --help

exit 0
