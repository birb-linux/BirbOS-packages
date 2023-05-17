NAME="libtiff"
DESC="TIFF libraries and associated utilities"
VERSION="4.5.0"
SOURCE="https://download.osgeo.org/libtiff/tiff-${VERSION}.tar.gz"
CHECKSUM="db9e220a1971acc64487f1d51a20dcaa"
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
