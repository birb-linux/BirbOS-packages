NAME="nasm"
DESC="Netwide Assembler"
VERSION="2.16.03"
SOURCE="https://www.nasm.us/pub/nasm/releasebuilds/${VERSION}/nasm-${VERSION}.tar.xz"
CHECKSUM="2b8c72c52eee4f20085065e68ac83b55"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
