NAME="pipewire"
DESC="Server and userspace API for handling multimedia pipelines"
VERSION="0.3.66"
SOURCE="https://github.com/PipeWire/pipewire/archive/${VERSION}/pipewire-${VERSION}.tar.gz"
CHECKSUM="8a85d990c159409578b456f8c8dcf075"
DEPS="alsa-lib"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=$FAKEROOT/$NAME/usr --buildtype=release -Dsession-managers= ..
	ninja
}

_install()
{
	ninja install
}

_test()
{
	ninja test
}
