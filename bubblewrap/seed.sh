NAME="bubblewrap"
DESC="Setuid implementation of user namespaces, or sandboxing, that provides access to a subset of kernel user namespace features"
VERSION="0.7.0"
SOURCE="https://github.com/containers/bubblewrap/releases/download/v${VERSION}/bubblewrap-${VERSION}.tar.xz"
CHECKSUM="37892167cbc3bd2a54b396033892e2ae"
DEPS=""
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

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_test()
{
	# Fix an issue with merged /usr configuration in LFS
	sed 's@symlink usr/lib64@ro-bind-try /lib64@' -i ../tests/libtest.sh
	ninja test
}
