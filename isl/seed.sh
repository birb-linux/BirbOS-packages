NAME="isl"
DESC="Thread-safe C library for manipulating sets and relations of integer points by affine constraints"
VERSION="0.24"
SOURCE="https://gcc.gnu.org/pub/gcc/infrastructure/isl-${VERSION}.tar.bz2"
CHECKSUM="dd2f7b78e118c25bd96134a52aae7f4d"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr    \
            --disable-static \
            --docdir=/usr/share/doc/isl-${VERSION}

	make -j$(nproc)
}

_install()
{
	make install
	install -vd $FAKEROOT/$NAME/usr/share/doc/isl-${VERSION}
	install -m644 doc/{CodingStyle,manual.pdf,SubmittingPatches,user.pod} \
			$FAKEROOT/$NAME/usr/share/doc/isl-${VERSION}

	# Move a misplaced file
	mkdir -pv $FAKEROOT/$NAME/usr/share/gdb/auto-load/usr/lib
	mv -v /usr/lib/libisl*gdb.py $FAKEROOT/$NAME/usr/share/gdb/auto-load/usr/lib
}
