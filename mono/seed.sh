NAME="mono"
DESC="Cross platform, open source .NET framework"
VERSION="6.12.0.199"
SOURCE="https://download.mono-project.com/sources/mono/mono-${VERSION}.tar.xz"
CHECKSUM="fd19b40d565c028905abb7b80da06cc3"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
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
