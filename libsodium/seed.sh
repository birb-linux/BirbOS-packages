NAME="libsodium"
DESC="A modern, portable, easy to use crypto library"
VERSION="1.0.19"
SOURCE="https://github.com/jedisct1/libsodium/releases/download/${VERSION}-RELEASE/libsodium-${VERSION}.tar.gz"
CHECKSUM="0d8e2233fc41be6d4c7ee36d5dfe9416"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-stable
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
