NAME="hyperfine"
DESC="Command-line benchmarking tool"
VERSION="1.17.0"
SOURCE="https://github.com/sharkdp/hyperfine/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="7955faef77d543bfac16cfb2a240ee9f"
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
	install -vm755 ./target/release/hyperfine $FAKEROOT/$NAME/usr/bin/
}
