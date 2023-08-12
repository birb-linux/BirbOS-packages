NAME="binutils"
DESC="Linker, an assembler and other tools for handling object files"
VERSION="2.40"
SOURCE="https://sourceware.org/pub/binutils/releases/binutils-${VERSION}.tar.xz"
CHECKSUM="007b59bd908a737c06e5a8d3d2c737eb"
DEPS="zlib"
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir -v build
	cd       build

	../configure --prefix=$FAKEROOT/$NAME/usr \
             --sysconfdir=/etc   \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib  \
             --enable-multilib

	make -j${BUILD_JOBS} tooldir=$FAKEROOT/$NAME/usr

	# Run tests
	#make -j${BUILD_JOBS} -k check

	#echo "List of failed checks"
	#grep '^FAIL:' $(find -name '*.log')

	# TODO:
	# Binutils tests can't be run during building / installation
	# because there are 12 expected test failures and this causes
	# the package not install due to the return value
}

_install()
{
	make tooldir=$FAKEROOT/$NAME/usr install

	# remove useless static libraries and an empty man page
	rm -fv $FAKEROOT/$NAME/usr/lib/lib{bfd,ctf,ctf-nobfd,sframe,opcodes}.a
	rm -fv $FAKEROOT/$NAME/usr/share/man/man1/{gprofng,gp-*}.1
}
