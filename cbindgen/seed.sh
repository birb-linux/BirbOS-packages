NAME="cbindgen"
DESC="Generate C bindings for Rust code"
VERSION="0.26.0"
SOURCE="https://github.com/eqrion/cbindgen/archive/v${VERSION}/cbindgen-${VERSION}.tar.gz"
CHECKSUM="f3ef70691bc4743b8f76ca6d27847ba4"
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
