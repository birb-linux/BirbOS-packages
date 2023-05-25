NAME="mupdf"
DESC="A lightweight PDF and XPS viewer"
VERSION="1.21.1"
SOURCE="https://www.mupdf.com/downloads/archive/mupdf-${VERSION}-source.tar.gz"
CHECKSUM="62690ebb86e3683d331554433e58c10a"
DEPS="glu xorg-libs harfbuzz libjpeg-turbo openjpeg curl freetype zlib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}-source
}

_build()
{
	# Fix an issue with the Makefile related to linking against a shared library
	sed -i '/MU.*_EXE. :/{
        s/\(.(MUPDF_LIB)\)\(.*\)$/\2 | \1/
        N
        s/$/ -lmupdf -L$(OUT)/
        }' Makefile

	cat > user.make << EOF &&
USE_SYSTEM_FREETYPE := yes
USE_SYSTEM_HARFBUZZ := yes
USE_SYSTEM_JBIG2DEC := no
USE_SYSTEM_JPEGXR := no # not used without HAVE_JPEGXR
USE_SYSTEM_LCMS2 := no # need lcms2-art fork
USE_SYSTEM_LIBJPEG := yes
USE_SYSTEM_MUJS := no # build needs source anyway
USE_SYSTEM_OPENJPEG := yes
USE_SYSTEM_ZLIB := yes
USE_SYSTEM_GLUT := no # need freeglut2-art fork
USE_SYSTEM_CURL := yes
USE_SYSTEM_GUMBO := no
EOF

	export XCFLAGS=-fPIC
	make -j${BUILD_JOBS} build=release shared=no
	unset XCFLAGS
}

_install()
{
   	 make prefix=/usr \
         DESTDIR=$FAKEROOT/$NAME                \
		 shared=yes                             \
		 docdir=/usr/share/doc/mupdf-${VERSION} \
		 install

	chmod 755 $FAKEROOT/$NAME/usr/lib/libmupdf.so

	# Default to mupdf-x11 backend instead of mupdf-gl
	ln -sfv mupdf-x11 $FAKEROOT/$NAME/usr/bin/mupdf
}
