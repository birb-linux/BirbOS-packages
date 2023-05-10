NAME="readline"
DESC="Set of libraries that offer command-line editing and history capabilities"
VERSION="8.2"
SOURCE="https://ftp.gnu.org/gnu/readline/readline-${VERSION}.tar.gz"
CHECKSUM="4aa1b31be779e6b84f9a96cb66bc50f6"
DEPS="ncurses"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}

	# Avoid a linking bug in ldconfig
	sed -i '/MV.*old/d' Makefile.in
	sed -i '/{OLDSUFF}/c:' support/shlib-install

	# Fix a problem identified upstream
	patch -Np1 -i $PKG_PATH/readline-8.2-upstream_fix-1.patch
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --disable-static \
            --with-curses    \
            --docdir=/usr/share/doc/readline-${VERSION}

	make -j${MAKEOPTS} SHLIB_LIBS="-lncursesw"
}

_install()
{
	make SHLIB_LIBS="-lncursesw" install

	# Install the documentation
	mkdir -p $FAKEROOT/$NAME/usr/share/doc/readline-${VERSION}
	install -v -m644 doc/*.{ps,pdf,html,dvi} $FAKEROOT/$NAME/usr/share/doc/readline-${VERSION}
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	CC="gcc -m32" ./configure \
		--host=i686-pc-linux-gnu      \
		--prefix=$FAKEROOT/$NAME/usr  \
		--libdir=/usr/lib32           \
		--disable-static              \
		--with-curses

	make -j${MAKEOPTS} SHLIB_LIBS="-lncursesw"
}

_install32()
{
	make SHLIB_LIBS="-lncursesw" DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
