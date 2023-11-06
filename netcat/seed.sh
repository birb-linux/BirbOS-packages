NAME="netcat"
DESC="Unix utility which reads and writes data across network connections using TCP or UDP protocol"
VERSION="110.20180111"
MAJOR_VERSION="$(major_version $VERSION)"
SOURCE="https://downloads.sourceforge.net/project/nc${MAJOR_VERSION}/community%20releases/nc${VERSION}.tar.xz"
CHECKSUM="691e734b398bbbe2225feffdd21f63b7"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd nc${MAJOR_VERSION}
}

_build()
{
	make linux
}

_install()
{
	install -m755 nc "$FAKEROOT/$NAME/usr/bin"
	install -m644 nc.1 "$FAKEROOT/$NAME/usr/share/man/man1"
}
