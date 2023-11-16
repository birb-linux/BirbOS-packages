NAME="rs-flip"
DESC="RuneScape flipping utility to make GE standing more profitable"
VERSION="1.2.1"
SOURCE="http://birbgitfh224rep6tmdofmr6qlo6wx43umqzt3hjubnncr55sdlfmtad.onion/toasterbirb/RS-Flip/archive/${VERSION}.tar.gz"
CHECKSUM="86a79ee550a2037d8c623ddb6a72b3b7"
DEPS="cmake json-nlohmann doctest"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd rs-flip
}

_build()
{
	mkdir build
	cd    build

	cmake ..
	make -j${BUILD_JOBS}
}

_install()
{
	install -v -m755 ./flip $FAKEROOT/$NAME/usr/bin
}
