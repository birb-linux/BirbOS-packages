NAME="kmod"
DESC="Libraries and utilities for loading kernel modules"
VERSION="30"
SOURCE="https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-${VERSION}.tar.xz"
CHECKSUM="85202f0740a75eb52f2163c776f9b564"
DEPS="openssl zstd zlib xz"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --sysconfdir=/etc      \
            --with-openssl         \
            --with-xz              \
            --with-zstd            \
            --with-zlib

	make -j${BUILD_JOBS}
}

_install()
{
	make install

	for target in depmod insmod modinfo modprobe rmmod; do
	  ln -sfv ../bin/kmod $FAKEROOT/$NAME/usr/sbin/$target
	done

	ln -sfv kmod $FAKEROOT/$NAME/usr/bin/lsmod

	# nvidia drivers expect to find modprobe from /sbin/modprobe
	ln -srfv $FAKEROOT/$NAME/usr/sbin/modprobe $FAKEROOT/$NAME/sbin/modprobe
}

_build32()
{
	sed -e "s/^CLEANFILES =.*/CLEANFILES =/" -i man/Makefile
	make clean

	LDFLAGS="-L/usr/lib32" CC="gcc -m32" ./configure \
		--host=i686-pc-linux-gnu      \
		--prefix=$FAKEROOT/$NAME/usr  \
		--libdir=/usr/lib32           \
		--sysconfdir=/etc             \
		--with-openssl                \
		--with-xz                     \
		--with-zstd                   \
		--with-zlib                   \
		--with-rootlibdir=/usr/lib32

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
