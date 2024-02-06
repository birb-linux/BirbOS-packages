NAME="ripgrep"
DESC="ripgrep recursively searches directories for a regex pattern while respecting your gitignore"
VERSION="14.0.3"
SOURCE="https://github.com/BurntSushi/ripgrep/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="55b5b8495a124ae0516372fcae46eeee"
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
	install -vm755 ./target/release/rg $FAKEROOT/$NAME/usr/bin/
}
