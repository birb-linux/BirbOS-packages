NAME="libdrm"
DESC="Userspace library for accessing the direct rendering manager (DRM)"
VERSION="2.4.120"
SOURCE="https://dri.freedesktop.org/libdrm/libdrm-${VERSION}.tar.xz"
CHECKSUM="f8521de37ccbd15987b843a83fabd567"
DEPS="xorg-libs meson ninja"
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
