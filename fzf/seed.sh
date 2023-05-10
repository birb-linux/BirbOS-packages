NAME="fzf"
DESC="General-purpose command-line fuzzy finder"
VERSION="0.40.0"
SOURCE="https://github.com/junegunn/fzf/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="42ef06b3f318d7afb03648708edfa142"
DEPS="go"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make
}

_install()
{
	make PREFIX=$NAME/$FAKEROOT/usr install
}
