NAME="util-linux"
DESC="Miscellaneous utility programs"
VERSION="2.38.1"
SHORT_VER="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://www.kernel.org/pub/linux/utils/util-linux/v${SHORT_VER}/util-linux-${VERSION}.tar.xz"
CHECKSUM="cd11456f4ddd31f7fbfdd9488c0c0d02"
DEPS=""
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --bindir=$FAKEROOT/$NAME/usr/bin    \
            --libdir=$FAKEROOT/$NAME/usr/lib    \
            --sbindir=$FAKEROOT/$NAME/sbin  \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            --without-systemd    \
            --without-systemdsystemunitdir \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/util-linux-${VERSION}

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	# Avoid path issues with multilib builds
	mv /usr/bin/ncursesw6-config{,.tmp}

	CC="gcc -m32" \
	./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
				--host=i686-pc-linux-gnu \
				--libdir=/usr/lib32      \
				--docdir=$FAKEROOT/$NAME/usr/share/doc/util-linux-${VERSION} \
				--disable-chfn-chsh      \
				--disable-login          \
				--disable-nologin        \
				--disable-su             \
				--disable-setpriv        \
				--disable-runuser        \
				--disable-pylibmount     \
				--disable-static         \
				--without-python         \
				--without-systemd        \
				--without-systemdsystemunitdir

	# Restore the previously moved files back into their correct places
	mv /usr/bin/ncursesw6-config{.tmp,}

	make -j${MAKEOPTS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
