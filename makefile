# This file demonstrates how to compile the YSF project on Linux.
#
# To compile YSF do:
#
# make YSF
#

GPP = g++ -D _GLIBCXX_USE_CXX11_ABI=0 -m32 -std=c++11 -Ilib -fno-stack-protector -nodefaultlibs
GCC = gcc -D _GLIBCXX_USE_CXX11_ABI=0 -m32 -Ilib -fno-stack-protector -nodefaultlibs
LINK = $(GCC)
YSF_OUTFILE = "./YSF.so"

COMPILE_FLAGS = -c -O3 -fPIC -w -DLINUX

YSF = -D YSF $(COMPILE_FLAGS)

all: YSF

clean:
	-rm -f *~ *.o *.so
  
static: GPP = g++ -D _GLIBCXX_USE_CXX11_ABI=0 -m32 -std=c++11 -Ilib -fno-stack-protector -static-libgcc -static-libstdc++
static: GCC = gcc -D _GLIBCXX_USE_CXX11_ABI=0 -m32 -Ilib -fno-stack-protector -static-libgcc -static-libstdc++
static: LINK = $(GPP)
static: all

YSF: clean
	$(GPP) $(YSF) ./lib/sdk/*.cpp
	$(GPP) $(YSF) ./lib/raknet/*.cpp
	$(GCC) $(YSF) ./lib/subhook/subhook.c
	$(GPP) $(YSF) ./src/*.cpp
	$(GPP) $(YSF) ./src/natives/*.cpp	
	$(GPP) $(YSF) ./src/includes/*.cpp	
	$(LINK) -fshort-wchar -shared -o $(YSF_OUTFILE) *.o
