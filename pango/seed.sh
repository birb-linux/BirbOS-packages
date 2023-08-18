NAME="pango"
DESC="Library for laying out and rendering text, with an emphasis on internationalization"
VERSION="1.50.12"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/pango/${SHORT_VERSION}/pango-${VERSION}.tar.xz"
CHECKSUM="fd4b0b23915d6a0255317f811bea4215"
DEPS="fontconfig freetype harfbuzz fribidi glib cairo xorg-libs"
FLAGS=""

# TODO: Add gobject-introspection dependency to this package is GNOME support is needed

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=/usr --buildtype=release \
		--wrap-mode=nofallback 	\
		-Dcairo=enabled 		\
		-Dfontconfig=enabled 	\
		-Dfreetype=enabled 		\
		-Dgtk_doc=false  		\
		-Dinstall-tests=false 	\
		-Dlibthai=disabled 		\
		-Dintrospection=disabled ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install

	# Install gir files yoinked from gentoo
	mkdir -p $FAKEROOT/$NAME/usr/share/gir-1.0
	cp $PKG_PATH/gir_files/* $FAKEROOT/$NAME/usr/share/gir-1.0
}
