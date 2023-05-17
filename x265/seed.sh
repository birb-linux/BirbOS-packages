NAME="x265"
DESC="Library for encoding video streams into the H.265/HEVC format"
VERSION="20230215"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/x265/x265-${VERSION}.tar.xz"
CHECKSUM="e735837f5e3fa95889e0a72eca39fccf"
DEPS="cmake nasm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr \
		  -DGIT_ARCHETYPE=1           \
		  -Wno-dev ../source

	make -j${MAKEOPTS}
}

_install()
{
	make install

	# Get rid of a static library
	rm -vf $FAKEROOT/$NAME/usr/lib/libx265.a
}
