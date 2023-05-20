NAME="xorgproto"
DESC="Header files required to build the X Window system"
VERSION="2022.2"
SOURCE="https://xorg.freedesktop.org/archive/individual/proto/xorgproto-${VERSION}.tar.xz"
CHECKSUM="3fdb11d75f7023db273f7b3e34b58338"
DEPS="util-macros"
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

	meson --prefix=$XORG_PREFIX -Dlegacy=true ..
	ninja
}

_install()
{
	ninja install
	mv -v $XORG_PREFIX/share/doc/xorgproto{,-${VERSION}}

	# Make sure that this package doesn't take over the
	# /usr/include/X11/extensions directory
	mkdir -p /usr/include/X11/extensions
	touch /usr/include/X11/extensions/.birb_symlink_lock

	# Remove a few files that will get overwritten anyway by libx11 and libxvmc
	rm -v $FAKEROOT/$NAME/usr/include/X11/extensions/{XKBgeom.h,vldXvMC.h}
}

_build32()
{
	# Start from a clean source tree
	cd ..
	rm -r build

	mkdir build
	cd    build

   PKG_CONFIG_PATH="/usr/lib32/pkgconfig" CC="gcc -m32" CXX="g++ -m32" meson setup  --prefix=$XORG_PREFIX \
                 --libdir=/usr/lib32 \
				 --buildtype=release \
				 -Dlegacy=true \
				 ..
	ninja
}

_install32()
{
	DESTDIR=$PWD/DESTDIR ninja install
	mkdir -pv $FAKEROOT/$NAME/usr/lib32/pkgconfig
	cp -Rv DESTDIR/$FAKEROOT/$NAME/usr/share/pkgconfig/* $FAKEROOT/$NAME/usr/lib32/pkgconfig/
	rm -rf DESTDIR
}
