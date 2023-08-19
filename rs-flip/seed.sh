NAME="rs-flip"
DESC="RuneScape flipping utility to make GE standing more profitable"
VERSION="1.1.0"
SOURCE="https://github.com/Toasterbirb/RS-Flip/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="47b75e6a4d4557cd395cf4bcc6c77d04"
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
