NAME="libdrm"
DESC="Userspace library for accessing the direct rendering manager (DRM)"
VERSION="2.4.115"
SOURCE="https://dri.freedesktop.org/libdrm/libdrm-${VERSION}.tar.xz"
CHECKSUM="5403981a20c964f4c893ff91393652bd"
DEPS="xorg-libs"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson setup  --prefix=$XORG_PREFIX \
				 --buildtype=release   \
				 -Dudev=true           \
				 -Dtests=false         \
				 -Dcairo-tests=disabled \
				 -Dvalgrind=disabled
	ninja
}

_install()
{
	ninja install
}


_build32()
{
	cd ..
	rm -r 	build
	mkdir 	build
	cd 		build

	LDFLAGS="-L/usr/lib32" CC="gcc -m32" CXX="g++ -m32" meson setup  --prefix=$XORG_PREFIX \
                 --libdir=/usr/lib32 \
				 --buildtype=release   \
				 -Dudev=true           \
				 -Dtests=false \
				 -Dcairo-tests=disabled \
				 -Dintel=enabled \
				 -Dradeon=enabled \
				 -Dvalgrind=disabled
	ninja
}

_install32()
{
	DESTDIR=$PWD/DESTDIR ninja install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
