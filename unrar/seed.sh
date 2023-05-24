NAME="unrar"
DESC="RAR extraction utility used for extracting files from RAR archives"
VERSION="6.2.6"
SOURCE="https://www.rarlab.com/rar/unrarsrc-${VERSION}.tar.gz"
CHECKSUM="6c68f2bbcd9f06f9d37801ad4256e680"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
}

_build()
{
	make -j${BUILD_JOBS} -f makefile
}

_install()
{
	install -v -m755 unrar $FAKEROOT/$NAME/usr/bin
}
