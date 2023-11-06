NAME="extra-cmake-modules"
DESC="Extra CMake modules used by KDE Frameworks 5 and other packages like fcitx"
VERSION="5.103.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.kde.org/stable/frameworks/${SHORT_VERSION}/extra-cmake-modules-${VERSION}.tar.xz"
CHECKSUM="ac7d7a883f8ecd2dab262a284981ad64"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Prevent applications from installing stuff to a lib64 sub-directory
	sed -i '/"lib64"/s/64//' kde-modules/KDEInstallDirsCommon.cmake

	# Protect the global cmake PACKAGE_PREFIX_DIR variable
	sed -e '/PACKAGE_INIT/i set(SAVE_PACKAGE_PREFIX_DIR "${PACKAGE_PREFIX_DIR}")' \
		-e '/^include/a set(PACKAGE_PREFIX_DIR "${SAVE_PACKAGE_PREFIX_DIR}")' \
		-i ECMConfig.cmake.in

	mkdir build
	cd    build

	cmake -DCMAKE_INSTALL_PREFIX=/usr ..
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
