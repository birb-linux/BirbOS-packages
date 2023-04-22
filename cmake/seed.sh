NAME="cmake"
DESC="Modern toolset used for generating Makefiles"
VERSION="3.26.3"
SOURCE="https://cmake.org/files/v$(echo $VERSION | awk -F '.' '{print $1 "." $2}')/cmake-${VERSION}.tar.gz"
CHECKSUM="a99c7c7d5d127834ff3923b4cd4a1612"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i '/"lib64"/s/64//' Modules/GNUInstallDirs.cmake

	./bootstrap --prefix=$FAKEROOT/$NAME/usr \
				--system-libs        \
				--mandir=/share/man  \
				--no-system-jsoncpp  \
				--no-system-librhash \
				--docdir=/share/doc/cmake-${VERSION}

	make -j$(nproc)
}

_install()
{
	make install
}

_test()
{
	# FindBoost test is known to fail
	set +e
	LC_ALL=en_US.UTF-8 bin/ctest -j$(nproc) -O cmake-${VERSION}-test.log
	set -e
}
