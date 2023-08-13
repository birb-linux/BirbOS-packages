NAME="gtk+"
DESC="Libraries used for creating graphical user interfaces for applications"
VERSION="3.24.36"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/gtk+/${SHORT_VERSION}/gtk+-${VERSION}.tar.xz"
CHECKSUM="fd4571a112ffaa2fbbb9d25de8f5b6c0"
DEPS="at-spi2-core gdk-pixbuf libepoxy pango sassc libxkbcommon"
FLAGS=""

# TODO: Add gobject-introspection support if GNOME support is needed

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build
	meson setup --prefix=/usr \
				--buildtype=release     \
				-Dman=false             \
				-Dintrospection=false 	\
				-Ddemos=false 			\
				-Dexamples=false 		\
				-Dtests=false 			\
				-Dgtk_doc=false  		\
				-Dwayland_backend=$(expand_use "wayland" "true" "false") \
				-Dbroadway_backend=true \
				..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_post_install()
{
	gtk-query-immodules-3.0 --update-cache
	glib-compile-schemas /usr/share/glib-2.0/schemas
}
