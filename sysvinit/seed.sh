NAME="sysvinit"
DESC="Programs for controlling the startup, running and shutdown of the system"
VERSION="3.07"
SOURCE="https://github.com/slicer69/sysvinit/releases/download/${VERSION}/sysvinit-${VERSION}.tar.xz"
CHECKSUM="190398c660af29c97d892126d2a95e28"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Apply a patch that removes several programs installed by other packages,
	# clarify messages and fix a compiler warning
	patch -Np1 -i $PKG_PATH/sysvinit-3.07-consolidated-1.patch

	make -j$(nproc)
}

_install()
{
	make install
}
