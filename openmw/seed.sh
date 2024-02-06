NAME="openmw"
DESC="Open-source open-world RPG game engine that supports playing Morrowind"
VERSION="0.48.0"
SOURCE="https://github.com/OpenMW/openmw/releases/download/openmw-${VERSION}/openmw-${VERSION}-Linux-64Bit.tar.gz"
CHECKSUM="2518bea72f141ff2acf5fae5fdefc41f"
DEPS=""
FLAGS="proprietary"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
}

_build()
{
	printf ""
}

_install()
{
	# Move the engine files to /opt directory
	mkdir "$FAKEROOT/$NAME/opt"
	mv ${NAME}-${VERSION}-Linux-64Bit "$FAKEROOT/$NAME/opt/$NAME"

	# Create symlinks for the binaries
	ln -sr "$FAKEROOT/$NAME/opt/$NAME"/{bsatool,esmtool,niftest,openmw,openmw-bulletobjecttool,openmw-cs,openmw-essimporter,openmw-iniimporter,openmw-launcher,openmw-navmeshtool,openmw-wizard} "$FAKEROOT/$NAME/usr/bin/"
}
