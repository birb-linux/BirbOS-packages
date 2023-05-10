NAME="libvorbis"
DESC="General purpose audio and music encoding format"
VERSION="1.3.7"
SOURCE="https://downloads.xiph.org/releases/vorbis/libvorbis-${VERSION}.tar.xz"
CHECKSUM="50902641d358135f06a8392e61c9ac77"
DEPS="libogg"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j$(nproc)
}

_install()
{
	make install
	install -v -m644 doc/Vorbis* $FAKEROOT/$NAME/usr/share/doc/libvorbis-${VERSION}
}

_test()
{
	make -j1 check
}
