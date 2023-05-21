NAME="ccache"
DESC="A fast C/C++ compiler cache"
VERSION="4.8"
SOURCE="https://github.com/ccache/ccache/releases/download/v${VERSION}/ccache-${VERSION}.tar.gz"
CHECKSUM="d1a57363b5371ac1665794c05b5b799b"
DEPS="cmake zstd"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir 	build
	cd 		build

	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FAKEROOT/$NAME/usr" ..
	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Create symlinks so that gcc and g++ use ccache by default
	mkdir -p $FAKEROOT/$NAME/usr/local/bin
	ln -srv $FAKEROOT/$NAME/usr/bin/ccache $FAKEROOT/$NAME/usr/local/bin/gcc
	ln -srv $FAKEROOT/$NAME/usr/bin/ccache $FAKEROOT/$NAME/usr/local/bin/g++
}
