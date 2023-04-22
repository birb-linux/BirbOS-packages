NAME="libxml2"
DESC="Libraries and utilities for parsing XML files"
VERSION="2.10.4"
SOURCE="https://download.gnome.org/sources/libxml2/$(echo "$VERSION" | awk -F '.' '{print $1 "." $2}')/libxml2-${VERSION}.tar.xz"
CHECKSUM="76808c467a58c31e2dbd511e71d5fd13"
DEPS="icu"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --sysconfdir=/etc       \
            --disable-static        \
            --with-history          \
            --with-icu              \
            PYTHON=/usr/bin/python3 \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/libxml2-${VERSION}

	make -j$(nproc)
}

_install()
{
	make install
}
