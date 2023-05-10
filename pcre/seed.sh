NAME="pcre"
DESC="Perl Compatible Regular Expression libraries"
VERSION="8.45"
SOURCE="https://sourceforge.net/projects/pcre/files/pcre/${VERSION}/pcre-${VERSION}.tar.bz2"
CHECKSUM="4452288e6a0eefb2ab11d36010a1eebb"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr  \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/pcre-${VERSION} \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --enable-pcretest-libreadline     \
            --disable-static

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make check
}
