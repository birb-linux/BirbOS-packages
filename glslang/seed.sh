NAME="glslang"
DESC="Khronos-reference front end for GLSL/ESSL, partial front end for HLSL, and a SPIR-V generator"
VERSION="12.1.0"
SOURCE="https://github.com/KhronosGroup/glslang/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="218e2dd3ab422fca3a99ba6ca517c84c"
DEPS="cmake make bison"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	BUILD_DIR="$(pwd)/build"
	SOURCE_DIR="$(pwd)"

	mkdir build
	cd    build

	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FAKEROOT/$NAME/usr" ..
}

_install()
{
	make -j${BUILD_JOBS} install
}
