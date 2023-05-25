NAME="newsboat"
DESC="RSS/Atom feed reader for the text console"
VERSION="2.31"
SOURCE="https://newsboat.org/releases/${VERSION}/newsboat-${VERSION}.tar.xz"
CHECKSUM="035e98338f8f672c5c11ccb3ba509a0b"
DEPS="sqlite curl libxml2 stfl asciidoctor json-c rustc"
FLAGS=""

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
	make DESTDIR=$FAKEROOT/$NAME install
}
