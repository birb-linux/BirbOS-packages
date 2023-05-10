NAME="fontconfig"
DESC="Library and support programs used for configuring and customizing font access"
VERSION="2.14.2"
SOURCE="https://www.freedesktop.org/software/fontconfig/release/fontconfig-${VERSION}.tar.xz"
CHECKSUM="95261910ea727b5dd116b06fbfd84b1f"
DEPS="freetype"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-docs       \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/fontconfig-${VERSION}

	make -j$(nproc)
}

_install()
{
	make install

	# Install some pre-generated documentation
	install -v -dm755 \
        $FAKEROOT/$NAME/usr/share/{man/man{1,3,5},doc/fontconfig-${VERSION}/fontconfig-devel}
	install -v -m644 fc-*/*.1         $FAKEROOT/$NAME/usr/share/man/man1
	install -v -m644 doc/*.3          $FAKEROOT/$NAME/usr/share/man/man3
	install -v -m644 doc/fonts-conf.5 $FAKEROOT/$NAME/usr/share/man/man5
	install -v -m644 doc/fontconfig-devel/* \
									  $FAKEROOT/$NAME/usr/share/doc/fontconfig-${VERSION}/fontconfig-devel
	install -v -m644 doc/*.{pdf,sgml,txt,html} \
									  $FAKEROOT/$NAME/usr/share/doc/fontconfig-${VERSION}
}
