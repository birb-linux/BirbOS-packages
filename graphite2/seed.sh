NAME="graphite2"
DESC="Rendering engine for graphite fonts"
VERSION="1.3.14"
SOURCE="https://github.com/silnrsi/graphite/releases/download/${VERSION}/graphite2-${VERSION}.tgz"
CHECKSUM="1bccb985a7da01092bfb53bb5041e836"
DEPS="cmake"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Remove tests that are known to fail without the FontTools
	# python 3 module
	sed -i '/cmptest/d' tests/CMakeLists.txt

	mkdir build
	cd    build

	cmake -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr ..

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} test
}
