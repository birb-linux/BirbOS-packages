NAME="nano"
DESC="Small, simple text editor"
VERSION="7.2"
MAJOR_VERSION="$(echo $VERSION | cut -d'.' -f1)"
SOURCE="https://www.nano-editor.org/dist/v${MAJOR_VERSION}/nano-${VERSION}.tar.xz"
CHECKSUM="13742c686c6ddb0b7b294634f0c13cec"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --sysconfdir=/etc \
            --enable-utf8     \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/nano-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
	install -v -m644 doc/{nano.html,sample.nanorc} $FAKEROOT/$NAME/usr/share/doc/nano-${VERSION}
}
