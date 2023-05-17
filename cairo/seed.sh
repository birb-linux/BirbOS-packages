NAME="cairo"
DESC="2D graphics library with support for multiple output devices"
VERSION="1.17.6"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/cairo/${SHORT_VERSION}/cairo-${VERSION}.tar.xz"
CHECKSUM="c5a6f255af72a2e5faa8e6a53dd882e2"
DEPS="xorg-libs libpng pixman fontconfig glib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Adapt this package for modern binutils versions
	sed 's/PTR/void */' -i util/cairo-trace/lookup-symbol.c

	# Fix an issue with pkg-config
	sed -e "/@prefix@/a exec_prefix=@exec_prefix@" \
		-i util/cairo-script/cairo-script-interpreter.pc.in

	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --disable-static \
            --enable-tee

	make -j${MAKEOPTS}
}

_install()
{
	make install
}
