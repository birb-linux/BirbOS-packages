NAME="massren"
DESC="Easily rename multiple files using your text editor"
VERSION="1.5.6"
SOURCE="https://github.com/laurent22/massren/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="386296d9466407e54d8af849fc3b2925"
DEPS="go"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	export GOPATH=$PWD/go_modules
	go mod init
	go build -mod=mod
}

_install()
{
	cp -vf $PWD/massren $FAKEROOT/$NAME/usr/bin/massren
}
