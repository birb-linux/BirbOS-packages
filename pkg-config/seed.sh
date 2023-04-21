NAME="pkg-config"
DESC="Tool for passing the include path and/or library paths to build tools"
VERSION="0.29.2"
SOURCE="https://pkg-config.freedesktop.org/releases/pkg-config-${VERSION}.tar.gz"
CHECKSUM="f6e931e319531b736fadc017f470e68a"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --with-internal-glib       \
            --disable-host-tool        \
			--with-pc-path="/usr/lib/pkgconfig:/usr/lib32/pkgconfig" \
            --docdir=/usr/share/doc/pkg-config-${VERSION}

	make -j$(nproc)
}

_install()
{
	make install
}

# If the package has any tests, run them here
# To enable this function, specify the 'test' flag
#
# Also, birb needs to be run with special arguments to run tests
# when installing packages
_test()
{
	make -j$(nproc) check
}
