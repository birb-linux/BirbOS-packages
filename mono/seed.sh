NAME="mono"
DESC="Cross platform, open source .NET framework"
VERSION="6.12.0.199"
SOURCE="https://download.mono-project.com/sources/mono/mono-${VERSION}.tar.xz"
CHECKSUM="fd19b40d565c028905abb7b80da06cc3"
DEPS="cmake"
FLAGS=""

_setup()
{
	# Make sure that /var/tmp/mono doesn't exist
	rm -rf /var/tmp/mono

	# Build in /var/tmp/mono to avoid going over the /bin/sh arg length limit
	mkdir -vp /var/tmp/mono
	cd /var/tmp/mono || exit

	tar -xf $DISTFILES/$(basename $SOURCE)

	# Make the extracted directory name shorter
	mv -v "$NAME-$VERSION" m

	cd m || exit
}

_build()
{
	./configure --prefix=/usr
	make get-monolite-latest
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
