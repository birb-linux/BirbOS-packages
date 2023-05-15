NAME="font-util"
DESC="X.Org font package creation/installation utilities"
VERSION="1.4.0"
SOURCE="https://www.x.org/archive//individual/font/font-util-${VERSION}.tar.xz"
CHECKSUM="ec6cea7a46c96ed6be431dfbbb78f366"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
