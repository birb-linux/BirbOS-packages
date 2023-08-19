NAME="newt"
DESC="Programming library for color text mode, widget based user interfaces"
VERSION="0.52.23"
SOURCE="https://releases.pagure.org/newt/newt-${VERSION}.tar.gz"
CHECKSUM="70aefeff0f3e9444a69dbdae9a931442"
DEPS="popt slang python3 gpm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -e '/install -m 644 $(LIBNEWT)/ s/^/#/' \
    -e '/$(LIBNEWT):/,/rv/ s/^/#/'          \
    -e 's/$(LIBNEWT)/$(LIBNEWTSH)/g'        \
    -i Makefile.in                          &&

	./configure --prefix=/usr           \
				--with-gpm-support      \
				--with-python=python3.11

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
