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
	go build
}

_install()
{
	cp -vf $PWD/fzf         $FAKEROOT/$NAME/usr/bin/fzf
	cp -vf $PWD/man/man1/*  $FAKEROOT/$NAME/usr/share/man/man1/
}
