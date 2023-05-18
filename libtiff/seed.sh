NAME="libtiff"
DESC="TIFF libraries and associated utilities"
VERSION="4.5.0"
SOURCE="https://gitlab.com/libtiff/libtiff/-/archive/v${VERSION}/libtiff-${VERSION}.tar.gz"
CHECKSUM="6e9b613cd83da5024b65fc9b80416833"
DEPS="cmake"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir -p libtiff-build
	cd       libtiff-build

	cmake -DCMAKE_INSTALL_DOCDIR=$FAKEROOT/$NAME/usr/share/doc/libtiff-${VERSION} \
		  -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr -G Ninja ..

	ninja
}

_install()
{
	ninja install
}

_test()
{
	ninja test
}
