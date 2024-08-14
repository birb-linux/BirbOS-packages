# shellcheck disable=SC2034
NAME="stylua"
DESC="An opinionated Lua code formatter"
VERSION="0.20.0"
SOURCE="https://github.com/JohnnyMorganz/StyLua/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="60cb4fa3eb74249e16a557d8b82f4073"
DEPS="rustc"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "StyLua-${VERSION}" || exit 1
}

_build()
{
	cargo build --release
}

_install()
{
	install -vm755 ./target/release/stylua "$FAKEROOT/$NAME/usr/bin/"
	install -vm755 ./target/release/libstylua_lib.so "$FAKEROOT/$NAME/usr/lib/"
}
