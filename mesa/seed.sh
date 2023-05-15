NAME="mesa"
DESC="OpenGL compatible 3D graphics library"
VERSION="22.3.5"
SOURCE="https://mesa.freedesktop.org/archive/mesa-${VERSION}.tar.xz"
CHECKSUM="fdb35ae46968ce517702037710db6a3f"
DEPS="xorg-libs libdrm mako glslang llvm"
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

	meson setup                   \
		  --prefix=$XORG_PREFIX   \
		  --buildtype=release     \
		  -Dplatforms=x11$(expand_use "wayland" ",wayland") \
		  -Dgallium-drivers=auto  \
		  -Dvalgrind=disabled     \
		  -Dlibunwind=disabled    \
		  ..                      &&

	ninja
}

_install()
{
	ninja install

	# Install docs
	install -v -dm755 $FAKEROOT/$NAME/usr/share/doc/mesa-${VERSION}
	cp -rfv ../docs/* $FAKEROOT/$NAME/usr/share/doc/mesa-${VERSION}
}
