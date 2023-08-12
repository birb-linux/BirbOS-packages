NAME="radare2"
DESC="UNIX-like reverse engineering framework and command-line toolset"
VERSION="5.8.8"
SOURCE="https://github.com/radareorg/radare2/releases/download/${VERSION}/radare2-${VERSION}.tar.xz"
CHECKSUM="724448a9054e857875c53d75dd82fbd7"
DEPS="capstone libzip openssl xxhash gperf file zlib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
