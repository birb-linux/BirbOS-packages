NAME="nsxiv"
DESC="Neo Simple X Image Viewer"
VERSION="31"
SOURCE="https://codeberg.org/nsxiv/nsxiv/archive/v${VERSION}.tar.gz"
CHECKSUM="5f948291194a7bbd1dc2d24c4b21b5e7"
DEPS="xorg-libs imlib2 libxft freetype fontconfig libexif"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
}

_build()
{
	make CC=gcc -j${BUILD_JOBS}
}

_install()
{
	make CC=gcc DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
