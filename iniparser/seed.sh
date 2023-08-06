NAME="iniparser"
DESC="Standalone ini parser library in ANSI C"
VERSION="4.1"
SOURCE="https://github.com/ndevilla/iniparser/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="e43b722c71b399ab17c329c04dbdf1d7"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	install -v -m755 libiniparser.so.1 $FAKEROOT/$NAME/usr/lib
	ln -srv $FAKEROOT/$NAME/usr/lib/libiniparser.so.1 $FAKEROOT/$NAME/usr/lib/libiniparser.so.0
	ln -srv $FAKEROOT/$NAME/usr/lib/libiniparser.so.1 $FAKEROOT/$NAME/usr/lib/libiniparser.so
}

_test()
{
	make check
}
