NAME="harfbuzz"
DESC="OpenType text shaping engine"
VERSION="7.1.0"
SOURCE="https://github.com/harfbuzz/harfbuzz/releases/download/${VERSION}/harfbuzz-${VERSION}.tar.xz"
CHECKSUM="761fe38814b74eb6d66f450051604a1f"
DEPS="icu cmake graphite2"
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build &&
	cd    build &&

	meson setup ..            \
		  --prefix=$FAKEROOT/$NAME/usr \
		  --buildtype=release \
		  -Dgraphite2=enabled &&
	ninja
}

_install()
{
	ninja install
}
