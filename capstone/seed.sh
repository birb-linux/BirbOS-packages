NAME="capstone"
DESC="Lightweight multi-platform, multi-architecture disassembly framework"
VERSION="5.0"
SOURCE="https://github.com/capstone-engine/capstone/archive/${VERSION}.tar.gz"
CHECKSUM="027fcaafea4acc47af9798dc520cef2c"
DEPS="cmake ninja python3"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake .. -DCMAKE_INSTALL_PREFIX=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
