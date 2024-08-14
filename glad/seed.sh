NAME="glad"
DESC="Generator for loading Vulkan, OpenGL, EGL, GLES, and GLX contexts"
VERSION="2.0.5"
SOURCE="https://github.com/Dav1dde/glad/archive/refs/tags/v${VERSION}/glad-${VERSION}.tar.gz"
CHECKSUM="7bd99cc337608d9cad42b861ccc0e28e"
DEPS="python3"
FLAGS="python"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	pip3 wheel -w $FAKEROOT/$NAME/$PYTHON_DIST --no-build-isolation --no-deps $PWD
}

_install()
{
	pip3 install --no-index --find-links=$FAKEROOT/$NAME/$PYTHON_DIST --no-cache-dir --no-user glad2
}
