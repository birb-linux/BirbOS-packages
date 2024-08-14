NAME="nerdfetch"
DESC="A POSIX *nix fetch script using Nerdfonts"
VERSION="8.2.0"
SOURCE="https://github.com/ThatOneCalculator/NerdFetch/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="57389fda21880f07f70c08f18e94b0f1"
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
