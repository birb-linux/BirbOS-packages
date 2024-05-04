NAME="cairo"
DESC="2D graphics library with support for multiple output devices"
VERSION="1.18.0"
SOURCE="https://www.cairographics.org/releases/cairo-${VERSION}.tar.xz"
CHECKSUM="3f0685fbadc530606f965b9645bb51d9"
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

	./configure --prefix=/usr    \
            --disable-static \
            --enable-tee

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
