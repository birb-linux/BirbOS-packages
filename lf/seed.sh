NAME="lf"
DESC="Terminal file manager written in Go with a heavy inspiration from ranger file manager"
VERSION="r29"
SOURCE="https://github.com/gokcehan/lf/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="971a8e1f71d33ff714cf343ce98dca49"
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
	cp -vf $PWD/lf $FAKEROOT/$NAME/usr/bin/lf
	cp -vf $PWD/lf.1 $FAKEROOT/$NAME/usr/share/man/man1/lf.1
}
