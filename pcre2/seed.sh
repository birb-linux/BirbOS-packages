NAME="pcre2"
DESC="New generation of the Perl Compatible Regular Expression libraries"
VERSION="10.42"
SOURCE="https://github.com/PCRE2Project/pcre2/releases/download/pcre2-${VERSION}/pcre2-${VERSION}.tar.bz2"
CHECKSUM="a8e9ab2935d428a4807461f183034abe"
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
            --docdir=$FAKEROOT/$NAME/usr/share/doc/pcre2-${VERSION} \
            --enable-unicode                    \
            --enable-jit                        \
            --enable-pcre2-16                   \
            --enable-pcre2-32                   \
            --enable-pcre2grep-libz             \
            --enable-pcre2grep-libbz2           \
            --enable-pcre2test-libreadline      \
            --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_build32()
{
	make distclean

	./configure \
            --enable-unicode                    \
            --enable-jit                        \
            --enable-pcre2-16                   \
            --enable-pcre2-32                   \
            --enable-pcre2grep-libz             \
            --enable-pcre2grep-libbz2           \
            --enable-pcre2test-libreadline      \
            --disable-static

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/local/lib/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
