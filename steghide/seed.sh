NAME="steghide"
DESC="Steganography program that is able to hide data in various kinds of image- and audio-files"
VERSION="0.5.1"
SOURCE="http://prdownloads.sourceforge.net/steghide/steghide-${VERSION}.tar.gz"
CHECKSUM="5be490e24807d921045780fd8cc446b3"
DEPS="libjpeg-turbo mhash libmcrypt zlib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)

	# Apply some patches to make steghide compile with the current version
	# of GCC. The patch isn't official or anything, so it might not be
	# perfect
	patch -u -Np2 -d ./${NAME}-${VERSION} -i $PKG_PATH/steghide-${VERSION}_fixes.patch
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
