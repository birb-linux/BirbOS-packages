NAME="libcanberra"
DESC="Implementation of the XDG Sound Theme and Name Specifications"
VERSION="0.30"
SOURCE="https://0pointer.de/lennart/projects/libcanberra/libcanberra-${VERSION}.tar.xz"
CHECKSUM="34cb7e4430afaf6f447c4ebdb9b42072"
DEPS="libvorbis alsa-lib gstreamer gtk+"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Apply a patch that fixes crashing issues in wayland
	patch -Np1 -i $PKG_PATH/libcanberra-0.30-wayland-1.patch

	./configure --prefix=$FAKEROOT/$NAME/usr --disable-oss
	make -j${MAKEOPTS}
}

_install()
{
	make docdir=$FAKEROOT/$NAME/usr/share/doc/libcanberra-${VERSION} install
}
