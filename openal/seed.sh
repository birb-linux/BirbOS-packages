NAME="openal"
DESC="Software implementation of the OpenAL 3D audio API"
VERSION="1.23.1"
SOURCE="https://github.com/kcat/openal-soft/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="190a60118236644b78488ccab26ebfdf"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-soft-${VERSION}
}

_build()
{
	mkdir -p build
	cd build
	cmake -DCMAKE_INSTALL_PREFIX=/usr -DALSOFT_EXAMPLES=Off -DALSOFT_INSTALL_EXAMPLES=Off ..
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
