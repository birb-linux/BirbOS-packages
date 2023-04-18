NAME="bzip2"
DESC="Programs for compressing and decompressing files"
VERSION="1.0.8"
SOURCE="https://www.sourceware.org/pub/bzip2/bzip2-${VERSION}.tar.gz"
CHECKSUM="67e051268d0c475ea773822f7500d0e5"
DEPS=""
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}

	# Apply a patch that will install the documentation
	patch -Np1 -i $PKG_PATH/bzip2-1.0.8-install_docs-1.patch

	# Make sure that symbolic links are relative
	sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

	# Make sure that man pages are installed into the correct location
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
}

_build()
{
	make -f Makefile-libbz2_so
	make clean

	make -j$(nproc)
}

_install()
{
	make PREFIX=$FAKEROOT/$NAME/usr install

	cp -av libbz2.so.* $FAKEROOT/$NAME/usr/lib
	ln -sv libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/lib/libbz2.so

	cp -v bzip2-shared $FAKEROOT/$NAME/usr/bin/bzip2
	for i in $FAKEROOT/$NAME/usr/bin/{bzcat,bunzip2}; do
	  ln -sfv bzip2 $i
	done

	# Remove a useless static library
	rm -fv /usr/lib/libbz2.a
}

_build32()
{
	make clean

	sed -e "s/^CC=.*/CC=gcc -m32/" -i Makefile{,-libbz2_so}
	make -f Makefile-libbz2_so
	make -j$(nproc) libbz2.a
}

_install32()
{
	install -Dm755 libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/lib32/libbz2.so.1.0.8
	ln -sf libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/lib32/libbz2.so
	ln -sf libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/lib32/libbz2.so.1
	ln -sf libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/lib32/libbz2.so.1.0
	install -Dm644 libbz2.a $FAKEROOT/$NAME/usr/lib32/libbz2.a
}

_buildx32()
{
	make clean

	sed -e "s/^CC=.*/CC=gcc -mx32/" -i Makefile{,-libbz2_so}
	make -f Makefile-libbz2_so
	make -j$(nproc) libbz2.a
}

_installx32()
{
	install -Dm755 libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/libx32/libbz2.so.1.0.8
	ln -sf libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/libx32/libbz2.so
	ln -sf libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/libx32/libbz2.so.1
	ln -sf libbz2.so.1.0.8 $FAKEROOT/$NAME/usr/libx32/libbz2.so.1.0
	install -Dm644 libbz2.a $FAKEROOT/$NAME/usr/libx32/libbz2.a
}
