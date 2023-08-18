NAME="rs-flip"
DESC="RuneScape flipping utility to make GE standing more profitable"
VERSION="1.0"
SOURCE="https://github.com/Toasterbirb/RS-Flip/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="f937c60e3d070fe5af418df4c6ae3fd6"
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
