NAME="rs-flip"
DESC="RuneScape flipping utility to make GE standing more profitable"
VERSION="1.1.1"
SOURCE="https://github.com/Toasterbirb/RS-Flip/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="a7a1609e96385eb19526294fbf9324fd"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd RS-Flip-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake ..
	make -j${BUILD_JOBS}
}

_install()
{
	install -v -m755 ./flip $FAKEROOT/$NAME/usr/bin
}
