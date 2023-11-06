NAME="sfml"
DESC="Simple and Fast Multimedia Library"
VERSION="2.6.0"
SOURCE="https://github.com/SFML/SFML/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="cb866afcd46a2febcc44ad375d5644f4"
DEPS="openal cmake libvorbis flac eudev"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd SFML-${VERSION}
}

_build()
{
	mkdir -p build
	cd build

	cmake -DCMAKE_INSTALL_PREFIX=/usr ..
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
