NAME="scrot"
DESC="SCReenshOT - command line screen capture utility"
VERSION="1.9"
SOURCE="https://github.com/resurrecting-open-source-projects/scrot/releases/download/${VERSION}/scrot-${VERSION}.tar.gz"
CHECKSUM="40248784cf1ff9251d6eaa967310fcbe"
DEPS="autoconf autoconf-archive pkg-config imlib2 libxext libxfixes libxinerama xorg-server"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
