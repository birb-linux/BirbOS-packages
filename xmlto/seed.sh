NAME="xmlto"
DESC="Front-end to a XSL toolchain"
VERSION="0.0.28"
SOURCE="https://releases.pagure.org/xmlto/xmlto-${VERSION}.tar.bz2"
CHECKSUM="93bab48d446c826399d130d959fe676f"
DEPS="docbook-xml docbook-xsl-nons libxslt links"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	LINKS="/usr/bin/links" \
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}

_test()
{
	make -j${BUILD_JOBS} check
}
