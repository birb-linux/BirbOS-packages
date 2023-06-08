NAME="jisho-cli"
DESC="CLI interface for jisho.org"
VERSION="1.0"
SOURCE="https://github.com/Toasterbirb/jisho-cli/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="fd8c1725b0321fb6471112aa4cc6f7ab"
DEPS="jq curl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	chmod +x ./jisho
}

_install()
{
	cp ./jisho -v $FAKEROOT/$NAME/usr/bin/jisho
}
