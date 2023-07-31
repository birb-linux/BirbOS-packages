NAME="sqlite"
DESC="Self-contained, serverless, zero-configuration, transactional SQL database engine"
VERSION="3400100"
SOURCE="https://sqlite.org/2022/sqlite-autoconf-${VERSION}.tar.gz"
CHECKSUM="42175b1a1d23529cb133bbd2b5900afd"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd sqlite-autoconf-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static  \
            --enable-fts5     \
            CPPFLAGS="-DSQLITE_ENABLE_FTS3=1            \
                      -DSQLITE_ENABLE_FTS4=1            \
                      -DSQLITE_ENABLE_COLUMN_METADATA=1 \
                      -DSQLITE_ENABLE_UNLOCK_NOTIFY=1   \
                      -DSQLITE_ENABLE_DBSTAT_VTAB=1     \
                      -DSQLITE_SECURE_DELETE=1          \
                      -DSQLITE_ENABLE_FTS3_TOKENIZER=1"

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
