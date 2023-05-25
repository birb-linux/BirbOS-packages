NAME="font-jis-misc"
DESC="X.Org JIS (japanese) fonts"
VERSION="1.0.4"
SOURCE="https://gitlab.freedesktop.org/xorg/font/jis-misc/-/archive/font-jis-misc-${VERSION}/jis-misc-font-jis-misc-${VERSION}.tar.gz"
CHECKSUM="06bfe204d605a7fa9a3908b4fe12bf49"
DEPS="bdftopcf font-util"
FLAGS="font"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd jis-misc-font-jis-misc-${VERSION}
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr --with-fontrootdir=/usr/share/fonts/font-jis-misc
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
