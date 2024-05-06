NAME="mesa"
DESC="OpenGL compatible 3D graphics library"
VERSION="24.0.1"
SOURCE="https://mesa.freedesktop.org/archive/mesa-${VERSION}.tar.xz"
CHECKSUM="9e7fa53b68fa6b60dba0bbfa8da7d0a9"
DEPS="xorg-libs libdrm mako glslang llvm meson ninja"
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
		  --prefix=/usr           \
		  --buildtype=release     \
		  -Dplatforms=x11$(expand_use "wayland" ",wayland") \
		  -Dgallium-drivers=auto  \
		  -Dvalgrind=disabled     \
		  -Dlibunwind=disabled    \
		  -Dglvnd=true            \
		  ..

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install

	# Install docs
	install -v -dm755 $FAKEROOT/$NAME/usr/share/doc/mesa-${VERSION}
	cp -rfv ../docs/* $FAKEROOT/$NAME/usr/share/doc/mesa-${VERSION}

	# If the nvidia drivers have been installed, skip installing some libraries
	if [ "$(birb_db --is-installed "nvidia-drivers")" == "yes" ]
	then
		rm -v $FAKEROOT/$NAME/usr/lib/libEGL.so
		rm -v $FAKEROOT/$NAME/usr/lib/libEGL.so.1
		rm -v $FAKEROOT/$NAME/usr/lib/libGL.so
		rm -v $FAKEROOT/$NAME/usr/lib/libGL.so.1
		rm -v $FAKEROOT/$NAME/usr/lib/libGLESv1_CM.so
		rm -v $FAKEROOT/$NAME/usr/lib/libGLESv1_CM.so.1
		rm -v $FAKEROOT/$NAME/usr/lib/libGLESv2.so
		rm -v $FAKEROOT/$NAME/usr/lib/libGLESv2.so.2
	fi
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
                 -Dglvnd=true            \
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

	# If the nvidia drivers have been installed, skip installing some libraries
	if [ "$(birb_db --is-installed "nvidia-drivers")" == "yes" ]
	then
		rm -v $FAKEROOT/$NAME/usr/lib32/libEGL.so
		rm -v $FAKEROOT/$NAME/usr/lib32/libEGL.so.1
		rm -v $FAKEROOT/$NAME/usr/lib32/libGL.so
		rm -v $FAKEROOT/$NAME/usr/lib32/libGL.so.1
		rm -v $FAKEROOT/$NAME/usr/lib32/libGLESv1_CM.so
		rm -v $FAKEROOT/$NAME/usr/lib32/libGLESv1_CM.so.1
		rm -v $FAKEROOT/$NAME/usr/lib32/libGLESv2.so
		rm -v $FAKEROOT/$NAME/usr/lib32/libGLESv2.so.2
	fi
}
