NAME="cbindgen"
DESC="Generate C bindings for Rust code"
VERSION="0.24.3"
SOURCE="https://github.com/eqrion/cbindgen/archive/v${VERSION}/cbindgen-${VERSION}.tar.gz"
CHECKSUM="6aa2991ca8411f9ebf9961e8b873e884"
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
	install -Dm755 target/release/cbindgen $FAKEROOT/$NAME/usr/bin/
}
