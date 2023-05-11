NAME="go"
DESC="Compiler and other tools for the go programming language"
VERSION="1.20.4"
SOURCE="https://go.dev/dl/go${VERSION}.src.tar.gz"
CHECKSUM="2ea74f4e87758e0fbeb4cc6d04d2e020"
DEPS="wget"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}

	# If go isn't installed, download a binary release to help with compiling
	if [ ! -f /usr/bin/go ]
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
	PATH="$PATH:$BOOTSTRAP_GO_PATH" GOROOT_FINAL="/opt/go" ./make.bash
}

_install()
{
	# Remove any precompiled binaries
	rm -rf /tmp/birb_package_build/go/go /tmp/birb_package_build/go/go${VERSION}.linux-amd64.tar.gz

	mkdir -p $FAKEROOT/$NAME/opt
	cp -r /tmp/birb_package_build/go $FAKEROOT/$NAME/opt/go

	# Make sure that go gets added to $PATH
	mkdir -p $FAKEROOT/$NAME/etc/profile.d
	echo 'export PATH="$PATH:/opt/go/bin"' > $FAKEROOT/$NAME/etc/profile.d/go.sh

	echo "Source /etc/profile to update the \$PATH variable"
}
