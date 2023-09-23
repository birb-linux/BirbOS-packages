NAME="go"
DESC="Compiler and other tools for the go programming language"
VERSION="1.20.4"
SOURCE="https://go.dev/dl/go${VERSION}.src.tar.gz"
CHECKSUM="2ea74f4e87758e0fbeb4cc6d04d2e020"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}

	# If go isn't installed, download a binary release to help with compiling
	if [ ! -f /opt/go/bin/go ]
	then
		println "Downloading go binaries needed for compiling go"
		wget https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz
		tar -xf go${VERSION}.linux-amd64.tar.gz

		BOOTSTRAP_GO_PATH="$(pwd)/go/bin"
	fi
}

_build()
{
	cd src
	mkdir -p /usr/share/go
	PATH="$PATH:$BOOTSTRAP_GO_PATH" GOROOT_FINAL="/opt/go" GOROOT_BOOTSTRAP="/opt/go" GOPATH="/usr/share/go" ./make.bash
}

_install()
{
	# Remove any precompiled binaries
	rm -rf $TEMPORARY_BUILD_DIR/go/go $TEMPORARY_BUILD_DIR/go/go${VERSION}.linux-amd64.tar.gz

	mkdir -p $FAKEROOT/$NAME/opt
	cp -r $TEMPORARY_BUILD_DIR/go $FAKEROOT/$NAME/opt/go

	# Make sure that go gets added to $PATH
	ln -sfvr $FAKEROOT/$NAME/opt/go/bin/{go,gofmt} $FAKEROOT/$NAME/usr/bin/
}
