NAME="doxygen"
DESC="Documentation system"
VERSION="1.9.6"
SOURCE="https://doxygen.nl/files/doxygen-${VERSION}.src.tar.gz"
CHECKSUM="5f7ab15c8298d013c5ef205a4febc7b4"
DEPS="cmake git"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir -v build
	cd       build

	cmake -G "Unix Makefiles"         \
		  -DCMAKE_BUILD_TYPE=Release  \
		  -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr \
		  -Wno-dev ..

	make -j${MAKEOPTS}
}

_install()
{
	make install
	install -vm644 ../doc/*.1 $FAKEROOT/$NAME/usr/share/man/man1
}
