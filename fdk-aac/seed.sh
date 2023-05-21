NAME="fdk-aac"
DESC="Fraunhofer FDK AAC library"
VERSION="2.0.2"
SOURCE="https://downloads.sourceforge.net/opencore-amr/fdk-aac-${VERSION}.tar.gz"
CHECKSUM="b41222194b31f570b3132bd622a9aef6"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
