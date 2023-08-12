NAME="libtiff"
DESC="TIFF libraries and associated utilities"
VERSION="4.5.1"
SOURCE="https://gitlab.com/libtiff/libtiff/-/archive/v${VERSION}/libtiff-v${VERSION}.tar.gz"
CHECKSUM="25db464e6d94589d3f065b7c1916fde5"
DEPS="cmake"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-v${VERSION}
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
