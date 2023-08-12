NAME="gtk+-2"
DESC="Libraries used for creating graphical user interfaces for applications"
VERSION="2.24.33"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/gtk+/${SHORT_VERSION}/gtk+-${VERSION}.tar.xz"
CHECKSUM="0118e98dbe0e4dab90ce475f9f0e6c0c"
DEPS="at-spi2-core gdk-pixbuf pango"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd gtk+-${VERSION}
}

_build()
{
	sed -e 's#l \(gtk-.*\).sgml#& -o \1#' \
		-i docs/{faq,tutorial}/Makefile.in

	# Disable LTO
	CFLAGS="$CFLAGS -fno-lto"
	CXXFLAGS="$CXXFLAGS -fno-lto"

	./configure --prefix=/usr --sysconfdir=/etc

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Don't overwrite icon cache installed by gtk+ version 3
	rm -v $FAKEROOT/$NAME/usr/bin/gtk-update-icon-cache
}

_test()
{
	make -k check
}

_post_install()
{
	gtk-query-immodules-2.0 --update-cache
}
