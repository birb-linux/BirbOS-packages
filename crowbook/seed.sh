NAME="crowbook"
DESC="Converts books written in Markdown to HTML, LaTeX/PDF and EPUB"
VERSION="0.16.1"
SOURCE="https://github.com/lise-henry/crowbook/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="4b519919b69c07ac4e1c1cc636875ea3"
DEPS="cmake rustc"
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
	install -vm755 ./target/release/crowbook $FAKEROOT/$NAME/usr/bin/
}
