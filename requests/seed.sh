NAME="requests"
DESC="An elegant and simple HTTP library for Python"
VERSION="2.28.2"
SOURCE="https://files.pythonhosted.org/packages/source/r/requests/requests-${VERSION}.tar.gz"
CHECKSUM="09b752e0b0a672d805ae54455c128d42"
DEPS="charset-normalizer idna urllib3 make-ca p11-kit"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Apply a patch to fix issues with environmental variables related to make-ca
	patch -Np1 -i $PKG_PATH/requests-2.28.2-use_system_certs-1.patch

	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --no-user --find-links $FAKEROOT/$NAME/$PYTHON_DIST $NAME
}
