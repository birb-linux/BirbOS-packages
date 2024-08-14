NAME="isl"
DESC="Thread-safe C library for manipulating sets and relations of integer points by affine constraints"
VERSION="0.26"
SOURCE="https://libisl.sourceforge.io/isl-${VERSION}.tar.xz"
CHECKSUM="f2b56e8da688eba89838d414470da85f"
DEPS=""
FLAGS="important"

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

	make -j${BUILD_JOBS}
}

_install()
{
	make install
	install -vd $FAKEROOT/$NAME/usr/share/doc/isl-${VERSION}
	install -m644 doc/{CodingStyle,manual.pdf,SubmittingPatches,user.pod} \
			$FAKEROOT/$NAME/usr/share/doc/isl-${VERSION}

	# Move a misplaced file
	mkdir -pv $FAKEROOT/$NAME/usr/share/gdb/auto-load/usr/lib
	mv -v $FAKEROOT/$NAME/usr/lib/libisl*gdb.py $FAKEROOT/$NAME/usr/share/gdb/auto-load/usr/lib
}
