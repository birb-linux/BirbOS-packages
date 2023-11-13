NAME="exa"
DESC="A modern replacement for ‘ls’"
VERSION="0.10.1"
SOURCE="https://github.com/ogham/exa/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="01f0ac8192de592f8db0acc99c101429"
DEPS="rustc"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	cargo build --release
}

_install()
{
	install -vm755 ./target/release/exa $FAKEROOT/$NAME/usr/bin/
}
