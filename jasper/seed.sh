NAME="jasper"
DESC="An open-source initiative to provide a free software-based reference implementation of the JPEG-2000 codec"
VERSION="4.0.0"
SOURCE="https://github.com/jasper-software/jasper/archive/version-${VERSION}/jasper-${VERSION}.tar.gz"
CHECKSUM="1578be3c1e329fdaae35d98dd804ed95"
DEPS="cmake libjpeg-turbo"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-version-${VERSION}
}

_build()
{
	mkdir BUILD
	cd    BUILD

	cmake -DCMAKE_INSTALL_PREFIX=/usr    \
		  -DCMAKE_BUILD_TYPE=Release     \
		  -DCMAKE_SKIP_INSTALL_RPATH=YES \
		  -DJAS_ENABLE_DOC=NO            \
		  -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/jasper-${VERSION} \
		  ..

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} test
}
