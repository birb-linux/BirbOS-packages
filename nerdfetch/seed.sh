NAME="nerdfetch"
DESC="A POSIX *nix fetch script using Nerdfonts"
VERSION="8.1.1"
SOURCE="https://github.com/ThatOneCalculator/NerdFetch/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="fd80aa26a4253ee529dde12d58cb04c8"
DEPS="which"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd NerdFetch-${VERSION}
}

_build()
{
	chmod +x "$NAME"
}

_install()
{
	cp -v "$NAME" "$FAKEROOT/$NAME/usr/bin/"
}
