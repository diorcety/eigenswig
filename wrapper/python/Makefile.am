## Process this file with automake to produce Makefile.in
.NOTPARALLEL:

if BUILD_WRAPPER_PYTHON

AM_CPPFLAGS=\
	-I$(top_srcdir)/src

COMMON_CFLAGS=\
	$(EIGEN3_CFLAGS)

SWIG_CFLAGS=$(COMMON_CFLAGS)

pkgpython_PYTHON = \
	eigen3.py \
	__init__.py

pkgpyexec_LTLIBRARIES = libeigen3_python.la

libeigen3_python_la_SOURCES = eigen3_wrap.cpp
libeigen3_python_la_CXXFLAGS = $(COMMON_CFLAGS) $(PYTHON_CPPFLAGS) $(STRICT_OPTIONS) -std=c++0x -Wno-unused-but-set-variable
libeigen3_python_la_LDFLAGS = $(PYTHON_LDFLAGS) -avoid-version -module -Wl,-no-undefined
libeigen3_python_la_LIBADD = -L$(pyexecdir)/linphone -llinphone_python $(LINPHONE_LIBS) $(MEDIASTREAMER_LIBS) $(FREEJ_LIBS)

eigen3_wrap.cpp: $(top_srcdir)/wrapper/swig/*.i
	$(SWIG) $(SWIG_CFLAGS) -c++ -python -interface libeigen3_python -o $@ $(top_srcdir)/wrapper/swig/eigen3.i

clean-local:
	rm -rf eigen3.xml eigen3.py eigen3.pyc eigen3_wrap.cpp eigen3_wrap.h

endif
