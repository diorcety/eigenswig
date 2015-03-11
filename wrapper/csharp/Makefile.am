## Process this file with automake to produce Makefile.in
.NOTPARALLEL:

if BUILD_WRAPPER_CSHARP

AM_CPPFLAGS=\
	-I$(top_srcdir)/src

COMMON_CFLAGS=\
	$(EIGEN3_CFLAGS)

SWIG_CFLAGS=$(COMMON_CFLAGS)

CSHARP_PACKAGE=org.eigen3
CSHARP_SRC=src

lib_LTLIBRARIES = libeigen3_csharp.la

libeigen3_csharp_la_SOURCES = eigen3_wrap.cpp
libeigen3_csharp_la_CXXFLAGS = $(COMMON_CFLAGS) $(STRICT_OPTIONS) $(PYTHON_CPPFLAGS) -std=c++0x
libeigen3_csharp_la_LDFLAGS = -avoid-version -Wl,-no-undefined
libeigen3_csharp_la_LIBADD = -llinphone_csharp $(LINPHONE_LIBS) $(MEDIASTREAMER_LIBS) $(FREEJ_LIBS)

eigen3_wrap.cpp: $(top_srcdir)/wrapper/swig/*.i
	mkdir -p $(CSHARP_SRC)
	$(SWIG) $(SWIG_CFLAGS) -c++ -csharp -dllimport libeigen3_csharp.dll -namespace $(CSHARP_PACKAGE) -outdir $(CSHARP_SRC) -o $@ $(top_srcdir)/wrapper/swig/eigen3.i

clean-local:
	rm -rf eigen3.xml eigen3.py eigen3.pyc eigen3_wrap.cpp eigen3_wrap.h
	rm -rf $(CSHARP_SRC)
if BUILD_WRAPPER_CSHARP_LIB
	rm -rf *.netmodule *.dll
endif

libeigen3_csharp.netmodule:
#	$(GMCS) $(GMCS_FLAGS) -target:module -out:libeigen3_csharp.netmodule $(CSHARP_SRC)/*.cs

libeigen3_csharp.dll:
#	$(GMCS) $(GMCS_FLAGS) -target:library -out:libeigen3_csharp.dll $(CSHARP_SRC)/*.cs

if BUILD_WRAPPER_CSHARP_LIB
all-local: libeigen3_csharp.netmodule libeigen3_csharp.dll

endif

endif
