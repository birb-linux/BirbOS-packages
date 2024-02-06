NAME="unrar"
DESC="RAR extraction utility used for extracting files from RAR archives"
VERSION="6.2.10"
SOURCE="https://www.rarlab.com/rar/unrarsrc-${VERSION}.tar.gz"
CHECKSUM="0ab6486347a084e3c5759f4bbf02042f"
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
