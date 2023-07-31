NAME="icu"
DESC="International Components for Unicode"
VERSION="73_1"
SOURCE="https://github.com/unicode-org/icu/releases/download/release-$(echo "$VERSION" | cut -d'_' -f1)-$(echo "$VERSION" | cut -d'_' -f2)/icu4c-${VERSION}-src.tgz"
CHECKSUM="c1f94c7865846eaecbbef8546aa8126b"
DEPS=""
FLAGS="32bit test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd icu
}

_build()
{
	cd source

	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}

_build32()
{
	make distclean

	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
