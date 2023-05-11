NAME="lynx"
DESC="Text based web browser"
VERSION="2.8.9rel.1"
SOURCE="https://invisible-mirror.net/archives/lynx/tarballs/lynx${VERSION}.tar.bz2"
CHECKSUM="44316f1b8a857b59099927edc26bef79"
DEPS="zlib openssl ncurses"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}${VERSION}
}

_build()
{
	# Fix a security vulnerability
	patch -p1 -i $PKG_PATH/lynx-2.8.9rel.1-security_fix-1.patch

	./configure --prefix=$FAKEROOT/$NAME/usr \
            --sysconfdir=/etc/lynx \
            --datadir=$FAKEROOT/$NAME/usr/share/doc/lynx-${VERSION} \
            --with-zlib            \
            --with-bzlib           \
            --with-ssl             \
            --with-screen=ncursesw \
            --enable-locale-charset

	make -j${MAKEOPTS}
}

_install()
{
	make install-full
	chgrp -v -R root $FAKEROOT/$NAME/usr/share/doc/lynx-${VERSION}/lynx_doc
}
