NAME="ffuf"
DESC="Fast web fuzzer written in Go"
VERSION="2.0.0"
SOURCE="https://github.com/ffuf/ffuf/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="d770e3c6905623529864ed878429ebbe"
DEPS="go"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	go build
}

_install()
{
	# make DESTDIR=$FAKEROOT/$NAME install
	install -m755 ./ffuf $FAKEROOT/$NAME/usr/bin/
}
