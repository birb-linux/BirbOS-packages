NAME="fdk-aac"
DESC="Fraunhofer FDK AAC library"
VERSION="2.0.3"
SOURCE="https://downloads.sourceforge.net/opencore-amr/fdk-aac-${VERSION}.tar.gz"
CHECKSUM="f43e593991caefdce509ad837d3301bd"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
