git submodule init || exit $?
git submodule update || exit $?

mkdir -p build || exit $?
cd build || exit $?

# Detect if clang is installed, then use it by default
if command -v clang >/dev/null 2>&1 ; then
    echo "Export environment variables to compile with clang++ instead of g++"
    export CC=/usr/bin/clang
    export CXX=/usr/bin/clang++ 
    export CCACHE_CPP2=yes # CMake special ccache mode for clang
fi

# Generate a Makefile with Debug flags
cmake .. -DCMAKE_BUILD_TYPE=Debug

# Build (ie 'make')
cmake --build .

# Run unit-tests (ie 'make test')
export GTEST_COLOR=1
ctest -V
