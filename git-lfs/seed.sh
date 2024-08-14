# shellcheck disable=SC2034
NAME="git-lfs"
DESC="Git extension for versioning large files"
VERSION="3.5.1"
SOURCE="https://github.com/git-lfs/git-lfs/releases/download/v${VERSION}/git-lfs-v${VERSION}.tar.gz"
CHECKSUM="203cd0e0ad107e222e1517779da69cce"
DEPS="go"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	make
}

_install()
{
	cp -vf "$PWD/bin/git-lfs" "$FAKEROOT/$NAME/usr/bin/git-lfs"
}
