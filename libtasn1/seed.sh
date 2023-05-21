NAME="libtasn1"
DESC="C library for encoding and decoding DER/BER data following an ASN.1 schema"
VERSION="4.19.0"
SOURCE="https://ftp.gnu.org/gnu/libtasn1/libtasn1-${VERSION}.tar.gz"
CHECKSUM="f701ab57eb8e7d9c105b2cd5d809b29a"
DEPS=""
FLAGS="test"

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

_test()
{
	make -j${BUILD_JOBS} check
}
