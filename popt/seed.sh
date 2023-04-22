NAME="popt"
DESC="Libraries for parsing command-line options"
VERSION="1.19"
SOURCE="http://ftp.rpm.org/popt/releases/popt-1.x/popt-${VERSION}.tar.gz"
CHECKSUM="eaa2135fddb6eb03f2c87ee1823e5a78"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j$(nproc)
}

_install()
{
	make install
}
