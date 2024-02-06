NAME="syncthing"
DESC="Continuous file synchronization program"
VERSION="1.26.0"
SOURCE="https://github.com/syncthing/syncthing/releases/download/v${VERSION}/syncthing-source-v${VERSION}.tar.gz"
CHECKSUM="f746b4530dc90c44a5d3afff3072a71e"
DEPS="go"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
}

_build()
{
	export GOPATH=$PWD/go_modules
	go run build.go
}

_install()
{
	cp -v ./bin/* $FAKEROOT/$NAME/usr/bin/
	cp -v ./man/*.1 $FAKEROOT/$NAME/usr/share/man/man1/
	cp -v ./man/*.5 $FAKEROOT/$NAME/usr/share/man/man5/
	cp -v ./man/*.7 $FAKEROOT/$NAME/usr/share/man/man7/
}
