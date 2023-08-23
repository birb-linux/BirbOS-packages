NAME="protobuf"
DESC="Protocol Buffers - Google's data interchange format"
VERSION="24.0"
SOURCE="https://github.com/protocolbuffers/protobuf/releases/download/v${VERSION}/protobuf-${VERSION}.tar.gz"
CHECKSUM="efcc79da4c891186d24b2a70da484da1"
DEPS="cmake abseil-cpp"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	cmake .                              \
		-DCMAKE_CXX_STANDARD=17          \
		-Dprotobuf_ABSL_PROVIDER=package \
		-Dprotobuf_BUILD_TESTS=OFF       \
		-DCMAKE_INSTALL_PREFIX=/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
