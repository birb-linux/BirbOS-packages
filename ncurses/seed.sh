NAME="ncurses"
DESC="Libraries for terminal-independent handling of character screens"
VERSION="6.4"
SOURCE="https://invisible-mirror.net/archives/ncurses/ncurses-${VERSION}.tar.gz"
CHECKSUM="5a62487b5d4ac6b132fe2bf9f8fad29b"
DEPS=""
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --mandir=/usr/share/man 			\
            --with-shared           			\
            --without-debug         			\
            --without-normal        			\
            --with-cxx-shared       			\
            --enable-pc-files       			\
            --enable-widec          			\
            --with-pkg-config-libdir=/usr/lib/pkgconfig

	make -j$(nproc)
}

_install()
{
	make DESTDIR=$PWD/dest install
	install -vm755 dest/$FAKEROOT/$NAME/usr/lib/libncursesw.so.6.4 $FAKEROOT/$NAME/usr/lib
	rm -v  dest/$FAKEROOT/$NAME/usr/lib/libncursesw.so.6.4
	cp -av dest/* $FAKEROOT/$NAME/

	# Trick applications into linking with wide-character libraries
	for lib in ncurses form panel menu ; do
		rm -vf                    $FAKEROOT/$NAME/usr/lib/lib${lib}.so
		echo "INPUT(-l${lib}w)" > $FAKEROOT/$NAME/usr/lib/lib${lib}.so
		ln -sfv ${lib}w.pc        $FAKEROOT/$NAME/usr/lib/pkgconfig/${lib}.pc
	done

	# Make sure that old applications that look for -lcurses can still build
	rm -vf                     $FAKEROOT/$NAME/usr/lib/libcursesw.so
	echo "INPUT(-lncursesw)" > $FAKEROOT/$NAME/usr/lib/libcursesw.so
	ln -sfv libncurses.so      $FAKEROOT/$NAME/usr/lib/libcurses.so

	# Install the documentation
	mkdir -pv      $FAKEROOT/$NAME/usr/share/doc/ncurses-6.4
	cp -v -R doc/* $FAKEROOT/$NAME/usr/share/doc/ncurses-6.4
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	CC="gcc -m32" CXX="g++ -m32" \
	./configure --prefix=$FAKEROOT/$NAME/usr    \
				--host=i686-pc-linux-gnu 		\
				--libdir=/usr/lib32     		\
				--mandir=/usr/share/man 		\
				--with-shared           		\
				--without-debug         		\
				--without-normal        		\
				--with-cxx-shared       		\
				--enable-pc-files       		\
				--enable-widec          		\
				--with-pkg-config-libdir=/usr/lib32/pkgconfig

	make -j$(nproc)
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	mkdir -p DESTDIR/usr/lib32/pkgconfig
	for lib in ncurses form panel menu ; do
		rm -vf                    DESTDIR/usr/lib32/lib${lib}.so
		echo "INPUT(-l${lib}w)" > DESTDIR/usr/lib32/lib${lib}.so
		ln -svf ${lib}w.pc        DESTDIR/usr/lib32/pkgconfig/$lib.pc
	done
	rm -vf                     DESTDIR/usr/lib32/libcursesw.so
	echo "INPUT(-lncursesw)" > DESTDIR/usr/lib32/libcursesw.so
	ln -sfv libncurses.so      DESTDIR/usr/lib32/libcurses.so
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}

_buildx32()
{
	make distclean

	CC="gcc -mx32" CXX="g++ -mx32" \
	./configure --prefix=$FAKEROOT/$NAME/usr   	\
				--host=x86_64-pc-linux-gnux32 	\
				--libdir=/usr/libx32    		\
				--mandir=/usr/share/man 		\
				--with-shared           		\
				--without-debug         		\
				--without-normal        		\
				--enable-pc-files       		\
				--enable-widec          		\
				--with-pkg-config-libdir=/usr/libx32/pkgconfig

	make -j$(nproc)
}

_installx32()
{
	make DESTDIR=$PWD/DESTDIR install
	mkdir -p DESTDIR/usr/libx32/pkgconfig
	for lib in ncurses form panel menu ; do
		rm -vf                    DESTDIR/usr/libx32/lib${lib}.so
		echo "INPUT(-l${lib}w)" > DESTDIR/usr/libx32/lib${lib}.so
		ln -svf ${lib}w.pc        DESTDIR/usr/libx32/pkgconfig/$lib.pc
	done
	rm -vf                     DESTDIR/usr/libx32/libcursesw.so
	echo "INPUT(-lncursesw)" > DESTDIR/usr/libx32/libcursesw.so
	ln -sfv libncurses.so      DESTDIR/usr/libx32/libcurses.so
	cp -Rv DESTDIR/usr/libx32/* $FAKEROOT/$NAME/usr/libx32
	rm -rf DESTDIR
}
