NAME="open-tablet-driver"
DESC="Open source, cross-platform, user-mode tablet driver"
VERSION="0.6.3.0"
SOURCE="https://github.com/OpenTabletDriver/OpenTabletDriver/releases/download/v${VERSION}/opentabletdriver-${VERSION}-x64.tar.gz"
CHECKSUM="67cab558c8dfda42a6d71f66ef623209"
DEPS=""
FLAGS="proprietary wip"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd opentabletdriver
}

_build()
{
	printf ""
}

_install()
{
	# make DESTDIR=$FAKEROOT/$NAME install
	cp -r ./{etc,usr} $FAKEROOT/$NAME/
}
