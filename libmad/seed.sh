NAME="libmad"
DESC="High-quality MPEG audio decoder capable of 24-bit output"
VERSION="0.15.1b"
SOURCE="https://downloads.sourceforge.net/mad/libmad-${VERSION}.tar.gz"
CHECKSUM="1be543bc30c56fb6bea1d7bf6a64e66c"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Apply a patch that fixes build and optimization issues
	patch -Np1 -i $PKG_PATH/libmad-0.15.1b-fixes-1.patch

	sed "s@AM_CONFIG_HEADER@AC_CONFIG_HEADERS@g" -i configure.ac
	touch NEWS AUTHORS ChangeLog
	autoreconf -fi

	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Create a pkg-config file for libmad
	mkdir -p $FAKEROOT/$NAME/usr/lib/pkgconfig
	cat > $FAKEROOT/$NAME/usr/lib/pkgconfig/mad.pc << "EOF"
prefix=/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: mad
Description: MPEG audio decoder
Requires:
Version: 0.15.1b
Libs: -L${libdir} -lmad
Cflags: -I${includedir}
EOF
}
