NAME="llvm"
DESC="A collection of modular and reusable compiler and toolchain technologies"
VERSION="15.0.7"
SOURCE="https://github.com/llvm/llvm-project/releases/download/llvmorg-${VERSION}/llvm-${VERSION}.src.tar.xz"
CHECKSUM="c77db4c71e1eb267358204dffe2c6e10"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)

	println "Downloading some extra stuff that is needed to build LLVM"
	wget https://anduin.linuxfromscratch.org/BLFS/llvm/llvm-cmake-${VERSION}.src.tar.xz
	[ "$(md5sum "llvm-cmake-${VERSION}.src.tar.xz" | cut -d' ' -f1)" != "c3647d253f67ce255e1aba014e528f5b" ] && echo "md5 mismatch with llvm-cmake-${VERSION}.src.tar.xz" && exit 1

	wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${VERSION}/clang-${VERSION}.src.tar.xz
	[ "$(md5sum "clang-${VERSION}.src.tar.xz" | cut -d' ' -f1)" != "a6d0141e50b48f5e60c682277dac83b4" ] && echo "md5 mismatch with clang-${VERSION}.src.tar.xz" && exit 1

	wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${VERSION}/compiler-rt-${VERSION}.src.tar.xz
	[ "$(md5sum "compiler-rt-${VERSION}.src.tar.xz" | cut -d' ' -f1)" != "12e6777354f0121cbe73ef13342a9302" ] && echo "md5 mismatch with compiler-rt-${VERSION}.src.tar.xz" && exit 1

	cd ${NAME}-${VERSION}.src
}

_build()
{
	# Extract and setup llvm-cmake
	tar -xf ../llvm-cmake-${VERSION}.src.tar.xz
	sed "/LLVM_COMMON_CMAKE_UTILS/s@../cmake@cmake-${VERSION}.src@" \
		-i CMakeLists.txt

	# Install clang into the source tree
	tar -xf ../clang-${VERSION}.src.tar.xz -C tools
	mv tools/clang-${VERSION}.src tools/clang

	# Install compiler-rt into the source tree
	tar -xf ../compiler-rt-${VERSION}.src.tar.xz -C projects
	mv projects/compiler-rt-${VERSION}.src projects/compiler-rt

	# Make sure that python scripts know to call python3
	grep -rl '#!.*python' | xargs sed -i '1s/python$/python3/'

	# Apply a clang patch that enables Stack Smash Protection by default in compiled programs
	patch -Np2 -d tools/clang < $PKG_PATH/clang-15.0.7-enable_default_ssp-1.patch

	# Build llvm
	mkdir -v build
	cd       build

	CC=gcc CXX=g++                                   \
	cmake -DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr \
		  -DLLVM_ENABLE_FFI=ON                       \
		  -DCMAKE_BUILD_TYPE=Release                 \
		  -DLLVM_BUILD_LLVM_DYLIB=ON                 \
		  -DLLVM_LINK_LLVM_DYLIB=ON                  \
		  -DLLVM_ENABLE_RTTI=ON                      \
		  -DLLVM_TARGETS_TO_BUILD="host;AMDGPU;BPF"  \
		  -DLLVM_BINUTILS_INCDIR=/usr/include        \
		  -DLLVM_INCLUDE_BENCHMARKS=OFF              \
		  -DCLANG_DEFAULT_PIE_ON_LINUX=ON            \
		  -Wno-dev -G Ninja ..
	ninja
}

_install()
{
	ninja install
	cp bin/FileCheck $FAKEROOT/$NAME/usr/bin
}
