NAME="meson"
DESC="Build system designed to be both extremely fast and as user friendly as possible"
VERSION="1.4.0"
SOURCE="https://github.com/mesonbuild/meson/releases/download/${VERSION}/meson-${VERSION}.tar.gz"
CHECKSUM="a5cddd4299ead830106242c53ea7f10f"
DEPS="python3 wheel"
FLAGS="python important"

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
	pip3 install --no-index --find-links $FAKEROOT/$NAME/$PYTHON_DIST meson
	install -vDm644 data/shell-completions/bash/meson $FAKEROOT/$NAME/usr/share/bash-completion/completions/meson
	install -vDm644 data/shell-completions/zsh/_meson $FAKEROOT/$NAME/usr/share/zsh/site-functions/_meson
}
