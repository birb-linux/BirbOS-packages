NAME="duktape"
DESC="Embeddable Javascript engine"
VERSION="2.7.0"
SOURCE="https://duktape.org/duktape-${VERSION}.tar.xz"
CHECKSUM="b3200b02ab80125b694bae887d7c1ca6"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i 's/-Os/-O2/' Makefile.sharedlibrary
	make -j${MAKEOPTS} -f Makefile.sharedlibrary INSTALL_PREFIX=$FAKEROOT/$NAME/usr
}

_install()
{
	make -f Makefile.sharedlibrary INSTALL_PREFIX=$FAKEROOT/$NAME/usr install
}
