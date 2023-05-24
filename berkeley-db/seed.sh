NAME="berkeley-db"
DESC="Programs and utilities used by many other applications for database related functions"
VERSION="5.3.28"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/bdb/db-${VERSION}.tar.gz"
CHECKSUM="b99454564d5b4479750567031d66fe24"
DEPS="tcl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd db-${VERSION}
}

_build()
{
	# Apply a fix to compatibility issues with the current g++ version
	sed -i 's/\(__atomic_compare_exchange\)/\1_db/' src/dbinc/atomic.h

	cd build_unix
	../dist/configure --prefix=/usr       \
					  --enable-compat185  \
					  --enable-dbm        \
					  --disable-static    \
					  --enable-tcl        \
					  --with-tcl=/usr/lib \
					  --enable-cxx

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME docdir=/usr/share/doc/db-${VERSION} install

	chown -v -R root:root \
      $FAKEROOT/$NAME/usr/bin/db_*                 \
      $FAKEROOT/$NAME/usr/include/db{,_185,_cxx}.h \
      $FAKEROOT/$NAME/usr/lib/libdb*.{so,la}       \
      $FAKEROOT/$NAME/usr/share/doc/db-${VERSION}
}
