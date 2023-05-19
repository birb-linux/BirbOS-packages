NAME="mesa"
DESC="OpenGL compatible 3D graphics library"
VERSION="22.3.5"
SOURCE="https://mesa.freedesktop.org/archive/mesa-${VERSION}.tar.xz"
CHECKSUM="fdb35ae46968ce517702037710db6a3f"
DEPS="xorg-libs libdrm mako glslang llvm"
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

	meson setup                   \
		  --prefix=$XORG_PREFIX   \
		  --buildtype=release     \
		  -Dplatforms=x11$(expand_use "wayland" ",wayland") \
		  -Dgallium-drivers=auto  \
		  -Dvalgrind=disabled     \
		  -Dlibunwind=disabled    \
		  ..

	ninja
}

_install()
{
	ninja install

	# Install docs
	install -v -dm755 $FAKEROOT/$NAME/usr/share/doc/mesa-${VERSION}
	cp -rfv ../docs/* $FAKEROOT/$NAME/usr/share/doc/mesa-${VERSION}
}

_build32()
{
	# Start from a clean source tree
	cd ../..
	rm -r ${NAME}-${VERSION}
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}

	mkdir build
	cd    build

	PKG_CONFIG_PATH="/usr/lib32/pkgconfig" CXXFLAGS="-L/usr/lib32" CFLAGS="-L/usr/lib32" LDFLAGS="-L/usr/lib32" LD_LIBRARY_PATH="/usr/lib32" CC="gcc -m32" CXX="g++ -m32" meson setup  --prefix=$XORG_PREFIX \
                 --libdir=/usr/lib32 \
				 --buildtype=release     \
				 -Dplatforms=x11$(expand_use "wayland" ",wayland") \
				 -Dgallium-drivers=auto  \
				 -Dvalgrind=disabled     \
				 -Dlibunwind=disabled    \
				 ..

	# meson is stubborn and doesn't want to link against 32bit
	# llvm libraries, so lets force it into doing that
	sed -i 's/\/usr\/lib\//\/usr\/lib32\//g' ./build.ninja

	ninja
}

_install32()
{
	DESTDIR=$PWD/DESTDIR ninja install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
